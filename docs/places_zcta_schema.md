# PLACES ZCTA Dataset — Variable Dictionary

This document describes the PLACES: Local Data for Better Health dataset
provided by the CDC. The dataset contains model-based estimates of health
outcomes, behaviors, preventive services, and social determinants of health
at the ZIP Code Tabulation Area (ZCTA) level.

---

## 1. Dataset Overview

- Source: CDC PLACES / BRFSS
- Geographic level: ZCTA (ZIP Code Tabulation Area)
- Temporal coverage: Multi-year (varies by measure)
- Unit of analysis: One health measure for one ZCTA and year

This dataset is used to enrich claims data with **population-level context**
and **community health indicators**.

---

## 2. Variable Definitions

### 1. Year
Year for which the estimate applies.

### 2. LocationName
ZCTA code representing the geographic area.

### 3. DataSource
Source of the data (e.g., BRFSS).

### 4. Category
High-level category of the health measure
(e.g., Health Outcomes, Prevention, Health Risk Behaviors).

### 5. Measure
Full description of the health indicator being measured.

### 6. Data_Value_Unit
Unit of measurement (e.g., percentage).

### 7. Data_Value_Type
Type of estimate (e.g., crude prevalence, age-adjusted).

### 8. Data_Value
Estimated value of the health measure for the ZCTA.

### 9. Data_Value_Footnote_Symbol
Symbol indicating special notes or data limitations.

### 10. Data_Value_Footnote
Text explaining footnotes or suppressed data.

### 11. Low_Confidence_Limit
Lower bound of the confidence interval.

### 12. High_Confidence_Limit
Upper bound of the confidence interval.

### 13. TotalPop18plus
Estimated population aged 18 and older in the ZCTA.

### 14. TotalPopulation
Total population of the ZCTA.

### 15. Geolocation
Geographic coordinates (latitude/longitude) for mapping.

### 16. LocationID
Unique identifier for the ZCTA.

### 17. CategoryID
Short code representing the category.

### 18. MeasureId
Short code representing the specific health measure.

### 19. DataValueTypeID
Short code representing the data value type.

### 20. Short_Question_Text
Concise, human-readable description of the measure.

---

## 3. Dataset Grain, Keys, and Linking Logic

### Grain
Each row represents:
**One health measure × one ZCTA × one year**

This is an aggregated, model-based estimate — not individual-level data.

### Primary Key (Logical)
Composite key:
- Year
- LocationID
- MeasureId
- DataValueTypeID

### Linking Strategy
This dataset does **not** link directly to CMS claims.
Instead, it is joined indirectly using:
- ZCTA or ZIP-level mapping derived from beneficiary residence

---

## 4. Analytical Use Cases

PLACES data enables:
- Social determinants of health (SDOH) enrichment
- Population health profiling
- Community-level risk adjustment
- Geographic disparity analysis
- Public health context for claims-based outcomes
- Preventive care gap identification

This dataset is commonly used alongside claims to explain
**why outcomes differ across regions**, not just what happened.

---
