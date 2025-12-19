# Claims & Cost Analytics — Star Schema Design

## Overview

This document defines the analytical data model for the **Claims & Cost** domain of the AI-Assisted Health Intelligence Platform.

The goal of this domain is to help hospital systems understand:
- where healthcare money is being spent,
- why costs are high,
- and how costs change over time.

The design follows **healthcare industry best practices** using a **star schema** with clearly defined fact and dimension tables, including bridge tables for many-to-many relationships.

---

## Grain Definition

**Grain:**  
One row in the Claims fact table represents **one healthcare claim**.

All measures and relationships in this schema strictly respect this grain to avoid double counting and analytical errors.

---

## Core Fact Table

### `fact_claims`

This is the central table of the schema and represents healthcare claims.

**Purpose:**  
Stores claim-level cost measures and foreign keys linking to descriptive dimensions.

**Primary Key:**
- `claim_id`

**Foreign Keys:**
- `patient_id`
- `provider_id`
- `from_date_id`
- (linked to diagnosis and procedure via bridge tables)

**Measures (examples):**
- `total_cost`
- `paid_amount`
- `charge_amount`

**Notes:**
- Cost measures live only in the fact table.
- No descriptive attributes are stored here.

---

## Dimension Tables

### `dim_patient`

**Grain:** One row per patient

**Purpose:**  
Provides descriptive patient attributes to analyze cost patterns across populations.

**Key Columns (examples):**
- `patient_id` (PK)
- `gender`
- `age_group`
- `state`
- `county`
- `enrollment_type`

---

### `dim_provider`

**Grain:** One row per provider

**Purpose:**  
Describes who delivered the healthcare service, enabling cost analysis by provider characteristics.

**Key Columns (examples):**
- `provider_id` (PK)
- `provider_name`
- `provider_type` (hospital, clinic, physician group)
- `state`
- `ownership_type`

**Assumption:**  
Provider attributes are treated as stable in v1. Historical provider changes are out of scope.

---

### `dim_time`

**Grain:** One row per calendar date

**Purpose:**  
Provides calendar context for analyzing claim costs over time.

**Key Columns (examples):**
- `date_id` (PK)
- `full_date`
- `year`
- `month`
- `month_name`
- `quarter`
- `day_of_week`
- `is_weekend`

**Design Decision:**  
The **from date** of a claim is used as the primary time reference for trend analysis.

---

### `dim_diagnosis`

**Grain:** One row per diagnosis code

**Purpose:**  
Represents the clinical reason why care was required.

**Key Columns (examples):**
- `diagnosis_id` (PK)
- `diagnosis_code`
- `diagnosis_description`
- `diagnosis_category`
- `chronic_flag`

---

### `dim_procedure`

**Grain:** One row per procedure / service code

**Purpose:**  
Represents the medical action performed as part of care delivery.

**Key Columns (examples):**
- `procedure_id` (PK)
- `procedure_code`
- `procedure_description`
- `procedure_category`

---

## Bridge Tables (Many-to-Many Relationships)

Healthcare claims can involve **multiple diagnoses** and **multiple procedures**.  
To model this correctly, bridge tables are used.

---

### `bridge_claim_diagnosis`

**Purpose:**  
Links claims to one or more diagnoses.

**Columns:**
- `claim_id` (FK)
- `diagnosis_id` (FK)

Each row represents one diagnosis associated with a claim.

---

### `bridge_claim_procedure`

**Purpose:**  
Links claims to one or more procedures.

**Columns:**
- `claim_id` (FK)
- `procedure_id` (FK)

Each row represents one procedure associated with a claim.

---

## Star Schema Overview (Simplified)

The following diagram shows the high-level star schema for the Claims & Cost domain.
It is intentionally simplified to highlight table relationships and analytical structure.

                      dim_time
                          |
                          |
    dim_patient ---- fact_claims ---- dim_provider
                          |
                          |
           bridge_claim_diagnosis
                          |
                   dim_diagnosis

                          |
           bridge_claim_procedure
                          |
                  dim_procedure



### Diagram Notes

- `fact_claims` is the central fact table (one row per claim).
- Dimension tables provide descriptive context for analysis.
- Bridge tables handle many-to-many relationships between:
  - claims and diagnoses
  - claims and procedures
- Time analysis uses the **from date** of each claim.

This structure supports realistic healthcare cost analytics and advanced slicing across clinical and operational dimensions.

---

## Schema Summary

- Central fact table: `fact_claims`
- Dimensions:
  - Patient
  - Provider
  - Time
  - Diagnosis
  - Procedure
- Bridge tables handle healthcare many-to-many relationships.
- Design supports realistic healthcare analytics and scales to advanced use cases.

---

## Versioning Notes

This schema represents the **first fully realized analytical model** for the Claims & Cost domain.

- Complexity is intentionally embraced to reflect real healthcare data.
- Assumptions and scope decisions are documented explicitly.
- Future versions may extend slowly changing dimensions, attribution logic, or cost allocation.

