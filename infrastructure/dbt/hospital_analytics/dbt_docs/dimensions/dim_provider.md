# Provider Dimension — `dim_provider`

**Domain:** Claims & Cost Intelligence  
**Claim Type:** Inpatient  
**Layer:** Analytics  
**Source:** CMS DE-SynPUF  

---

## 1. Purpose of the Provider Dimension

The `dim_provider` table represents **provider institutions** associated with inpatient claims.

In the Claims & Cost domain, providers are a critical analytical dimension used to:
- Analyze cost and utilization by hospital
- Track provider activity over time
- Support joins from inpatient fact tables

This dimension is intentionally **lean**, reflecting only the attributes available in the CMS DE-SynPUF inpatient claims dataset.

---

## 2. Source Data

The provider dimension is derived exclusively from:

- stg_inpatient_claims


The CMS DE-SynPUF inpatient claims data provides **only a provider identifier** (`PRVDR_NUM`) and does not include provider names, locations, or facility attributes.

No external enrichment is applied at this stage.

---

## 3. Grain of the Table

**Grain:**  
> **One row per provider (`provider_id`)**

Each provider appears exactly once in `dim_provider`, regardless of how many inpatient claims are associated with that provider.

This ensures:
- Clean joins from the fact table
- No duplication or aggregation issues

---

## 4. Column Definitions

| Column Name | Description |
|------------|-------------|
| `provider_key` | Surrogate primary key generated from `provider_id` |
| `provider_id` | CMS provider identifier (`PRVDR_NUM`) |
| `provider_type` | Hardcoded provider category (`Inpatient Hospital`) |
| `data_source` | Source system (`CMS DE-SynPUF`) |
| `effective_start_date` | First observed claim start date for the provider |
| `effective_end_date` | Last observed claim end date for the provider |
| `is_current` | Flag indicating the current active provider record |

---

## 5. Effective Date Logic

The provider dimension includes **effective dates** derived from observed claim activity:

- `effective_start_date` = earliest `clm_from_date` for the provider
- `effective_end_date` = latest `clm_thru_date` for the provider

These dates represent the **observed activity window** of each provider within the dataset.

This design:
- Preserves temporal context
- Enables future Slowly Changing Dimension (SCD) enhancements
- Avoids assumptions about provider lifecycle outside the data

---

## 6. Design Decisions & Constraints

### Intentional Limitations
- No provider name, address, or geography (not available in DE-SynPUF)
- No external provider registry joins (e.g., NPPES)
- No SCD Type 2 logic at this stage

### Rationale
This project prioritizes:
- Data fidelity
- Transparent assumptions
- Clear separation of concerns

Future enrichment can be layered on without modifying the core dimension grain.

---

## 7. Data Quality Guarantees

The following tests are enforced on `dim_provider`:

- `provider_key` is **NOT NULL** and **UNIQUE**
- `provider_id` is **NOT NULL** and **UNIQUE**
- `provider_type` has accepted value: `Inpatient Hospital`
- `data_source` has accepted value: `CMS DE-SynPUF`

All tests pass, ensuring the dimension is stable and safe for downstream joins.

---

## 8. Downstream Usage

`dim_provider` is designed to join with:

- `fact_inpatient_claims` (via `provider_key`)

It supports analyses such as:
- Cost per provider
- Length of stay by provider
- Utilization trends across hospitals

---

## 9. Status

- Provider dimension complete  
- Tested and validated  
- Ready for use in fact table modeling
