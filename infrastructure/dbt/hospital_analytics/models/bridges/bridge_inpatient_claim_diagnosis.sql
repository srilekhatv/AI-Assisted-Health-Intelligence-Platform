{{ config(
    materialized = 'table'
) }}

with source as (

    select
        claim_id,
        segment,

        ICD9_DGNS_CD_1,
        ICD9_DGNS_CD_2,
        ICD9_DGNS_CD_3,
        ICD9_DGNS_CD_4,
        ICD9_DGNS_CD_5,
        ICD9_DGNS_CD_6,
        ICD9_DGNS_CD_7,
        ICD9_DGNS_CD_8,
        ICD9_DGNS_CD_9,
        ICD9_DGNS_CD_10

    from {{ ref('stg_inpatient_claims') }}

),

unpivoted as (

    select claim_id, segment, ICD9_DGNS_CD_1  as diagnosis_code, 1  as diagnosis_position from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_2,  2  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_3,  3  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_4,  4  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_5,  5  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_6,  6  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_7,  7  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_8,  8  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_9,  9  from source
    union all
    select claim_id, segment, ICD9_DGNS_CD_10, 10 from source

),

cleaned as (

    select
        claim_id,
        segment,
        diagnosis_code,
        diagnosis_position,
        diagnosis_position = 1 as is_principal_diagnosis
    from unpivoted
    where diagnosis_code is not null
      and diagnosis_code <> '0'

)

select
    f.fact_claim_key,
    d.diagnosis_key,
    c.diagnosis_position,
    c.is_principal_diagnosis

from cleaned c

join {{ ref('fact_inpatient_claims') }} f
  on c.claim_id = f.claim_id
 and c.segment = f.segment

join {{ ref('dim_diagnosis') }} d
  on c.diagnosis_code = d.diagnosis_code