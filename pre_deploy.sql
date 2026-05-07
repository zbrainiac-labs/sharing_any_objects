CREATE DATABASE IF NOT EXISTS {{ db }}
    COMMENT = 'Development database for ECO (Ecosystem) domain - secure file sharing';

CREATE SCHEMA IF NOT EXISTS {{ db }}.ECO_DCM;
CREATE SCHEMA IF NOT EXISTS {{ db }}.{{ schema }}
    COMMENT = 'Raw data landing zone for ECO Sharing component';

CREATE DCM PROJECT IF NOT EXISTS {{ db }}.ECO_DCM.SHARING_OBJECTS;
