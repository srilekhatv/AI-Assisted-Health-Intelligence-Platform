# Beneficiary Summary File — Variable Dictionary

This document describes each variable in the DE-SynPUF Beneficiary Summary File and its meaning,
based on the official CMS user manual. Source: CMS DE-SynPUF User Manual (2013). 


## Beneficiary Summary File — Variable Dictionary (Structured Table)

| Variable Name | Description | Category |
|---------------|-------------|----------|
| DESYNPUF_ID | Synthetic beneficiary identifier used for linking across files. | Identifier |
| BENE_BIRTH_DT | Date of birth. | Demographic |
| BENE_DEATH_DT | Date of death. | Demographic |
| BENE_SEX_IDENT_CD | Sex of beneficiary. | Demographic |
| BENE_RACE_CD | Race category. | Demographic |
| BENE_ESRD_IND | Indicator for End Stage Renal Disease. | Clinical |
| SP_STATE_CODE | State of residence. | Geographic |
| BENE_COUNTY_CD | County of residence. | Geographic |
| BENE_HI_CVRAGE_TOT_MONS | Number of months with Medicare Part A coverage. | Coverage |
| BENE_SMI_CVRAGE_TOT_MONS | Number of months with Medicare Part B coverage. | Coverage |
| BENE_HMO_CVRAGE_TOT_MONS | Number of months enrolled in Medicare Advantage (HMO). | Coverage |
| PLAN_CVRG_MOS_NUM | Number of months with Medicare Part D (drug plan) coverage. | Coverage |
| SP_ALZHDMTA | Chronic Condition: Alzheimer’s or related dementia. | Chronic Condition |
| SP_CHF | Chronic Condition: Congestive Heart Failure. | Chronic Condition |
| SP_CHRNKIDN | Chronic Condition: Chronic Kidney Disease. | Chronic Condition |
| SP_CNCR | Chronic Condition: Cancer. | Chronic Condition |
| SP_COPD | Chronic Condition: Chronic Obstructive Pulmonary Disease. | Chronic Condition |
| SP_DEPRESSN | Chronic Condition: Depression. | Chronic Condition |
| SP_DIABETES | Chronic Condition: Diabetes. | Chronic Condition |
| SP_ISCHMCHT | Chronic Condition: Ischemic Heart Disease. | Chronic Condition |
| SP_OSTEOPRS | Chronic Condition: Osteoporosis. | Chronic Condition |
| SP_RA_OA | Chronic Condition: Rheumatoid Arthritis / Osteoarthritis. | Chronic Condition |
| SP_STRKETIA | Chronic Condition: Stroke / TIA. | Chronic Condition |
| MEDREIMB_IP | Annual inpatient Medicare reimbursement amount. | Reimbursement |
| BENRES_IP | Annual inpatient beneficiary responsibility amount. | Reimbursement |
| PPPYMT_IP | Annual inpatient primary payer reimbursement amount. | Reimbursement |
| MEDREIMB_OP | Annual outpatient Medicare reimbursement amount. | Reimbursement |
| BENRES_OP | Annual outpatient beneficiary responsibility amount. | Reimbursement |
| PPPYMT_OP | Annual outpatient primary payer reimbursement amount. | Reimbursement |
| MEDREIMB_CAR | Annual carrier Medicare reimbursement amount. | Reimbursement |
| BENRES_CAR | Annual carrier beneficiary responsibility amount. | Reimbursement |
| PPPYMT_CAR | Annual carrier primary payer reimbursement amount. | Reimbursement |


## Analytical Use Cases for Beneficiary Summary Variables

This section describes how each group of variables can be used across different analytical domains
such as Claims & Cost Intelligence, Population Health, Risk Stratification, Digital Health Engagement,
and Revenue Cycle.

---

### 1. Demographics (Birth date, Sex, Race)
**Use cases:**
- Age-based risk stratification
- Disparities analysis (gender, race)
- Population segmentation
- Mortality analysis
- Readmission predictors

---

### 2. Geographic Variables (State, County)
**Use cases:**
- Regional cost variation analysis
- SDOH-linked risk models when combined with PLACES data
- Provider network performance by region
- Public health insights and hotspot detection

---

### 3. Coverage Variables (Part A, B, HMO, Part D months)
**Use cases:**
- Data completeness assessment (e.g., high HMO months → fewer FFS claims)
- Eligibility-based cohort construction
- Identifying dual-coverage complexity
- Predicting healthcare utilization
- Understanding prescription adherence windows (Part D)

---

### 4. Chronic Condition Indicators (SP_ variables)
**Use cases:**
- Risk score modeling (HCC-style approaches)
- Comorbidity indexing (Charlson-like logic)
- Predictive modeling for:
  - readmission
  - mortality
  - medication adherence
  - cost prediction
- Identifying high-risk cohorts for population health dashboards
- Creating condition-based subpopulations (e.g., diabetes + CHF)

---

### 5. Reimbursement & Payment Variables (MEDREIMB, BENRES, PPPYMT)
**Use cases:**
- Cost-of-care analysis (IP, OP, Carrier)
- Beneficiary-level total cost modeling
- Payer mix analysis (Medicare vs beneficiary vs other payer)
- Detecting high-cost chronic conditions
- Revenue Cycle KPIs:
  - beneficiary responsibility trends
  - reimbursement gaps
  - primary payer patterns

---

### 6. Mortality (Death date)
**Use cases:**
- Mortality prediction modeling
- End-of-life cost profiling
- Cohort exclusion logic for longitudinal studies
- Identifying high-risk chronic pathways



## Dataset Grain, Keys, and Linking Logic

### 1. Grain (What one row represents)
Each row in the Beneficiary Summary file represents **one synthetic Medicare beneficiary** for a
specific year.  
This is a **beneficiary-level, not claim-level** dataset.

### 2. Primary Key
- **DESYNPUF_ID** is the primary key.
- It is unique to each beneficiary within a subsample.

### 3. Uniqueness
DESYNPUF_ID appears exactly once per beneficiary-year in the Beneficiary Summary file.  
There should be **no duplicate DESYNPUF_ID values** in each year’s file.

### 4. Linking Logic to Other Files
The key **DESYNPUF_ID** is used to link this file with:
- Inpatient Claims file  
- Outpatient Claims file  
- Carrier Claims file  
- Prescription Drug Events (PDE) file  

All CMS claim tables carry this same identifier.

### 5. Expected Row Count Category
- Typically ~100k–120k rows per subsample file.
- Represents a synthetic subset of Medicare beneficiaries.

### 6. Usage Notes
- This table is the “master/parent” table for all beneficiary-level analytics.
- All cost, chronic condition, demographic, and coverage variables originate here.
