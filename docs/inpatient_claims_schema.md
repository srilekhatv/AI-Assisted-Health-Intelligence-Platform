# Inpatient Claims File — Variable Dictionary

This document contains variable definitions for the DE-SynPUF Inpatient Claims File, 
based on the official CMS user manual.

---

## Variable Definitions (Part 1 — First 15 Columns)

### 1. DESYNPUF_ID
Synthetic beneficiary identifier used to link claims to the beneficiary summary file.

### 2. CLM_ID
Unique synthetic claim identifier for each inpatient claim event.

### 3. SEGMENT
Indicates the claim line segment. Most inpatient claims contain a single segment.

### 4. CLM_FROM_DT
Claim start date (admission or service start date).

### 5. CLM_THRU_DT
Claim end date (discharge or service end date).

### 6. PRVDR_NUM
Synthetic provider (institution) identifier for the facility submitting the claim.

### 7. CLM_PMT_AMT
Medicare payment amount for the claim.

### 8. NCH_PRMRY_PYR_CLM_PD_AMT
Primary payer amount for the claim (non-Medicare payer such as private insurance).

### 9. AT_PHYSN_NPI
Synthetic attending physician NPI (National Provider Identifier).

### 10. OP_PHYSN_NPI
Synthetic operating physician NPI.

### 11. OT_PHYSN_NPI
Synthetic “other” physician NPI (consulting or assisting clinician).

### 12. CLM_ADMSN_DT
Admission date for the inpatient stay.

### 13. ADMTNG_ICD9_DGNS_CD
Admitting diagnosis code — the condition identified at admission.

### 14. CLM_PASS_THRU_PER_DIEM_AMT
Pass-through per diem payment amount associated with the claim.

### 15. NCH_BENE_IP_DDCTBL_AMT
Beneficiary deductible amount for the inpatient stay.

### 16. NCH_BENE_PTA_COINSRNC_LBLTY_AM
Beneficiary Part A coinsurance liability amount for the inpatient stay.

### 17. NCH_BENE_BLOOD_DDCTBL_LBLTY_AM
Beneficiary blood deductible liability amount (for blood-related services).

### 18. CLM_UTLZTN_DAY_CNT
Number of utilization days (inpatient days counted for Medicare reimbursement purposes).

### 19. NCH_BENE_DSCHRG_DT
Discharge date for the inpatient stay.

### 20. CLM_DRG_CD
Diagnosis Related Group (DRG) code assigned to this inpatient claim.  
Used for Medicare inpatient payment classification.

### 21. ICD9_DGNS_CD_1 
Primary diagnosis code for the inpatient claim.

### 22. ICD9_DGNS_CD_2 - ### 30. ICD9_DGNS_CD_10
Secondary diagnosis code.

### 31. ICD9_PRCDR_CD_1
Primary ICD-9 procedure code associated with the inpatient stay.

### 32. ICD9_PRCDR_CD_2 - ### 36. ICD9_PRCDR_CD_6
Secondary procedure code.
These codes describe clinical or surgical procedures performed during the inpatient stay.

### 37. HCPCS_CD_1 – ### 45. HCPCS_CD_45
Revenue Center HCPCS (Healthcare Common Procedure Coding System) codes.  
Each HCPCS_CD_X column represents a revenue center line item associated with the claim.

Use cases include:
- identifying services billed during the inpatient stay  
- grouping into service categories  
- cost and reimbursement modeling  


---

## Dataset Grain, Keys, and Linking Logic

### 1. Grain (What one row represents)
Each row represents **one inpatient claim** for a synthetic Medicare beneficiary.  
This is a **claim-level** dataset, not a beneficiary-level dataset.

A single beneficiary may have:
- zero inpatient claims  
- one inpatient claim  
- many inpatient claims

### 2. Primary Key
- **CLM_ID** is the claim identifier.
- In combination with **DESYNPUF_ID**, it uniquely identifies claim events.

### 3. Foreign Key(s)
- **DESYNPUF_ID** links this table to the Beneficiary Summary file.
- This key is present in all CMS DE-SynPUF claim files.

### 4. Uniqueness
- Each CLM_ID appears once per inpatient claim.
- There should be **no duplicate CLM_ID values** within the file.

### 5. Expected Row Count Category
Based on CMS documentation:
- Approximately **500k–550k inpatient claims per year** across the DE-SynPUF subsample.
- Your subsample typically contains **~60k–80k inpatient claims** per year.

### 6. Usage Notes
This table is used for:
- DRG-based cost modeling  
- inpatient utilization analysis  
- readmission feature engineering  
- length-of-stay analysis  
- risk and comorbidity identification (via ICD-9 codes)  
- linking to provider or physician patterns  
