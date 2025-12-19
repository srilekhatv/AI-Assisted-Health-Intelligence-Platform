# Data Overview

This document provides a structured overview of all datasets used in the **AI-Assisted Health Intelligence Platform**.  
Datasets are cataloged by **source**, **granularity**, and **domain usage**.

This project follows a **documentation-first, domain-driven approach**.  
Only datasets required for finalized domains are actively used.  
Future domains are documented with placeholders until data is available.

---

## 1. Dataset Inventory

### 1.1 CMS DE-SynPUF (Synthetic Medicare Claims Data)

**Source:** Centers for Medicare & Medicaid Services (CMS)  
**Type:** Synthetic Public Use Files (non-PII)  
**Granularity:** Beneficiary-level and claim-level  
**Domain:** Claims & Cost Intelligence  

The following CMS DE-SynPUF datasets are available locally (not committed to GitHub):

- DE1_0_2008_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2009_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2010_Beneficiary_Summary_File_Sample_1.csv  
- DE1_0_2008_to_2010_Inpatient_Claims_Sample_1.csv  
- DE1_0_2008_to_2010_Outpatient_Claims_Sample_1.csv  
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1A.csv  
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1B.csv  
- DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_1.csv  

**Usage:**  
These datasets support **Claims & Cost analytics**, including:
- Cost concentration analysis  
- High-cost beneficiary identification  
- Cost drivers by care setting  
- Year-over-year cost trends  

---

### 1.2 PLACES: Local Data for Better Health (ZCTA-Level)

**Source:** Centers for Disease Control and Prevention (CDC)  
**Type:** Public health estimates  
**Granularity:** ZIP Code Tabulation Area (ZCTA), County, Place  
**Domain:** Population Health & Risk Stratification  

Available dataset:
- PLACES__Local_Data_for_Better_Health_ZCTA_Data_2025_release.csv  

**Usage:**  
This dataset supports **Population Health analytics**, including:
- Geographic health risk burden  
- Chronic condition prevalence  
- Risk behavior patterns  
- Preventive care utilization gaps  

---

### 1.3 AHRF – Area Health Resources Files (County-Level)

**Source:** U.S. Health Resources & Services Administration (HRSA)  
**Type:** Workforce and health resource data  
**Granularity:** County  
**Domain:** Workforce Analytics  

Available dataset:
- Area Health Resources Files (AHRF), county-level datasets  

**Usage:**  
This dataset supports **Workforce Analytics**, including:
- Provider-to-population ratios  
- Identification of workforce shortage areas  
- Geographic disparities in healthcare capacity  
- Alignment of workforce supply with population needs  

The AHRF dataset is confirmed as the authoritative source for Workforce Analytics and will be implemented after the Claims & Cost and Population Health domains are completed.

---

## 2. Domains Without Active Datasets (Planned)

The following domains are **intentionally deferred** until appropriate datasets are available:

### 2.1 Revenue Cycle Intelligence  
**Status:** Planned  
**Data Source:** Internal or simulated revenue cycle data (future phase)

### 2.2 Digital Health Engagement  
**Status:** Planned  
**Data Source:** Simulated or real digital interaction data (future phase)

These domains are documented conceptually but **not implemented** at this stage.

---

## 3. Reference Documentation

Official metadata and documentation used for accurate interpretation of datasets:

- SynPUF_DUG.pdf (CMS DE-SynPUF Data User Guide)

These reference documents inform:
- Schema understanding  
- Variable definitions  
- Data quality assumptions  

They will be linked to analytical tables during **Claims & Cost implementation**.

---

## 4. Data Governance Notes

- Raw datasets are stored **locally or in external storage** and are **not committed to GitHub**  
- GitHub contains **documentation, schemas, and analytics logic only**  
- This approach mirrors enterprise data governance and security best practices  

---

## 5. Current Status

- Dataset inventory finalized  
- Domain–dataset mapping locked  
- Claims & Cost, Population Health, and Workforce Analytics are ready for end-to-end implementation  
- Revenue Cycle and Digital Health remain planned future phases  

