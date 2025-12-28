# Diagnosis Bridge Validation Checks

This document records the **formal validation checks** performed after refactoring and fixing the diagnosis dimension and bridge tables.

These checks confirm:
- Correct dimensional modeling (no circular dependencies)
- Correct use of surrogate keys
- Correct grain and row counts
- Correct diagnosis positioning logic

---

## Models Covered

- `ANALYTICS.dim_diagnosis`
- `ANALYTICS.bridge_inpatient_claim_diagnosis`
- `ANALYTICS.fact_inpatient_claims`

---

## Check 1 — Bridge Row Count

**Purpose**: Ensure the bridge contains multiple diagnosis rows per claim.

```sql
select count(*) as total_rows
from analytics.bridge_inpatient_claim_diagnosis;
```

**Expected Behavior**:
- Row count is **significantly higher** than fact table row count
- Confirms many-to-many relationship (one claim → many diagnoses)

---

## Check 2 — Dimension Row Count

**Purpose**: Validate unique diagnosis codes are correctly materialized.

```sql
select count(*)
from analytics.dim_diagnosis;
```

**Expected Behavior**:
- Row count equals number of distinct ICD-9 diagnosis codes
- No duplication due to claim-level context

---

## Check 3 — Distinct Claims Coverage

**Purpose**: Ensure most fact claims are represented in the bridge.

```sql
select
    count(distinct fact_claim_key) as distinct_claims_in_bridge
from analytics.bridge_inpatient_claim_diagnosis;
```

```sql
select count(*) as total_claims
from analytics.fact_inpatient_claims;
```

**Expected Behavior**:
- `distinct_claims_in_bridge` ≤ `total_claims`
- Minor gaps are acceptable (claims with no diagnosis codes)

---

## Check 4 — Join Integrity & Diagnosis Positioning

**Purpose**: Validate surrogate-key joins and diagnosis position logic.

```sql
select
    f.fact_claim_key,
    d.diagnosis_code,
    b.diagnosis_position,
    b.is_principal_diagnosis
from analytics.fact_inpatient_claims f
join analytics.bridge_inpatient_claim_diagnosis b
  on f.fact_claim_key = b.fact_claim_key
join analytics.dim_diagnosis d
  on b.diagnosis_key = d.diagnosis_key
order by f.fact_claim_key
limit 20;
```

**Expected Behavior**:
- Multiple diagnosis rows per `fact_claim_key`
- Exactly **one** row per claim where `is_principal_diagnosis = true`
- Diagnosis positions increment correctly starting from 1

---

## Final Validation Outcome

All validation checks passed successfully:

- Diagnosis dimension sources only from staging
- Bridge uses surrogate keys correctly
- No circular dependencies remain
- Diagnosis position logic is correctly modeled in the bridge

**Diagnosis modeling is now locked and production-ready.**

