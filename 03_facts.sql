-- ════════════════════════════════════════════════════════
-- 03_facts.sql
-- Build fact table with calculated measures
-- Apply data quality checks before loading
-- ════════════════════════════════════════════════════════

CREATE TABLE warehouse.fact_sales AS
SELECT
    ROW_NUMBER() OVER (ORDER BY s.date, s.store_id, s.product_id) AS sale_id,
    COALESCE(
        TO_DATE(s.date,'DD/MM/YYYY'),
        TO_DATE(s.date,'DD-MM-YY'),
        TO_DATE(s.date,'YYYY-MM-DD')
    )                                           AS date_key,
    s.store_id                                  AS store_key,
    s.product_id                                AS product_key,
    s.qty::INTEGER                              AS qty,
    s.price::NUMERIC(10,2)                      AS price,
    p.unit_cost::NUMERIC(10,2)                  AS unit_cost,
    ROUND(s.price::NUMERIC - p.unit_cost::NUMERIC, 2)              AS profit_per_item,
    ROUND(s.qty::INTEGER * s.price::NUMERIC, 2)                    AS total_revenue,
    ROUND(s.qty::INTEGER * (s.price::NUMERIC - p.unit_cost::NUMERIC), 2) AS total_profit
FROM raw.sales    s
JOIN raw.products p ON s.product_id = p.product_id
WHERE
    s.product_id IS NOT NULL AND TRIM(s.product_id) != ''
    AND s.price ~ '^\d+(\.\d+)?$'
    AND s.qty   ~ '^\d+$';

-- ── Data Quality Checks ───────────────────────────────
SELECT 'NULL date_key'    AS check_name, COUNT(*) AS failures FROM warehouse.fact_sales WHERE date_key    IS NULL
UNION ALL
SELECT 'NULL store_key',                 COUNT(*)              FROM warehouse.fact_sales WHERE store_key   IS NULL
UNION ALL
SELECT 'NULL product_key',               COUNT(*)              FROM warehouse.fact_sales WHERE product_key IS NULL
UNION ALL
SELECT 'Negative revenue',               COUNT(*)              FROM warehouse.fact_sales WHERE total_revenue < 0
UNION ALL
SELECT 'Negative qty',                   COUNT(*)              FROM warehouse.fact_sales WHERE qty < 0;

-- ── Row count summary ─────────────────────────────────
SELECT COUNT(*) AS fact_rows FROM warehouse.fact_sales;
