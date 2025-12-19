# Domain–Dataset Mapping

This document defines how each dataset in the platform maps to the five healthcare domains.  
Dataset assignment will guide Snowflake modeling, dbt transformations, ML workflows, and dashboard development.

---

## 1. Claims & Cost Intelligence
### Datasets Assigned:
- DE1_0_2008_Beneficiary_Summary_File_Sample_1.csv
- DE1_0_2009_Beneficiary_Summary_File_Sample_1.csv
- DE1_0_2010_Beneficiary_Summary_File_Sample_1.csv
- DE1_0_2008_to_2010_Inpatient_Claims_Sample_1.csv
- DE1_0_2008_to_2010_Outpatient_Claims_Sample_1.csv
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1A.csv
- DE1_0_2008_to_2010_Carrier_Claims_Sample_1B.csv
- DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_1.csv

| Domain        | Dataset Name                                    | Time Coverage | What It Represents                                                                            | Why It Belongs Here                                                       |
|---------------|--------------------------------------------------|---------------|------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| Claims & Cost | DE-SynPUF Beneficiary Summary Files (2008–2010) | Yearly        | Demographics, enrollment details, and chronic condition indicators for Medicare beneficiaries | Describes the insured population linked to healthcare spending and claims |
| Claims & Cost | DE-SynPUF Carrier Claims                        | 2008–2010     | Physician and professional service claims with procedures and payments                        | Captures provider-level medical services and associated costs             |
| Claims & Cost | DE-SynPUF Inpatient Claims                      | 2008–2010     | Hospital admission claims including diagnoses, stays, and payments                            | Represents high-cost hospital care events                                 |
| Claims & Cost | DE-SynPUF Outpatient Claims                     | 2008–2010     | Clinic and same-day service claims                                                            | Tracks non-admission medical services and costs                           |
| Claims & Cost | DE-SynPUF Prescription Drug Events              | 2008–2010     | Medication fills and drug payment information                                                 | Represents pharmaceutical spending, a major cost driver                   |




---

## 2. Population Health & Risk Stratification
### Datasets Assigned:
- PLACES: Local Data for Better Health (2025) - PLACES__Local_Data_for_Better_Health,_ZCTA_Data,_2025_release_20251205

| Domain            | Dataset Name                                | Geographic Level               | What It Represents                                                                              | Why It Belongs Here                                                              |
|------------------|---------------------------------------------|--------------------------------|--------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| Population Health | PLACES: Local Data for Better Health (2025) | ZIP Code (ZCTA), County, Place | Health outcomes, risk behaviors, preventive services, and social health factors for populations | Measures health conditions and behaviors at group level, not individual patients |


---

## 3. Workforce & Operational Performance
### Datasets Assigned:
- ahrf2024_Feb2025.csv

| Domain | Dataset Name | Geographic Level | What It Represents | Why It Belongs Here |
|--------|--------------|------------------|--------------------|--------------------|
| Workforce Analytics | Area Health Resources Files (AHRF) 2023–2024 | County | Counts and characteristics of healthcare workforce, facilities, and health resources | Provides county-level workforce supply and capacity metrics used to assess staffing availability and shortages |


---

## 4. Revenue Cycle Intelligence
### Datasets Assigned:
- (To be added)

| Domain        | Dataset Name                        | Data Source                | What It Represents                                                                                   | Status                            |
|---------------|------------------------------------|----------------------------|------------------------------------------------------------------------------------------------------|-----------------------------------|
| Revenue Cycle | TBD – Revenue Cycle Operations Data | Planned / Internal Systems | Billing, coding, claim submission, denial management, and payment timelines for healthcare providers | Planned (to be implemented later) |



---

## 5. Digital Health Engagement
### Datasets Assigned:
- (To be added)

| Domain                    | Dataset Name                      | Data Source | What It Represents                                                                           | Status                          |
|---------------------------|-----------------------------------|-------------|----------------------------------------------------------------------------------------------|---------------------------------|
| Digital Health Engagement | TBD – Simulated Engagement Events | Simulated   | User interactions with digital health tools such as logins, reminders, and activity tracking | Planned (to be finalized later) |


---

## Notes
- Detailed variable-level mapping will be added after exploring each dataset.
- Some datasets may serve more than one domain.
- Mapping will evolve as we inspect schemas and requirements.


