-- =====================================================
-- File: hospital_db.sql
-- Purpose: Create project database and schemas
-- Project: Healthcare Claims Analytics (Inpatient)
-- =====================================================

USE ROLE HOSPITAL_ROLE;
SELECT CURRENT_ROLE();

-- Create database for hospital analytics
CREATE DATABASE HOSPITAL_DB;

-- Create schemas for layered architecture
CREATE SCHEMA HOSPITAL_DB.RAW;
CREATE SCHEMA HOSPITAL_DB.STAGING;
CREATE SCHEMA HOSPITAL_DB.ANALYTICS;