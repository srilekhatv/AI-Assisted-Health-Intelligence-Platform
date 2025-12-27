select
    claim_id,
    count(*) as primary_procedure_count
from {{ ref('bridge_inpatient_claim_procedure') }}
where is_primary_procedure = true
group by claim_id
having count(*) > 1
