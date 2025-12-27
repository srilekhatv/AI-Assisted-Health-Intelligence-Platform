-- Fail if any claim has more than one principal diagnosis

select
    claim_id,
    count(*) as principal_diagnosis_count
from {{ ref('bridge_inpatient_claim_diagnosis') }}
where is_principal_diagnosis = true
group by claim_id
having count(*) > 1

