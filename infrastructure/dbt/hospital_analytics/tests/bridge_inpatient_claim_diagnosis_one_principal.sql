select
    fact_claim_key,
    count(*) as principal_count
from analytics.bridge_inpatient_claim_diagnosis
where is_principal_diagnosis = true
group by fact_claim_key
having count(*) != 1
