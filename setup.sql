-- =============================================================================
-- setup.sql — One-time ACCOUNTADMIN setup (not part of CI/CD pipeline)
-- =============================================================================
-- Run manually: snow sql -f setup.sql -c <admin_connection>
-- =============================================================================

USE ROLE ACCOUNTADMIN;

CREATE APPLICATION PACKAGE IF NOT EXISTS ECOS_RAW_SHARING TYPE = DATA
    COMMENT = 'Declarative share for secure multi-tenant file access';

CREATE OR REPLACE TEMPORARY STAGE ECO_DEV.ECO_RAW_v001.ECOS_RAW_ST_SHARING_MANIFEST;

COPY INTO @ECO_DEV.ECO_RAW_v001.ECOS_RAW_ST_SHARING_MANIFEST/manifest.yml FROM (
    SELECT $$roles:
  - app_user:
      comment: "Read-only access to the secure file download view"

shared_content:
  databases:
    - ECO_DEV:
        schemas:
          - ECO_RAW_v001:
              roles: [app_user]
              views:
                - ECOS_RAW_VW_STAGE_FILES_DOWNLOAD_MT:
                    roles: [app_user]
$$
)
FILE_FORMAT = (TYPE = CSV COMPRESSION = NONE FIELD_OPTIONALLY_ENCLOSED_BY = NONE ESCAPE = NONE ESCAPE_UNENCLOSED_FIELD = NONE)
SINGLE = TRUE OVERWRITE = TRUE;

COPY FILES INTO snow://package/ECOS_RAW_SHARING/versions/LIVE/
    FROM @ECO_DEV.ECO_RAW_v001.ECOS_RAW_ST_SHARING_MANIFEST
    FILES = ('manifest.yml');

ALTER APPLICATION PACKAGE ECOS_RAW_SHARING RELEASE LIVE VERSION;
