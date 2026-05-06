CREATE DATABASE IF NOT EXISTS {{db}}
    COMMENT = 'Development database for ECO (Ecosystem) domain - secure file sharing';

USE DATABASE {{db}};

CREATE SCHEMA IF NOT EXISTS {{schema}}
    COMMENT = 'Raw data landing zone for ECO Sharing component';

CREATE DCM PROJECT IF NOT EXISTS {{db}}.{{schema}}.SHARING_OBJECTS;
