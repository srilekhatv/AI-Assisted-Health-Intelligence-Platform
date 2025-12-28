{{ config(
    materialized = 'table'
) }}

with diagnosis_codes as (

    select ICD9_DGNS_CD_1  as diagnosis_code from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_2  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_3  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_4  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_5  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_6  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_7  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_8  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_9  from {{ ref('stg_inpatient_claims') }}
    union
    select ICD9_DGNS_CD_10 from {{ ref('stg_inpatient_claims') }}

),

cleaned as (

    select distinct
        diagnosis_code
    from diagnosis_codes
    where diagnosis_code is not null
      and diagnosis_code <> '0'

)

select
    {{ dbt_utils.generate_surrogate_key(['diagnosis_code']) }} as diagnosis_key,
    diagnosis_code,
    'ICD-9' as code_type,
    'CMS Inpatient Claims' as source
from cleaned
