# Chapter 8 — Queries, Modeling, and Transformation

**Book:** Fundamentals of Data Engineering — Joe Reis & Matt Housley  
**Status:** ✅ Complete  
**Date:** March 2026

---

## 🎯 What This Chapter Is About

Chapter 8 covers the transformation stage — where raw data becomes useful.
It covers queries, data modeling patterns, and transformation techniques
that turn raw data into something consumable by analysts, data scientists,
and the business.

> **Key idea:** Always model your data at the lowest grain possible.
> You can always aggregate up but you can never restore lost detail.

---

## 🗣️ SQL Language Types

| Type | Full Name | Purpose | Common Commands |
|---|---|---|---|
| DDL | Data Definition Language | Define database objects | CREATE, DROP, ALTER |
| DML | Data Manipulation Language | Manipulate data | SELECT, INSERT, UPDATE, DELETE, MERGE |
| DCL | Data Control Language | Control access | GRANT, REVOKE, DENY |
| TCL | Transaction Control Language | Control transactions | COMMIT, ROLLBACK |

---

## 🔍 How a Query Works

```
1. Parse SQL        → check syntax, validate objects, check permissions
2. Convert bytecode → machine-readable format
3. Query optimizer  → reorders and optimises steps for efficiency
4. Execute          → produces results
```

The **query optimizer** is the key. It determines the most efficient
execution path — reordering joins, applying predicates early, choosing
indexes, and minimising data scanned.

---

## ⚡ Query Performance Tips

### Optimise Your JOIN Strategy
- Pre-join frequently joined data — avoid repeating expensive operations
- Use CTEs instead of nested subqueries for readability
- Be aware of **row explosion** — many-to-many joins that multiply rows
- Apply filters early to reduce data before joining

### Use the Explain Plan
```sql
EXPLAIN SELECT * FROM fact_sales 
JOIN dim_product ON fact_sales.product_key = dim_product.product_key;
```

### Avoid Full Table Scans
- Select only the columns you need
- Use **partitioning** — split tables by date to reduce data scanned
- Use **clustering** — sort data within partitions

### Leverage Caching
- Cold query = runs from scratch
- Warm query = returns cached results instantly
- **Materialized views** = precomputed results stored for reuse

---

## 🌊 Streaming Window Types

| Window Type | How It Works | Use Case |
|---|---|---|
| Session | Groups events close together, closes on inactivity | User session analytics |
| Fixed-time (Tumbling) | Fixed time periods, no overlap | Metrics every 20 seconds |
| Sliding | Overlapping windows of fixed length | Rolling averages |

> **Watermarks** — threshold for determining whether late-arriving data
> falls within a window or is considered late.

---

## 🏗️ Data Modeling

### Three Levels

| Level | What It Contains |
|---|---|
| Conceptual | Business logic, entities, relationships |
| Logical | Adds data types, primary keys, foreign keys |
| Physical | Specific databases, schemas, tables |

### Normalization

| Normal Form | Rule |
|---|---|
| 1NF | Each column single value, unique primary key |
| 2NF | 1NF + no partial dependencies |
| 3NF | 2NF + no transitive dependencies |

---

## 🏭 Data Modeling Approaches

### Inmon
```
Source Systems → ETL → 3NF Data Warehouse → ETL → Data Marts → Reports
```
Best for: Large enterprises needing organization-wide integrated model.

### Kimball — Star Schema

```
              [dim_date]
                  |
[dim_customer] ─ [fact_sales] ─ [dim_product]
                  |
              [dim_store]
```

**Fact Tables:** quantitative events, lowest grain, numbers only, append-only  
**Dimension Tables:** descriptive context, wide, denormalized

#### Slowly Changing Dimensions

| Type | Behaviour | History |
|---|---|---|
| Type 1 | Overwrite existing record | None |
| Type 2 | Insert new record, flag old | Full ✅ Most common |
| Type 3 | Add column for previous value | Limited |

**SCD Type 2 example:**
```sql
id | customer  | city         | effective   | expiry      | is_current
1  | Jabulani  | Cape Town    | 2024-01-01  | 2026-05-14  | N
2  | Jabulani  | Johannesburg | 2026-05-15  | 9999-12-31  | Y
```

Best for: BI reporting, fast query performance.

### Data Vault

| Table | Purpose |
|---|---|
| Hub | Stores business keys |
| Link | Tracks relationships between hubs |
| Satellite | Stores descriptive attributes |

Insert-only. Business logic at query time. Best for: auditability, rapidly changing sources.

---

## 🔧 Transformation Patterns

### ETL vs ELT

| | ETL | ELT |
|---|---|---|
| Transform when? | Before loading | After loading |
| Best for | Legacy on-premises | Modern cloud warehouses |

### Update Patterns

| Pattern | Use When |
|---|---|
| Truncate and reload | Full refresh needed |
| Insert only | Historical audit trails |
| Soft delete | History matters |
| Hard delete | GDPR compliance |
| Upsert/Merge | Incremental updates, CDC |

> ⚠️ Never run many small inserts on columnar databases. Always batch updates.

---

## 🛠️ Key Tools

| Tool | Purpose |
|---|---|
| dbt | ELT — SQL transformations as code |
| Apache Spark | Distributed batch and streaming |
| Apache Flink | True streaming engine |
| Apache Airflow | Pipeline orchestration |
| Trino/Presto | Federated queries across sources |

---

## 📝 Key Terms

| Term | Meaning |
|---|---|
| Grain | Resolution of data — always model at lowest grain |
| Explain plan | Shows query optimizer execution path |
| Star schema | Fact table surrounded by dimension tables |
| SCD | Slowly Changing Dimension — tracks attribute changes |
| Conformed dimension | Shared dimension across multiple star schemas |
| Data vault | Insert-only model — hubs, links, satellites |
| CTE | Common Table Expression — reusable named subquery |
| Materialized view | Precomputed view stored for fast access |
| Watermark | Late-arriving data threshold in streaming |
| Row explosion | Unintended row multiplication in many-to-many joins |
| Upsert | Update existing or insert new records |

---

## 🙋 How This Applies to My Work

| Concept | Action |
|---|---|
| Kimball star schema | ✅ Building portfolio project |
| SCD Type 2 | ✅ Practising in current workshop |
| dbt | 🔄 Learning for ELT transformations |
| Query optimisation | 🔄 Running explain plans on existing queries |
| Data vault | 📖 Studying — relevant for flexible source systems |
| Apache Flink | 📖 Future streaming pipeline projects |
| Normalization | ✅ Applied on clinical datasets at work |
