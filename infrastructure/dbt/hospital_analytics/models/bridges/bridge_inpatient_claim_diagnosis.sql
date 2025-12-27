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

)

select
    claim_id,
    diagnosis_code,
    diagnosis_position,
    diagnosis_position = 1 as is_principal_diagnosis,
    segment

from unpivoted
where diagnosis_code is not null
  and diagnosis_code <> '0'
