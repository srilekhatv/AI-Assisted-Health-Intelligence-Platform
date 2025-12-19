# Prescription Drug Events (PDE) File — Variable Dictionary

This document contains variable definitions for the DE-SynPUF Prescription Drug
Events (PDE) file. The PDE file represents Medicare Part D pharmacy claims.

---

## Variable Definitions

### 1. DESYNPUF_ID
Synthetic beneficiary identifier.  
Used to link Part D pharmacy events to the Beneficiary Summary file and other claim types.

### 2. PDE_ID
Synthetic Prescription Drug Event identifier representing a unique medication fill.

### 3. SRVC_DT
Service date: the date the prescription was dispensed by the pharmacy.

### 4. PROD_SRVC_ID
National Drug Code (NDC) representing the medication dispensed.

### 5. QTY_DSPNSD_NUM
Quantity of medication dispensed (e.g., number of tablets, mL, inhaler units).

### 6. DAYS_SUPLY_NUM
Number of days the dispensed quantity is expected to cover.

### 7. PTNT_PAY_AMT
Amount the patient paid out-of-pocket for the prescription (copay, coinsurance).

### 8. TOT_RX_CST_AMT
Total cost of the prescription drug event, including plan payments and patient payments.

---

## Dataset Grain, Keys, and Linking Logic

### Grain
Each row represents **one prescription fill event** (One PDE).

### Primary Key
- **PDE_ID**

### Foreign Key(s)
- **DESYNPUF_ID** joins to Beneficiary Summary File.
- Can be combined with inpatient, outpatient, and carrier claims for full utilization history.

### Usage in Analytics
PDE data supports:
- Medication adherence metrics (PDC, MPR)
- Chronic disease medication management (e.g., diabetes, hypertension)
- Pharmacy spend analysis
- Part D cost modeling
- Predictive models using medication history
- Identifying risk patterns related to drug classes or polypharmacy

### Typical Row Volumes
PDE usually contains many rows per beneficiary
(e.g., multiple prescription fills per month).

---
