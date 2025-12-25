# Beneficiary Dimension (dim_beneficiary)

## Purpose
Represents Medicare beneficiaries (patients) in the CMS DE-SynPUF dataset.
Provides stable patient-level attributes for joining to claims fact tables.

## Grain
One row per unique beneficiary (desynpuf_id).

## Source
CMS DE-SynPUF Beneficiary Summary Files (2008–2010).

## Keys
- beneficiary_key (surrogate primary key)
- desynpuf_id (natural CMS identifier)

## Attributes Included
- birth_date
- death_date
- sex_code
- race_code
- esrd_indicator
- state_code
- county_code

## Slowly Changing Logic
Type-1 SCD:
- Latest non-null values win
- Priority order: 2010 → 2009 → 2008

## Attributes Explicitly Excluded
The following were intentionally excluded because they are time-varying
enrollment facts, not patient identity attributes:
- Part A coverage months
- Part B coverage months
- HMO coverage months
- Part D coverage months

These will be modeled in a separate fact table.

## Usage
- Joined to claims fact tables via beneficiary_key
- Supports demographic, geographic, and risk stratification analysis
