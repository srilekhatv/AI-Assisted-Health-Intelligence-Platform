# dbt Architecture 

## Scope and Status
This document describes the **dbt architecture and transformation conventions** used in the *Claims & Cost – Inpatient* domain of the AI‑Assisted Health Intelligence Platform.

**Important:** This is a *pre‑bridge* document.
- Core inpatient fact and dimensions are complete.
- Bridge tables (diagnosis, procedure, DRG many‑to‑many relationships) are **intentionally deferred** and will be documented in a later phase.
- This README focuses on **architecture, structure, and rules**, not full clinical modeling completeness.

---

## Purpose of dbt in This Project
The dbt layer is responsible for:
- Defining the transformation boundary between raw CMS data and analytics-ready tables
- Enforcing consistent modeling patterns across domains
- Providing clear lineage from ingestion to facts and dimensions
- Enabling testable, explainable, and interview-ready analytics artifacts

Snowflake handles **storage and ingestion**. dbt handles **transformation and semantic modeling**.

---

## High-Level Data Flow

```
CMS CSV Files
   ↓
Snowflake RAW schema
   ↓  (dbt sources)
STAGING models (cleaned, typed, standardized)
   ↓  (dbt refs)
ANALYTICS models (facts & dimensions)
```

Key principle:
> dbt does not own raw data creation. dbt owns transformations and analytics semantics.

---

## Folder Structure

```
models/
├── sources/
│   └── raw/
│       ├── inpatient_sources.yml
│       └── beneficiary_sources.yml
│
├── staging/
│   ├── claims/
│   │   └── stg_inpatient_claims.sql
│   └── beneficiary/
│       ├── stg_beneficiary_2008.sql
│       ├── stg_beneficiary_2009.sql
│       ├── stg_beneficiary_2010.sql
│       └── stg_beneficiary.yml
│
├── facts/
│       ├── fact_inpatient_claims.yml
│       └── fact_inpatient_claims.sql
│
├──dimensions/
│            ├── dim_beneficiary.sql
│            ├── dim_beneficiary.yml
│            ├── dim_provider.sql
│            ├── dim_provider.yml
│            ├── dim_date.sql
│            └── dim_date.yml
```

Each layer has a **single responsibility**.

---

## Source Layer (RAW)

### Purpose
The source layer defines **external, ingested datasets** that dbt does not control.

Examples:
- CMS DE‑SynPUF inpatient claims
- CMS DE‑SynPUF beneficiary files

### Key Rules
- All raw ingestion tables must be declared using `sources.yml`
- Physical table names must exactly match Snowflake
- Logical source names are dbt‑only abstractions

### Example
```sql
from {{ source('cms_beneficiary_raw', 'BENEFICIARY_2008') }}
```

This enforces an explicit ingestion boundary and enables lineage tracking.

---

## Staging Layer

### Purpose
Staging models:
- Clean and standardize raw columns
- Apply type casting and date parsing
- Normalize column naming
- Add minimal semantic fields (flags, year indicators)

### Characteristics
- One staging model per raw table
- Materialized as views
- No joins across domains
- No business aggregations

### Naming Convention
- `stg_<entity>_<year>` or `stg_<entity>`

---

## Analytics Layer

### Purpose
The analytics layer contains **business-consumable models**:
- Facts at a clearly defined grain
- Dimensions with stable surrogate keys

### Current Inpatient Scope
- `fact_inpatient_claims` (core claim-level fact)
- Supporting dimensions: beneficiary, provider, date

### Grain Principle
Each fact table explicitly documents its grain. For inpatient claims:
> One row per inpatient claim (CLM_ID)

Bridge tables for many‑to‑many clinical entities are deferred to a later phase.

---

## Lineage and Dependencies

All models use:
- `source()` for raw ingestion tables
- `ref()` for dbt-managed dependencies

This ensures:
- Accurate dbt lineage graphs
- Safe refactoring
- Clear explanation of data flow in reviews and interviews

---

## Testing Philosophy

Tests are applied at the appropriate layer:
- Source-level tests: deferred (freshness to be added later)
- Staging models: schema and column validity tests
- Analytics models: grain, uniqueness, and business sanity tests

Deprecated test syntax warnings are acknowledged and intentionally deferred.

---

## What Is Explicitly Out of Scope (For Now)

The following will be added in a later phase:
- Diagnosis bridge tables (ICD codes)
- Procedure bridge tables
- DRG many-to-many modeling
- Advanced clinical rollups

This README will be extended once those components are implemented.

---

## Summary

This document establishes the **architectural contract** for dbt usage in the project.

It is intentionally written **before bridge tables** to:
- Lock transformation standards early
- Enable consistent extension across domains
- Avoid architectural drift

Clinical completeness will be layered on top of this foundation in subsequent phases.

