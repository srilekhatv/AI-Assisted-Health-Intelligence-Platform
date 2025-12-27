# Inpatient Claims Fact Table — `fact_inpatient_claims`

**Domain:** Claims & Cost Intelligence  
**Claim Type:** Inpatient  
**Layer:** Analytics  
**Source:** CMS DE-SynPUF  

---

## 1. Purpose

The `fact_inpatient_claims` table is the **core analytical fact table** for inpatient healthcare utilization and cost analysis.

Each row represents a **single inpatient claim segment**, enabling accurate measurement of:
- Healthcare costs
- Length of stay (LOS)
- Utilization patterns
- Provider and beneficiary-level trends

This table serves as the foundation for dashboards, KPIs, and downstream modeling.

---

## 2. Grain

**Grain:**  
> **One row per inpatient claim segment**  
(`CLM_ID + SEGMENT`)

This grain reflects the true structure of CMS DE-SynPUF inpatient data, where a single claim may be split across multiple segments.

---

## 3. Source Data

The fact table is built from:

- `stg_inpatient_claims` (primary source)
- Joined to the following dimensions:
  - `dim_beneficiary`
  - `dim_provider`
  - `dim_date` (role-playing: admission & discharge)

---

## 4. Keys

### Primary Key
- `fact_claim_key`  
  - Surrogate key generated from `(claim_id, segment)`

### Foreign Keys

| Column | Dimension |
|------|-----------|
| `beneficiary_key` | `dim_beneficiary` |
| `provider_key` | `dim_provider` |
| `admission_date_key` | `dim_date` |
| `discharge_date_key` | `dim_date` |

---

## 5. Measures

All measures are **claim-level, numeric, and additive**.

| Measure | Description |
|------|------------|
| `claim_payment_amount` | Total CMS payment for the claim |
| `primary_payer_amount` | Amount paid by primary payer |
| `pass_thru_per_diem_amount` | Per-diem pass-through reimbursement |
| `deductible_amount` | Beneficiary inpatient deductible |
| `coinsurance_amount` | Beneficiary coinsurance liability |
| `blood_deductible_amount` | Blood deductible liability |
| `utilization_days` | CMS utilization day count |
| `length_of_stay_days` | Derived length of stay |

> Note: Negative payment values may appear due to claim adjustments and reversals, which are valid in CMS data.

---

## 6. Degenerate Dimensions

The following attributes are stored directly in the fact table:

- `claim_id`
- `segment`
- `drg_code`
- `admitting_diagnosis_code`

These fields are single-valued at the claim level and are frequently used for filtering and grouping.

---

## 7. Design Decisions

### Included
- LOS stored at claim level
- Provider and beneficiary resolved via surrogate keys
- Role-playing date dimension for admission/discharge

### Excluded (by design)
- ICD diagnosis codes
- ICD procedure codes
- HCPCS codes

These multi-valued attributes will be modeled later using **bridge tables** to avoid row explosion.

---

## 8. Data Quality Guarantees

The following tests are enforced:

- `fact_claim_key` is **unique** and **not null**
- All foreign keys are **not null**

These guarantees ensure safe joins and accurate aggregation.

---

## 9. Status

- Fact table complete  
- Validated and tested  
- Ready for analytics, dashboards, and modeling
