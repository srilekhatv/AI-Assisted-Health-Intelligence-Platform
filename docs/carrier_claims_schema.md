# Carrier (Physician/Supplier) Claims File — Variable Dictionary

This document contains variable definitions for the DE-SynPUF Carrier Claims Files
(Sample A and Sample B). Both files share the same schema and are combined
row-wise to create the full Carrier dataset.

---

## 1. Claim-Level Fields

### 1. DESYNPUF_ID
Synthetic beneficiary identifier used to link to the Beneficiary Summary file.

### 2. CLM_ID
Synthetic Carrier claim identifier representing a professional service claim.

### 3. CLM_FROM_DT
Start date of the physician/supplier service.

### 4. CLM_THRU_DT
End date of the physician/supplier service.

---

## 2. Diagnosis Codes (Claim-Level)

### 5. ICD9_DGNS_CD_1
Primary diagnosis code associated with the Carrier claim.

### 6. ICD9_DGNS_CD_2 – 12. ICD9_DGNS_CD_8
Secondary diagnosis codes for the physician/supplier claim.

---

## 3. Performing Physician Identifiers

### 13. PRF_PHYSN_NPI_1 – 25. PRF_PHYSN_NPI_13
Synthetic NPIs for performing physicians across different line items.
Each line of service may involve a different performing provider.

---

## 4. Provider Tax Numbers

### 26. TAX_NUM_1 – 38. TAX_NUM_13
Synthetic tax numbers for billing providers.  
Each corresponds to the provider for the respective service line.

---

## 5. HCPCS Procedure Codes (Line-Level)

### 39. HCPCS_CD_1 – 51. HCPCS_CD_13
HCPCS procedure codes for each service line.  
Examples include imaging, lab tests, office visits, and minor procedures.

---

## 6. Payment Amounts (Line-Level)

### 52. LINE_NCH_PMT_AMT_1 – 64. LINE_NCH_PMT_AMT_13
Medicare payment amount for each service line.

---

## 7. Beneficiary Deductible Amounts (Line-Level)

### 65. LINE_BENE_PTB_DDCTBL_AMT_1 – 77. LINE_BENE_PTB_DDCTBL_AMT_13
Part B deductible amount applied per service line.

---

## 8. Primary Payer Amounts (Line-Level)

### 78. LINE_BENE_PRMRY_PYR_PD_AMT_1 – 90. LINE_BENE_PRMRY_PYR_PD_AMT_13
Amount paid by the primary payer (non-Medicare) for each line item.

---

## 9. Coinsurance Liability (Line-Level)

### 91. LINE_COINSRNC_AMT_1 – 103. LINE_COINSRNC_AMT_13
Coinsurance amount for each line of service.

---

## 10. Allowed Charge Amounts (Line-Level)

### 104. LINE_ALOWD_CHRG_AMT_1 – 116. LINE_ALOWD_CHRG_AMT_13
Allowed charges per line item as determined by Medicare.

---

## 11. Processing Indicator Codes (Line-Level)

### 117. LINE_PRCSG_IND_CD_1 – 129. LINE_PRCSG_IND_CD_13
Internal CMS processing codes for each service line.

---

## 12. Diagnosis Codes (Line-Level)

### 130. LINE_ICD9_DGNS_CD_1 – 142. LINE_ICD9_DGNS_CD_13
Diagnosis codes assigned specifically at the service line level.  
These may differ from claim-level diagnosis codes.

---

## 13. Dataset Grain, Keys, and Linking Logic

### Grain  
Each row represents a **Carrier (Part B) claim header** containing up to 13 service lines flattened into columns.

### Primary Key  
- **CLM_ID**

### Foreign Key  
- **DESYNPUF_ID** (links to Beneficiary Summary file)

### Notes  
- Carrier claims capture physician/supplier services such as office visits, labs, imaging, minor procedures.  
- These are the most clinically rich files and heavily used in chronic disease modeling and outpatient utilization analysis.

---

## 14. Additional Notes on Grain and Structure

### Claim Header vs. Line Items
Carrier claims contain both:
- **Header-level fields** (diagnoses, claim dates)
- **Line-level fields** (HCPCS, payment amounts, deductibles, allowed charges)

CMS flattens up to **13 service lines** into repeated variable groups
(e.g., HCPCS_CD_1 – HCPCS_CD_13, LINE_NCH_PMT_AMT_1 – _13).

### Linking Logic Across Datasets
- Use **DESYNPUF_ID** to join Carrier Claims to:
  - Beneficiary Summary File  
  - Inpatient Claims  
  - Outpatient Claims  

### Analytical Uses
Carrier claims support:
- Chronic condition identification  
- Utilization analysis (office visits, lab tests, imaging)  
- Cost and reimbursement modeling  
- Physician performance analysis  
- Care pathways and outpatient episode construction  

### Typical Row Volumes
Carrier claims are the **largest CMS SynPUF dataset**, often containing:
- **5–10× more rows** than inpatient/outpatient combined  
- Millions of rows in the full sample  

This scale makes it essential for realistic analytics and model development.
