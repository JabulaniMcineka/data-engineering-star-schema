-- ════════════════════════════════════════════════════════
-- 04_analytics.sql
-- Business queries against the star schema
-- ════════════════════════════════════════════════════════

-- Query 1: Revenue by product category
SELECT
    p.category,
    COUNT(*)                       AS transactions,
    SUM(f.qty)                     AS units_sold,
    ROUND(SUM(f.total_revenue), 2) AS revenue,
    ROUND(SUM(f.total_profit),  2) AS profit
FROM warehouse.fact_sales   f
JOIN warehouse.dim_product  p ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY revenue DESC;


-- Query 2: Revenue by store and region
SELECT
    s.store_name,
    s.region,
    ROUND(SUM(f.total_revenue), 2) AS revenue,
    ROUND(SUM(f.total_profit),  2) AS profit
FROM warehouse.fact_sales  f
JOIN warehouse.dim_store   s ON f.store_key = s.store_key
GROUP BY s.store_name, s.region
ORDER BY profit DESC;


-- Query 3: Profit margin per product
SELECT
    p.product_name,
    p.category,
    ROUND(AVG(f.unit_cost),       2)                    AS avg_cost,
    ROUND(AVG(f.price),           2)                    AS avg_price,
    ROUND(AVG(f.profit_per_item), 2)                    AS avg_profit,
    ROUND(AVG(f.profit_per_item) /
          NULLIF(AVG(f.price), 0) * 100, 1)             AS margin_pct
FROM warehouse.fact_sales   f
JOIN warehouse.dim_product  p ON f.product_key = p.product_key
GROUP BY p.product_name, p.category
ORDER BY margin_pct DESC;


-- Query 4: Daily revenue trend
SELECT
    d.date_key,
    d.month_name,
    ROUND(SUM(f.total_revenue), 2) AS daily_revenue
FROM warehouse.fact_sales f
JOIN warehouse.dim_date   d ON f.date_key = d.date_key
GROUP BY d.date_key, d.month_name
ORDER BY d.date_key;
