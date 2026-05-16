# Star Schema — Retail Pipeline

A complete dimensional model built from scratch applying Kimball methodology.

## What This Project Covers
- Fact table design at lowest grain
- Dimension tables with descriptive attributes
- SCD Type 2 implementation on dim_customer
- Data quality checks before gold layer
- Analytics queries against the star schema

## Schema

```
           [dim_date]
               |
[dim_store] ─ [fact_sales] ─ [dim_product]
               |
           [dim_customer]
```

## Run Order
```
01_schema.sql     → create schemas and raw tables
02_dimensions.sql → build dimension tables
03_facts.sql      → build fact table with calculated measures
04_analytics.sql  → run business queries against star schema
```
