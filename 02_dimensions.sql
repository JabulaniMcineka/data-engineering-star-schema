-- ════════════════════════════════════════════════════════
-- 02_dimensions.sql
-- Build dimension tables from clean staging data
-- ════════════════════════════════════════════════════════

-- dim_date
CREATE TABLE warehouse.dim_date AS
SELECT DISTINCT
    COALESCE(
        TO_DATE(date, 'DD/MM/YYYY'),
        TO_DATE(date, 'DD-MM-YY'),
        TO_DATE(date, 'YYYY-MM-DD')
    )                                  AS date_key,
    EXTRACT(DAY   FROM COALESCE(TO_DATE(date,'DD/MM/YYYY'),TO_DATE(date,'DD-MM-YY'),TO_DATE(date,'YYYY-MM-DD')))::INT AS day,
    EXTRACT(MONTH FROM COALESCE(TO_DATE(date,'DD/MM/YYYY'),TO_DATE(date,'DD-MM-YY'),TO_DATE(date,'YYYY-MM-DD')))::INT AS month,
    TO_CHAR(COALESCE(TO_DATE(date,'DD/MM/YYYY'),TO_DATE(date,'DD-MM-YY'),TO_DATE(date,'YYYY-MM-DD')),'Month') AS month_name,
    EXTRACT(YEAR  FROM COALESCE(TO_DATE(date,'DD/MM/YYYY'),TO_DATE(date,'DD-MM-YY'),TO_DATE(date,'YYYY-MM-DD')))::INT AS year
FROM raw.sales
WHERE date IS NOT NULL;

-- dim_product
CREATE TABLE warehouse.dim_product AS
SELECT
    product_id                     AS product_key,
    name                           AS product_name,
    category,
    unit_cost::NUMERIC(10,2)       AS unit_cost
FROM raw.products;

-- dim_store
CREATE TABLE warehouse.dim_store AS
SELECT DISTINCT
    store_id                       AS store_key,
    CASE store_id
        WHEN 'STR001' THEN 'Cape Town CBD'
        WHEN 'STR002' THEN 'Johannesburg North'
        ELSE 'Unknown'
    END                            AS store_name,
    CASE store_id
        WHEN 'STR001' THEN 'Western Cape'
        WHEN 'STR002' THEN 'Gauteng'
        ELSE 'Unknown'
    END                            AS region
FROM raw.sales;

-- Verify
SELECT 'dim_date'    AS dim, COUNT(*) FROM warehouse.dim_date
UNION ALL
SELECT 'dim_product' AS dim, COUNT(*) FROM warehouse.dim_product
UNION ALL
SELECT 'dim_store'   AS dim, COUNT(*) FROM warehouse.dim_store;
