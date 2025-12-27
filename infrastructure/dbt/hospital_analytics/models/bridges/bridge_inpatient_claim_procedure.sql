{{ config(
    materialized = 'table'
) }}


with source as (

    select
        claim_id,
        segment,

        ICD9_PRCDR_CD_1,
        ICD9_PRCDR_CD_2,
        ICD9_PRCDR_CD_3,
        ICD9_PRCDR_CD_4,
        ICD9_PRCDR_CD_5,
        ICD9_PRCDR_CD_6

    from {{ ref('stg_inpatient_claims') }}

),

unpivoted as (

    select claim_id, segment, ICD9_PRCDR_CD_1  as procedure_code, 1  as procedure_position from source
    union all
    select claim_id, segment, ICD9_PRCDR_CD_2,  2  from source
    union all
    select claim_id, segment, ICD9_PRCDR_CD_3,  3  from source
    union all
    select claim_id, segment, ICD9_PRCDR_CD_4,  4  from source
    union all
    select claim_id, segment, ICD9_PRCDR_CD_5,  5  from source
    union all
    select claim_id, segment, ICD9_PRCDR_CD_6,  6  from source

)

select
    claim_id,
    procedure_code,
    procedure_position,
    procedure_position = 1 as is_primary_procedure,
    segment

from unpivoted
where procedure_code is not null
  and procedure_code <> '0'
