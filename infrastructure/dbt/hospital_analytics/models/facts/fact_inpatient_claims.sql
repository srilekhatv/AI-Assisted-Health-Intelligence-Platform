{{ config(
    materialized = 'table'
) }}

with base_claims as (

    select
        claim_id,
        beneficiary_id,
        provider_id,
        clm_admission_date,
        clm_discharge_date,
        segment,
        drg_code,
        admitting_diagnosis_code,

        claim_payment_amount,
        primary_payer_paid_amount,
        pass_through_per_diem_amount,
        inpatient_deductible_amount,
        coinsurance_liability_amount,
        blood_deductible_liability_amount,
        utilization_day_count,
        length_of_stay_days

    from {{ ref('stg_inpatient_claims') }}

),

fact_with_keys as (

    select
        {{ dbt_utils.generate_surrogate_key(['b.claim_id', 'segment']) }} as fact_claim_key,

        ben.beneficiary_key,
        prov.provider_key,
        adm.date_key as admission_date_key,
        dis.date_key as discharge_date_key,

        b.claim_id,
        b.segment,
        b.drg_code,
        b.admitting_diagnosis_code,

        b.claim_payment_amount,
        b.primary_payer_paid_amount,
        b.pass_through_per_diem_amount,
        b.inpatient_deductible_amount,
        b.coinsurance_liability_amount,
        b.blood_deductible_liability_amount,
        b.utilization_day_count,
        b.length_of_stay_days

    from base_claims b

    left join {{ ref('dim_beneficiary') }} ben
        on b.beneficiary_id = ben.desynpuf_id

    left join {{ ref('dim_provider') }} prov
        on b.provider_id = prov.provider_id

    left join {{ ref('dim_date') }} adm
        on b.clm_admission_date = adm.full_date

    left join {{ ref('dim_date') }} dis
        on b.clm_discharge_date = dis.full_date
)

select *
from fact_with_keys
