{{ config(
    materialized = 'view'
) }}

select
    beneficiary_id,
    year,

    -- Coverage / eligibility
    bene_hi_cvrage_tot_mons        as part_a_coverage_months,
    bene_smi_cvrage_tot_mons       as part_b_coverage_months,
    bene_hmo_cvrage_tot_mons       as hmo_coverage_months,
    plan_cvrg_mos_num              as part_d_coverage_months,

    -- Chronic condition indicators (annual)
    sp_alzhdmta                    as cc_alzheimers,
    sp_chf                         as cc_heart_failure,
    sp_chrnkidn                    as cc_chronic_kidney_disease,
    sp_cncr                        as cc_cancer,
    sp_copd                        as cc_copd,
    sp_depressn                    as cc_depression,
    sp_diabetes                    as cc_diabetes,
    sp_ischmcht                    as cc_ischemic_heart_disease,
    sp_osteoprs                    as cc_osteoporosis,
    sp_ra_oa                       as cc_rheumatoid_arthritis_oa,
    sp_strketia                    as cc_stroke_tia

from {{ source('cms_beneficiary_raw', 'BENEFICIARY_ELIGIBILITY_YEAR') }}
