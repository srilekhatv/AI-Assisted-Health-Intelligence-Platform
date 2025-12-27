{{ config(
    materialized = 'table'
) }}

select
    beneficiary_id,
    year,

    part_a_coverage_months,
    part_b_coverage_months,
    hmo_coverage_months,
    part_d_coverage_months,

    cc_alzheimers                    = 1 as has_alzheimers,
    cc_heart_failure                 = 1 as has_heart_failure,
    cc_chronic_kidney_disease        = 1 as has_chronic_kidney_disease,
    cc_cancer                        = 1 as has_cancer,
    cc_copd                          = 1 as has_copd,
    cc_depression                    = 1 as has_depression,
    cc_diabetes                      = 1 as has_diabetes,
    cc_ischemic_heart_disease        = 1 as has_ischemic_heart_disease,
    cc_osteoporosis                  = 1 as has_osteoporosis,
    cc_rheumatoid_arthritis_oa       = 1 as has_rheumatoid_arthritis_oa,
    cc_stroke_tia                    = 1 as has_stroke_tia

from {{ ref('stg_beneficiary_eligibility_year') }}
