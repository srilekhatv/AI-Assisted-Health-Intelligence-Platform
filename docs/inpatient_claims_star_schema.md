# Inpatient Claims Star Schema — Design Documentation

## Project
AI-Assisted Healthcare Analytics Platform

## Domain
Claims & Cost Analytics (Medicare CMS)

## Dataset
CMS DE-SynPUF — Inpatient Claims (2008–2010)

## Status
Design Finalized — Execution Pending

## Last Updated
12-23-2025


## Objective
Design a clean, healthcare-grade star schema for Medicare inpatient claims
that supports cost, utilization, and length-of-stay analytics.

The design prioritizes:
- Correct grain definition
- Separation of facts and dimensions
- Reusability across CMS claim types
- Prevention of temporal and aggregation errors

## Source Datasets
- Inpatient Claims:
  DE1_0_2008_to_2010_Inpatient_Claims_Sample_1.csv

- Beneficiary Summary:
  - DE1_0_2008_Beneficiary_Summary_File_Sample_1.csv
  - DE1_0_2009_Beneficiary_Summary_File_Sample_1.csv
  - DE1_0_2010_Beneficiary_Summary_File_Sample_1.csv

## Fact Table Grain
The grain of the inpatient fact table is:

**One row = one inpatient claim (one hospital stay)**

This aligns with CMS inpatient billing logic, where each claim represents
a complete hospital admission and discharge event.


## Fact Table: fact_inpatient_claims
### Purpose
Stores event-level inpatient hospitalization data including
costs, utilization, and claim-level classifications.

### Primary Identifier
- clm_id (CMS claim identifier)

### Foreign Keys
- patient_key → dim_patient
- provider_key → dim_provider
- admit_date_key → dim_date
- discharge_date_key → dim_date

### Event Descriptor
- drg_code (Diagnosis Related Group)

### Utilization Metrics
- utilization_day_count
- length_of_stay (derived)

### Financial Metrics
- claim_payment_amt
- primary_payer_paid_amt
- beneficiary_deductible_amt
- coinsurance_amt
- blood_deductible_amt
- pass_thru_per_diem_amt


## DRG Placement Rationale
DRG is stored in the fact table because:
- There is exactly one DRG per inpatient claim
- DRG classifies the entire hospitalization event
- DRG directly drives Medicare reimbursement
- DRG is an event-level attribute, not a descriptive entity

Placing DRG in a dimension would incorrectly separate it
from the costs and utilization it defines.

## Dimension: dim_patient
### Grain
One row per unique beneficiary (DESYNPUF_ID)

### Attributes
- patient_key (PK)
- desynpuf_id (business key)
- date_of_birth
- sex
- race
- state_code
- county_code
- esrd_indicator

### Design Notes
- Age is derived at query time using admission date
- Chronic conditions are excluded due to time dependency

## Dimension: dim_provider
### Grain
One row per provider institution (PRVDR_NUM)

### Attributes
- provider_key (PK)
- prvdr_num (business key)
- provider_type
- data_source

### Design Notes
- Provider represents the hospital/facility, not physicians
- Physician NPIs are excluded to avoid many-to-many complexity

## Dimension: dim_date
### Grain
One row per calendar day

### Core Attributes
- date_key (YYYYMMDD)
- full_date
- day
- month
- month_name
- year
- quarter
- day_of_week
- is_weekend

### Usage
- Role-playing dimension used for:
  - Admission date
  - Discharge date


## Relationship Cardinality
- dim_patient → fact_inpatient_claims : 1-to-many
- dim_provider → fact_inpatient_claims : 1-to-many
- dim_date → fact_inpatient_claims     : 1-to-many
- claim → DRG                          : 1-to-1


## Deferred Modeling Decisions
The following are intentionally excluded from the initial schema:

- Diagnosis codes (ICD) → require bridge tables
- Procedure codes (ICD / HCPCS) → many-to-many
- Chronic condition flags → time-dependent
- Physician-level modeling → separate dimension

These will be modeled in later phases after the core schema is stable.


## Design Lock
This star schema design is finalized and locked.

No changes to:
- Fact grain
- Dimension boundaries
- Key relationships

All future work will focus on execution and data transformation.
