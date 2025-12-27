# RAW Beneficiary Data Ingestion — Snowflake (CMS DE-SynPUF)

This document captures the **exact, finalized steps** used to ingest the CMS DE-SynPUF **Beneficiary Summary Files** into Snowflake at the RAW layer.  
This is a **source-of-truth execution log** aligned with the official CMS documentation and the final, corrected schema.

---

## 1. Set Context

```sql
USE DATABASE HOSPITAL_DB;
USE SCHEMA RAW;
```

---

## 2. Create Internal Stage for Beneficiary Files

```sql
CREATE STAGE beneficiary_stage;
```

### Verify files in stage
```sql
LIST @BENEFICIARY_STAGE;
```

---

## 3. Create CSV File Format (CMS-Aligned)

```sql
CREATE OR REPLACE FILE FORMAT BENEFICIARY_CSV_FORMAT
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
NULL_IF = ('', 'NULL')
TRIM_SPACE = TRUE
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;
```

This file format is reusable and designed to safely ingest CMS CSV exports.

---

## 4. Create Beneficiary RAW Table Template (PDF-Aligned)

The column order below **exactly matches** the CMS DE-SynPUF Beneficiary Summary File.

```sql
CREATE OR REPLACE TABLE BENEFICIARY_TEMPLATE (
    DESYNPUF_ID                     VARCHAR,
    BENE_BIRTH_DT                   VARCHAR,
    BENE_DEATH_DT                   VARCHAR,
    BENE_SEX_IDENT_CD               VARCHAR,
    BENE_RACE_CD                    VARCHAR,
    BENE_ESRD_IND                   VARCHAR,
    SP_STATE_CODE                   VARCHAR,
    BENE_COUNTY_CD                  VARCHAR,
    BENE_HI_CVRAGE_TOT_MONS          VARCHAR,
    BENE_SMI_CVRAGE_TOT_MONS         VARCHAR,
    BENE_HMO_CVRAGE_TOT_MONS         VARCHAR,
    PLAN_CVRG_MOS_NUM               VARCHAR
);
```

---

## 5. Create Year-Specific RAW Tables

```sql
CREATE OR REPLACE TABLE BENEFICIARY_2008 LIKE BENEFICIARY_TEMPLATE;
CREATE OR REPLACE TABLE BENEFICIARY_2009 LIKE BENEFICIARY_TEMPLATE;
CREATE OR REPLACE TABLE BENEFICIARY_2010 LIKE BENEFICIARY_TEMPLATE;
```

---

## 6. Load CSV Data into RAW Tables

### 2008
```sql
COPY INTO RAW.BENEFICIARY_2008
FROM @RAW.BENEFICIARY_STAGE/DE1_0_2008_Beneficiary_Summary_File_Sample_1.csv
FILE_FORMAT = RAW.BENEFICIARY_CSV_FORMAT;
```

### 2009
```sql
COPY INTO RAW.BENEFICIARY_2009
FROM @RAW.BENEFICIARY_STAGE/DE1_0_2009_Beneficiary_Summary_File_Sample_1.csv
FILE_FORMAT = RAW.BENEFICIARY_CSV_FORMAT;
```

### 2010
```sql
COPY INTO RAW.BENEFICIARY_2010
FROM @RAW.BENEFICIARY_STAGE/DE1_0_2010_Beneficiary_Summary_File_Sample_1.csv
FILE_FORMAT = RAW.BENEFICIARY_CSV_FORMAT;
```

---

## 7. Validation Checks

### Row counts
```sql
SELECT COUNT(*) FROM RAW.BENEFICIARY_2008;
SELECT COUNT(*) FROM RAW.BENEFICIARY_2009;
SELECT COUNT(*) FROM RAW.BENEFICIARY_2010;
```

### Column sanity check
```sql
SELECT
    DESYNPUF_ID,
    BENE_ESRD_IND,
    SP_STATE_CODE,
    BENE_COUNTY_CD,
    BENE_HMO_CVRAGE_TOT_MONS,
    BENE_HI_CVRAGE_TOT_MONS,
    BENE_SMI_CVRAGE_TOT_MONS,
    PLAN_CVRG_MOS_NUM
FROM RAW.BENEFICIARY_2008
LIMIT 10;
```

Expected:
- ESRD indicator populated (`0/1`)
- State and county codes correctly aligned
- Coverage month fields between `0–12`

---

## 8. Outcome

✔ RAW beneficiary ingestion completed successfully  
✔ Schema aligned strictly to CMS DE-SynPUF PDF  
✔ Data validated and ready for dbt staging models  

**Next step:** Build `stg_beneficiary_2008 / 2009 / 2010` in dbt.
