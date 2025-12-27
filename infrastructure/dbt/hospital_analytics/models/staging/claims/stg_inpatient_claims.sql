{{ config(
    materialized = 'view'
) }}

select
   
    DESYNPUF_ID                               as beneficiary_id,
    CLM_ID                                   as claim_id,
    PRVDR_NUM                                as provider_id,
    SEGMENT                                  as segment,

   
    to_date(CLM_FROM_DT, 'YYYYMMDD')         as clm_from_date,
    to_date(CLM_THRU_DT, 'YYYYMMDD')         as clm_thru_date,
    to_date(CLM_ADMSN_DT, 'YYYYMMDD')        as clm_admission_date,
    to_date(NCH_BENE_DSCHRG_DT, 'YYYYMMDD')  as clm_discharge_date,
    
    datediff(
        day,
        to_date(CLM_ADMSN_DT, 'YYYYMMDD'),
        to_date(NCH_BENE_DSCHRG_DT, 'YYYYMMDD')
    )                                        as length_of_stay_days,

    
    CLM_UTLZTN_DAY_CNT                       as utilization_day_count,

    
    CLM_PMT_AMT                              as claim_payment_amount,
    NCH_PRMRY_PYR_CLM_PD_AMT                 as primary_payer_paid_amount,
    CLM_PASS_THRU_PER_DIEM_AMT               as pass_through_per_diem_amount,
    NCH_BENE_IP_DDCTBL_AMT                   as inpatient_deductible_amount,
    NCH_BENE_PTA_COINSRNC_LBLTY_AMT           as coinsurance_liability_amount,
    NCH_BENE_BLOOD_DDCTBL_LBLTY_AMT           as blood_deductible_liability_amount,

   
    CLM_DRG_CD                               as drg_code,
    ADMTNG_ICD9_DGNS_CD                      as admitting_diagnosis_code,


    ICD9_DGNS_CD_1,
    ICD9_DGNS_CD_2,
    ICD9_DGNS_CD_3,
    ICD9_DGNS_CD_4,
    ICD9_DGNS_CD_5,
    ICD9_DGNS_CD_6,
    ICD9_DGNS_CD_7,
    ICD9_DGNS_CD_8,
    ICD9_DGNS_CD_9,
    ICD9_DGNS_CD_10,


    ICD9_PRCDR_CD_1,
    ICD9_PRCDR_CD_2,
    ICD9_PRCDR_CD_3,
    ICD9_PRCDR_CD_4,
    ICD9_PRCDR_CD_5,
    ICD9_PRCDR_CD_6

from {{ source('raw', 'inpatient_claims') }}
