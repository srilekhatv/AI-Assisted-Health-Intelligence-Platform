# Dataset Categories

This document groups all available datasets into broad categories **prior to domain-level analytics design**.  
The purpose is to clarify the **nature, scope, and analytical intent** of each dataset before detailed modeling and pipeline implementation.

These categories are **organizational only** and do not yet imply final table design or schema structure.

---

## 1. Claims & Utilization Data (Clinical / Financial)

Synthetic Medicare claims datasets used to analyze beneficiary characteristics, utilization patterns, procedures, diagnoses, and healthcare costs.

**Source:** CMS DE-SynPUF  
**Primary Domain:** Claims & Cost Intelligence  
**Potential Secondary Use:** Revenue Cycle (future phase)

- DE1_0_2008_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2009_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2010_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2008_to_2010_Inpatient_Claims_Sample_1.csv  
- DE1_0_2008_to_2010_Outpatient_Claims_Sample_1.csv  
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1A.csv  
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1B.csv  
- DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_1.csv  

---

## 2. Population Health & Social Determinants Data

Public health datasets capturing community-level health outcomes, chronic disease prevalence, preventive care metrics, and social risk indicators.

**Source:** CDC PLACES  
**Primary Domain:** Population Health & Risk Stratification  

- PLACES__Local_Data_for_Better_Health_ZCTA_Data_2025_release.csv

---

## 3. Workforce & Health Resource Data

Datasets describing healthcare workforce supply, provider availability, facility resources, and geographic access to care.

**Source:** HRSA AHRF  
**Primary Domain:** Workforce Analytics  

- Area Health Resources Files (AHRF), county-level datasets  
  *(stored locally; documentation available in `/reference/`)*

---

## 4. Reference & Metadata Documentation

Official documentation used to correctly interpret datasets, variables, and assumptions.  
These files **do not contain raw data** and are safe for public reference.

**Usage:** Schema interpretation, variable definitions, data quality context

- SynPUF_DUG.pdf  
- AHRF Technical Documentation  
- AHRF Data Use Agreement (DUA)  
- AHRF User Documentation  

---

## Notes

- Dataset categories are **preliminary groupings** for analytical planning.
- Final domain assignment and table design will occur during **domain-specific analytics design**.
- Some datasets may support multiple domains in later phases (e.g., Claims → Revenue Cycle).
- Raw datasets are stored locally and excluded from version control via `.gitignore`.

