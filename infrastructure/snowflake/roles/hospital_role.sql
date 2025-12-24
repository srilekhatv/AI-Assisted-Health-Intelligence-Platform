-- =====================================================
-- File: hospital_role.sql
-- Purpose: Create project-specific Snowflake role
-- Project: Healthcare Claims Analytics (Inpatient)
-- =====================================================

-- Create role for hospital analytics project
CREATE ROLE IF NOT EXISTS HOSPITAL_ROLE;

-- Allow role to use compute warehouse
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE HOSPITAL_ROLE;

-- Allow role to create databases (needed for dbt workflows)
GRANT CREATE DATABASE ON ACCOUNT TO ROLE HOSPITAL_ROLE;

-- Assign role to project user
GRANT ROLE HOSPITAL_ROLE TO USER SRITV;

USE ROLE HOSPITAL_ROLE;
SELECT CURRENT_ROLE();

-- -----------------------------------------------------
-- Grant database usage
-- -----------------------------------------------------
-- Required so dbt can resolve database context
GRANT USAGE ON DATABASE HOSPITAL_DB TO ROLE HOSPITAL_ROLE;

-- -----------------------------------------------------
-- Grant schema-level permissions for dbt models
-- -----------------------------------------------------
-- Allows dbt to create and manage tables/views in STAGING
GRANT USAGE, CREATE TABLE, CREATE VIEW
ON SCHEMA HOSPITAL_DB.STAGING
TO ROLE HOSPITAL_ROLE;

-- -----------------------------------------------------
-- Grant privileges on future tables created by dbt
-- -----------------------------------------------------
-- Prevents permission failures on subsequent dbt runs
GRANT ALL PRIVILEGES
ON FUTURE TABLES
IN SCHEMA HOSPITAL_DB.STAGING
TO ROLE HOSPITAL_ROLE;
