# Slowly Changing Dimensions (SCD)

## What Are They?
Handle dimension attributes that change over time. The business requirement
determines which type to use.

---

## SCD Types

### Type 1 — Overwrite
No history retained. Overwrite the old value.

```sql
UPDATE dim_customer SET city = 'Johannesburg' WHERE customer_id = 1;
-- Cape Town is gone forever
```
**Use when:** Correcting errors. History does not matter.

---

### Type 2 — Full History ✅ Most Important
New row added for every change. Old row preserved with end date.

```sql
id | customer  | city         | effective   | expiry      | is_current
1  | Jabulani  | Cape Town    | 2024-01-01  | 2026-05-14  | N
2  | Jabulani  | Johannesburg | 2026-05-15  | 9999-12-31  | Y
```

**Three required columns:**
- `effective_date` — when record became active
- `expiry_date` — when record was replaced
- `is_current` — Y for latest record, N for historical

**Use when:** Full history matters. Kimball recommends as default.

---

### Type 3 — Previous Value Only
Extra column stores previous value. One change tracked only.

```sql
id | customer  | current_city  | previous_city
1  | Jabulani  | Johannesburg  | Cape Town
```
**Use when:** Only most recent change matters.

---

## How to Choose

| Scenario | Type |
|---|---|
| Correcting a data entry error | Type 1 |
| Tracking full address history | Type 2 |
| Tracking one previous value | Type 3 |
| Regulatory audit requirement | Type 2 |
