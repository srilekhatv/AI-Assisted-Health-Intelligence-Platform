{{ config(
    materialized = 'table'
) }}

with distinct_codes as (

    select distinct
        diagnosis_code
    from {{ ref('bridge_inpatient_claim_diagnosis') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['diagnosis_code']) }} as diagnosis_key,
        diagnosis_code,
        'ICD-9' as code_type,
        'CMS Inpatient Claims' as source
    from distinct_codes

)

select *
from final
