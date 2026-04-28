DEFINE TABLE {{db}}.{{schema}}.ECOS_RAW_TB_STAGE_FILES_MT (
    TENANT_ID          VARCHAR(256) NOT NULL,
    FILE_NAME          VARCHAR(512) NOT NULL,
    FILE_PATH          VARCHAR(1024) NOT NULL,
    FILE_SIZE          NUMBER(38,0),
    LAST_MODIFIED      TIMESTAMP_TZ,
    REFRESHED_AT       TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP(),
    ASSIGNED_CONTACTS  VARCHAR(2048)
)
COMMENT = 'Multi-tenancy file registry - each row represents a file uploaded to the shared stage ECOS_RAW_ST_DOC_MT tagged with a tenant identifier for row-level access control';

DEFINE TABLE {{db}}.{{schema}}.ECOS_RAW_TB_CONSUMER_ROLE_MAPPING (
    CONSUMER_ACCOUNT  VARCHAR(256) NOT NULL,
    CONSUMER_ROLE     VARCHAR(256) NOT NULL,
    TENANT_ID         VARCHAR(256) NOT NULL
)
COMMENT = 'Maps consumer account locators to tenant IDs for cross-account listing access via row access policy';
