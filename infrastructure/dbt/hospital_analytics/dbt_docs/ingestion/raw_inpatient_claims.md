# RAW Inpatient Claims Load (CMS DE-SynPUF)

**Domain:** Claims & Cost Intelligence  
**Claim Type:** Inpatient  
**Layer:** RAW (Snowflake)  
**Dataset:** CMS DE-SynPUF (Inpatient Claims)

---

## 1. Purpose of This Document

This document records the **end-to-end RAW ingestion process** for the **CMS DE-SynPUF Inpatient Claims** dataset into Snowflake.

The goal of the RAW layer is to:
- Preserve source data **exactly as delivered** by CMS
- Avoid transformations or business logic
- Serve as an auditable system-of-record for downstream staging and analytics

No analytical assumptions are made at this stage.

---

## 2. Database and Schema Context

All objects are created under:

- **Database:** `HOSPITAL_DB`
- **Schema:** `RAW`

```sql
USE DATABASE HOSPITAL_DB;
USE SCHEMA RAW;
```

---

## 3. External Stage Creation

An internal Snowflake stage is created to hold the source CSV file.

```sql
CREATE STAGE CLAIMS_STAGE;
```

**Purpose:**
- Acts as the landing location for CMS DE-SynPUF inpatient claim files
- Decouples file storage from table definitions

---

## 4. RAW Table Definition — `inpatient_claims`

The RAW table mirrors the CMS DE-SynPUF inpatient claims file structure.

### Key Design Decisions

- **All date fields are stored as STRING**
  - CMS dates are delivered in `YYYYMMDD` format
  - Parsing is deferred to the staging layer
- **No renaming of source columns**
- **No derived or calculated fields**

```sql
CREATE TABLE inpatient_claims (
    DESYNPUF_ID STRING,
    CLM_ID STRING,
    SEGMENT STRING,

    CLM_FROM_DT STRING,
    CLM_THRU_DT STRING,
    CLM_ADMSN_DT STRING,
    NCH_BENE_DSCHRG_DT STRING,

    PRVDR_NUM STRING,
    CLM_PMT_AMT NUMBER,
    NCH_PRMRY_PYR_CLM_PD_AMT NUMBER,

    AT_PHYSN_NPI STRING,
    OP_PHYSN_NPI STRING,
    OT_PHYSN_NPI STRING,

    ADMTNG_ICD9_DGNS_CD STRING,
    CLM_PASS_THRU_PER_DIEM_AMT NUMBER,
    NCH_BENE_IP_DDCTBL_AMT NUMBER,
    NCH_BENE_PTA_COINSRNC_LBLTY_AMT NUMBER,
    NCH_BENE_BLOOD_DDCTBL_LBLTY_AMT NUMBER,
    CLM_UTLZTN_DAY_CNT NUMBER,
    CLM_DRG_CD STRING,

    ICD9_DGNS_CD_1 STRING,
    ICD9_DGNS_CD_2 STRING,
    ICD9_DGNS_CD_3 STRING,
    ICD9_DGNS_CD_4 STRING,
    ICD9_DGNS_CD_5 STRING,
    ICD9_DGNS_CD_6 STRING,
    ICD9_DGNS_CD_7 STRING,
    ICD9_DGNS_CD_8 STRING,
    ICD9_DGNS_CD_9 STRING,
    ICD9_DGNS_CD_10 STRING,

    ICD9_PRCDR_CD_1 STRING,
    ICD9_PRCDR_CD_2 STRING,
    ICD9_PRCDR_CD_3 STRING,
    ICD9_PRCDR_CD_4 STRING,
    ICD9_PRCDR_CD_5 STRING,
    ICD9_PRCDR_CD_6 STRING,

    HCPCS_CD_1 STRING,
    HCPCS_CD_2 STRING,
    HCPCS_CD_3 STRING,
    HCPCS_CD_4 STRING,
    HCPCS_CD_5 STRING,
    HCPCS_CD_6 STRING,
    HCPCS_CD_7 STRING,
    HCPCS_CD_8 STRING,
    HCPCS_CD_9 STRING,
    HCPCS_CD_10 STRING,
    HCPCS_CD_11 STRING,
    HCPCS_CD_12 STRING,
    HCPCS_CD_13 STRING,
    HCPCS_CD_14 STRING,
    HCPCS_CD_15 STRING,
    HCPCS_CD_16 STRING,
    HCPCS_CD_17 STRING,
    HCPCS_CD_18 STRING,
    HCPCS_CD_19 STRING,
    HCPCS_CD_20 STRING,
    HCPCS_CD_21 STRING,
    HCPCS_CD_22 STRING,
    HCPCS_CD_23 STRING,
    HCPCS_CD_24 STRING,
    HCPCS_CD_25 STRING,
    HCPCS_CD_26 STRING,
    HCPCS_CD_27 STRING,
    HCPCS_CD_28 STRING,
    HCPCS_CD_29 STRING,
    HCPCS_CD_30 STRING,
    HCPCS_CD_31 STRING,
    HCPCS_CD_32 STRING,
    HCPCS_CD_33 STRING,
    HCPCS_CD_34 STRING,
    HCPCS_CD_35 STRING,
    HCPCS_CD_36 STRING,
    HCPCS_CD_37 STRING,
    HCPCS_CD_38 STRING,
    HCPCS_CD_39 STRING,
    HCPCS_CD_40 STRING,
    HCPCS_CD_41 STRING,
    HCPCS_CD_42 STRING,
    HCPCS_CD_43 STRING,
    HCPCS_CD_44 STRING,
    HCPCS_CD_45 STRING
);
```

