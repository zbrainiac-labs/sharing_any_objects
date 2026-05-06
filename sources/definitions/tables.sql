DEFINE TABLE {{db}}.{{schema}}.ECOS_RAW_TB_STAGE_FILES_MT (
    TENANT_ID          VARCHAR(256) NOT NULL COMMENT 'Identifies the owning tenant (e.g. BANK1, BANK2) used for row-level access filtering',
    BUSINESS_UNIT      VARCHAR(256) NOT NULL COMMENT 'Organizational business unit responsible for the file (e.g. TRADING, COMPLIANCE, OPERATIONS)',
    FILE_TYPE          VARCHAR(256) NOT NULL COMMENT 'Classification of the document (e.g. INVOICE, REPORT, CONTRACT, STATEMENT)',
    FILE_NAME          VARCHAR(512) NOT NULL COMMENT 'Original file name as uploaded by the user',
    FILE_PATH          VARCHAR(1024) NOT NULL COMMENT 'Relative path within the shared stage ECOS_RAW_ST_DOC_MT',
    FILE_SIZE          NUMBER(38,0) COMMENT 'File size in bytes at time of upload',
    LAST_MODIFIED      TIMESTAMP_TZ COMMENT 'Last modification timestamp from the source system (if available)',
    REFRESHED_AT       TIMESTAMP_TZ DEFAULT CURRENT_TIMESTAMP() COMMENT 'Timestamp when the file metadata was last registered or updated',
    ASSIGNED_CONTACTS  VARCHAR(2048) COMMENT 'Comma-separated list of contact identifiers notified on file availability'
)
COMMENT = 'Multi-tenancy file registry - each row represents a file uploaded to the shared stage ECOS_RAW_ST_DOC_MT tagged with tenant, business unit, and file type for row-level access control';

DEFINE TABLE {{db}}.{{schema}}.ECOS_RAW_TB_CONSUMER_ROLE_MAPPING (
    CONSUMER_ACCOUNT  VARCHAR(256) NOT NULL COMMENT 'Snowflake account locator of the consumer (e.g. GK68488) for cross-account access',
    CONSUMER_ROLE     VARCHAR(256) NOT NULL COMMENT 'Role name in the consumer account that is granted access',
    TENANT_ID         VARCHAR(256) NOT NULL COMMENT 'Tenant identifier linking the consumer account to the correct file set'
)
COMMENT = 'Maps consumer account locators to tenant IDs for cross-account listing access via row access policy';
