{{ config(
    materialized = 'table'
) }}

with provider_base as (

    select
        distinct provider_id
    from {{ ref('stg_inpatient_claims') }}
    where provider_id is not null

),

provider_activity_window as (

    select
        provider_id,
        min(clm_from_date) as effective_start_date,
        max(clm_thru_date) as effective_end_date
    from {{ ref('stg_inpatient_claims') }}
    where provider_id is not null
    group by provider_id

)

select
    {{ dbt_utils.generate_surrogate_key(['b.provider_id']) }} as provider_key,
    b.provider_id,
    'Inpatient Hospital' as provider_type,
    'CMS DE-SynPUF' as data_source,
    w.effective_start_date,
    w.effective_end_date,
    true as is_current

from provider_base b
left join provider_activity_window w
    on b.provider_id = w.provider_id
