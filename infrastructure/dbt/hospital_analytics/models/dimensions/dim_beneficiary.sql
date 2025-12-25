{{ config(
    materialized = 'table'
) }}

with all_beneficiaries as (
    select * from {{ ref('stg_beneficiary_2008') }}
    union all
    select * from {{ ref('stg_beneficiary_2009') }}
    union all
    select * from {{ ref('stg_beneficiary_2010') }}
),

ranked_beneficiaries as (
    select
        *,
        row_number() over (
            partition by desynpuf_id
            order by beneficiary_year desc
        ) as recency_rank
    from all_beneficiaries
),

latest_beneficiaries as (
    select
        desynpuf_id,
        max(birth_date) as birth_date,
        max(death_date) as death_date,
        max(case when recency_rank = 1 then sex_code end) as sex_code,
        max(case when recency_rank = 1 then race_code end) as race_code,
        max(case when recency_rank = 1 then esrd_indicator end) as esrd_indicator,
        max(case when recency_rank = 1 then state_code end) as state_code,
        max(case when recency_rank = 1 then county_code end) as county_code,
        max(record_source) as record_source
    from ranked_beneficiaries
    group by desynpuf_id
)

select
    {{ dbt_utils.generate_surrogate_key(['desynpuf_id']) }} as beneficiary_key,
    desynpuf_id,
    birth_date,
    death_date,
    sex_code,
    race_code,
    esrd_indicator,
    state_code,
    county_code,
    record_source
from latest_beneficiaries
