# Dimensional Modelling

## What Is It?
Designing the blueprint of how data is structured in a data warehouse.
Organises data into fact and dimension tables optimised for analytics.

> Think of a warehouse with boxes scattered on the floor — you cannot
> find anything. Dimensional modelling is building shelves, labelling
> them, and packing boxes logically. Same space, everything findable,
> queries run fast.

---

## Two Table Types

### Fact Table — The Numbers
- Measurable business events
- Numbers you SUM, COUNT, AVERAGE
- Lowest grain — one row per event
- References dimensions through foreign keys

```sql
CREATE TABLE fact_sales (
    sale_id         SERIAL PRIMARY KEY,
    date_key        DATE,
    product_key     VARCHAR(10),
    store_key       VARCHAR(10),
    qty             INTEGER,
    price           NUMERIC(10,2),
    unit_cost       NUMERIC(10,2),
    total_revenue   NUMERIC(10,2),  -- qty x price
    profit_per_item NUMERIC(10,2),  -- price - unit_cost
    total_profit    NUMERIC(10,2)   -- qty x (price - unit_cost)
);
```

### Dimension Table — The Descriptions
- Descriptive context for facts
- The what, where, when, and who
- Wide and short — many columns, fewer rows

```sql
CREATE TABLE dim_product (
    product_key   VARCHAR(10) PRIMARY KEY,
    product_name  VARCHAR(100),
    category      VARCHAR(50),
    unit_cost     NUMERIC(10,2)
);
```

---

## Star Schema

```
           [dim_date]
               |
[dim_store] ─ [fact_sales] ─ [dim_product]
               |
           [dim_customer]
```

---

## Calculating Measures

```sql
total_revenue   = qty x price
profit_per_item = price - unit_cost       -- unit_cost from dim_product
total_profit    = qty x (price - unit_cost)
```

---

## Analytics Query

```sql
SELECT
    p.category,
    SUM(f.qty)           AS units_sold,
    SUM(f.total_revenue) AS revenue,
    SUM(f.total_profit)  AS profit,
    ROUND(SUM(f.total_profit) /
          SUM(f.total_revenue) * 100, 1) AS margin_pct
FROM fact_sales   f
JOIN dim_product  p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;
```

---

## Key Principles

| Principle | Rule |
|---|---|
| Lowest grain | One row per event — never pre-aggregate |
| Measures in fact | Numbers go in fact table |
| Descriptions in dim | Text and attributes go in dimensions |
| Deduplication | Each entity appears once per dimension table |
| Conformed dims | Share dimension tables across star schemas |
