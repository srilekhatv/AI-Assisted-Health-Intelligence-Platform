# Outpatient Claims File — Variable Dictionary

This document contains variable definitions for the DE-SynPUF Outpatient Claims File,
based on the official CMS user manual.

---

## Variable Definitions (Part 1 — First 15 Columns)

### 1. DESYNPUF_ID
Synthetic beneficiary identifier used to link to the Beneficiary Summary file.

### 2. CLM_ID
Synthetic claim identifier unique to each outpatient claim event.

### 3. SEGMENT
Claim segment indicator. Outpatient claims may include multiple segments (line items).

### 4. CLM_FROM_DT
Start date of the outpatient service or encounter.

### 5. CLM_THRU_DT
End date of the outpatient service or encounter.

### 6. PRVDR_NUM
Synthetic provider number for the facility submitting the outpatient claim.

### 7. CLM_PMT_AMT
Medicare payment amount for the outpatient claim.

### 8. NCH_PRMRY_PYR_CLM_PD_AMT
Amount paid by the primary payer (non-Medicare), such as commercial insurance.

### 9. AT_PHYSN_NPI
Synthetic attending physician NPI.

### 10. OP_PHYSN_NPI
Synthetic operating physician NPI.

### 11. OT_PHYSN_NPI
Synthetic "other" physician NPI for the outpatient claim.

### 12. NCH_BENE_BLOOD_DDCTBL_LBLTY_AM
Beneficiary blood deductible liability amount for outpatient services.

### 13. ICD9_DGNS_CD_1
Primary diagnosis code for the outpatient claim 

### 14. ICD9_DGNS_CD_2 - ### 22. ICD9_DGNS_CD_10
Secondary diagnosis codes - These codes describe the conditions evaluated or treated during the outpatient encounter.

### 23. ICD9_PRCDR_CD_1  - ### 28. ICD9_PRCDR_CD_6
Claim Procedure Codes 1 to 6 - Outpatient procedures may include imaging, minor surgeries, or therapeutic services.

### 29. NCH_BENE_PTB_DDCTBL_AMT
Beneficiary Part B deductible amount applied to the outpatient claim.

### 20. NCH_BENE_PTB_COINSRNC_AMT
Beneficiary Part B coinsurance liability amount.

### 31. ADMTNG_ICD9_DGNS_CD
Admitting diagnosis code (used primarily for outpatient claims involving observation or same-day inpatient-like services)

### 32. HCPCS_CD_1  - ### 76. HCPCS_CD_45 
Revenue Center HCPCS codes representing individual outpatient services, procedures, or supplies billed on the claim.
Each HCPCS_CD_X corresponds to a line item on the outpatient claim and may represent:
- diagnostic tests  
- imaging (X-ray, MRI, CT)  
- minor procedures  
- therapy services  
- durable medical equipment  
- clinic or facility fees  

Outpatient claims often have multiple HCPCS codes because services are billed at the line-item level rather than as a single bundled amount.


---

## Dataset Grain, Keys, and Linking Logic

### 1. Grain (What one row represents)
Each row represents **one outpatient claim** for a Medicare beneficiary.  
Outpatient claims may contain multiple service lines, but this file provides a **claim-level summary**, not the line-by-line breakout.

### 2. Primary Key
- **CLM_ID** uniquely identifies each outpatient claim.

### 3. Foreign Key(s)
- **DESYNPUF_ID** links each claim to the Beneficiary Summary file.
- This key is shared across all claim types in the DE-SynPUF dataset.

### 4. Uniqueness
- **CLM_ID** should appear only once per outpatient claim.
- A single beneficiary may have many outpatient claims.

### 5. Expected Row Count Category
For a typical DE-SynPUF subsample:
- Outpatient claims usually number **150k–250k claims per year**.
- Your sample likely contains **~40k–60k claims** per year.

### 6. Usage Notes
Outpatient claims are essential for:
- cost and utilization analysis  
- Part B deductible and coinsurance calculations  
- diagnosis-based risk modeling  
- outpatient procedure profiling  
- care patterns across providers and clinics  