---

## 5. CSV File Format Definition

A dedicated CSV file format is created for claims data ingestion.

```sql
CREATE OR REPLACE FILE FORMAT CLAIMS_CSV_FORMAT
    TYPE = 'CSV'
    SKIP_HEADER = 1
    TRIM_SPACE = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '\"'
    NULL_IF = ('', 'NULL')
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;
```

### Rationale
- CMS files include headers → `SKIP_HEADER = 1`
- Quoted string fields are common
- Empty strings and explicit NULLs are treated consistently
- Column mismatch tolerance prevents load failures from trailing empty fields

---

## 6. Data Load — COPY INTO RAW Table

The inpatient claims CSV is loaded from the internal stage into the RAW table.

```sql
COPY INTO RAW.INPATIENT_CLAIMS
FROM @RAW.CLAIMS_STAGE/DE1_0_2008_to_2010_Inpatient_Claims_Sample_1.csv
FILE_FORMAT = (FORMAT_NAME = RAW.claims_csv_format)
ON_ERROR = 'ABORT_STATEMENT';
```

---

## 7. Post-Load Sanity Checks

### 7.1 Row Count

```sql
SELECT COUNT(*) AS row_count
FROM RAW.inpatient_claims;
```

Confirms successful ingestion and non-empty dataset.

---

### 7.2 Provider Identifier Validation

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(PRVDR_NUM) AS provider_not_null,
    COUNT(*) - COUNT(PRVDR_NUM) AS provider_null
FROM RAW.inpatient_claims;
```

Result:
- `PRVDR_NUM` has **0 NULL values**

---

### 7.3 Date Range Validation

```sql
SELECT
    MIN(CLM_FROM_DT) AS min_from_date,
    MAX(CLM_THRU_DT) AS max_thru_date
FROM RAW.inpatient_claims;
```

Result:
- Date values range from **2007 to 2010**
- Late-2007 start dates are expected for claims spanning into 2008

---

### 7.4 Sample Data Inspection

```sql
SELECT *
FROM RAW.inpatient_claims
LIMIT 10;
```

Used to visually verify:
- Column alignment
- Data types preserved as strings/numbers
- No shifted or malformed rows

---

## 8. Final Status

- RAW inpatient claims table successfully created
- CSV file loaded without errors
- Provider identifier validated
- Date values preserved in original `YYYYMMDD` format

The RAW layer for **Inpatient Claims** is now **complete and locked**.





