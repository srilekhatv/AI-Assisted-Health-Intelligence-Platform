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

-- Assign role to current user
SELECT CURRENT_USER();
GRANT ROLE HOSPITAL_ROLE TO USER SRITV;

USE ROLE HOSPITAL_ROLE;
SELECT CURRENT_ROLE();