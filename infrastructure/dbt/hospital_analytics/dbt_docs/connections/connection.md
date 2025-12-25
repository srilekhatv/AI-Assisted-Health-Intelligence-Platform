# dbt ↔ Snowflake Connection Configuration  
AI-Assisted Health Intelligence Platform

---

## 1. Purpose

This document records the **final, working configuration** used to connect **dbt Core** to **Snowflake** for the **AI-Assisted Health Intelligence Platform** project.

The goals of this documentation are:

- Reproducibility  
- Configuration clarity  
- Future reference and onboarding  
- Prevention of re-debugging known setup issues  

This configuration represents a **validated and stable baseline** for all dbt work in this repository.

---

## 2. Environment Overview

| Component | Value |
|---------|------|
| Data Warehouse | Snowflake (Trial – Enterprise Edition) |
| Transformation Tool | dbt Core |
| Execution Environment | Local (Windows) |
| Python Version | 3.10.x |
| dbt Version | 1.11.x |
| Adapter | dbt-snowflake |

---

## 3. Snowflake Account Details (Final)

The project connects using a **region-based Snowflake account identifier** with password authentication.

### Account Identifier

```
ATB38780.us-west-2
```

**Note:**  
This identifier was verified to work reliably for this Snowflake trial account and is confirmed to be compatible with dbt Core.

---

## 4. Authentication Method

**Authentication Type:** Password-based authentication

### Rationale

- Browser-based authentication was inconsistent for this trial account  
- SSO authentication was unreliable in a local dbt Core setup  
- Password authentication provided a **stable, repeatable, non-interactive** connection  

This method is considered **locked** unless Snowflake account constraints change.

---

## 5. dbt Profile Configuration

The dbt profile is defined in the following file (excluded from version control):

```
C:\Users\<username>\.dbt\profiles.yml
```

### dbt Profile: `hospital_analytics`

```yaml
hospital_analytics:
  target: dev
  outputs:
    dev:
      type: snowflake
      account: ATB38780.us-west-2
      user: SRITV
      password: <stored securely, not committed>
      role: HOSPITAL_ROLE
      warehouse: COMPUTE_WH
      database: HOSPITAL_DB
      schema: STAGING
      threads: 4
```

---

## 6. dbt Project Configuration

The dbt project is explicitly bound to the above profile in `dbt_project.yml`:

```yaml
profile: hospital_analytics
```

This ensures all dbt executions use the correct Snowflake connection without requiring manual profile flags.

---

## 7. Validation

Connectivity and permissions were validated using the following command:

```bash
dbt debug
```

### Successful validation confirms:

- dbt can authenticate with Snowflake  
- The specified warehouse is accessible  
- The role has required permissions  
- The database and schema context is valid  
- The environment is ready for transformations  

This validation step marks the **end of environment setup**.

---

## 8. Security Notes

- `profiles.yml` is excluded from version control  
- Passwords are never committed to GitHub  
- This repository stores **documentation and configuration only**, not secrets  
- Role-based access is enforced via `HOSPITAL_ROLE`  

---

## 9. Scope

This configuration applies to:

- Claims & Cost domain  
- All dbt models within this repository  
- All transformations executed in Snowflake via dbt  

Authentication, account identifiers, and role permissions are considered **locked** unless Snowflake account details change.

---

## 10. Status

Connection established  
Permissions verified  
Environment stable  
Ready for model development  

**Next step:** Build foundational dbt models, starting with `dim_date`.
