{{ config(
    materialized = 'view'
) }}

select
 
    DESYNPUF_ID as desynpuf_id,

    try_to_date(BENE_BIRTH_DT, 'YYYYMMDD') as birth_date,
    try_to_date(BENE_DEATH_DT, 'YYYYMMDD') as death_date,
    BENE_SEX_IDENT_CD as sex_code,
    BENE_RACE_CD as race_code,

    case
        when BENE_ESRD_IND = 'Y' then true
        when BENE_ESRD_IND = '0' then false
        else null
    end as esrd_indicator,


    SP_STATE_CODE as state_code,
    BENE_COUNTY_CD as county_code,

    try_cast(BENE_HI_CVRAGE_TOT_MONS as integer) as part_a_coverage_months,
    try_cast(BENE_SMI_CVRAGE_TOT_MONS as integer) as part_b_coverage_months,
    try_cast(BENE_HMO_CVRAGE_TOT_MONS as integer) as hmo_coverage_months,
    try_cast(PLAN_CVRG_MOS_NUM as integer) as part_d_coverage_months,

    2009 as beneficiary_year,
    'CMS DE-SynPUF' as record_source

from RAW.BENEFICIARY_2009
