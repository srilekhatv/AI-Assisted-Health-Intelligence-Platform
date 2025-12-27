{{ config(
    materialized = 'table'
) }}

with distinct_codes as (

    select distinct
        procedure_code
    from {{ ref('bridge_inpatient_claim_procedure') }}

),

final as (

    select
        {{ dbt_utils.generate_surrogate_key(['procedure_code']) }} as procedure_key,
        procedure_code,
        'ICD-9' as code_type,
        'CMS Inpatient Claims' as source
    from distinct_codes

)

select *
from final
