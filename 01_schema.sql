-- ════════════════════════════════════════════════════════
-- 01_schema.sql
-- Create schemas and raw tables
-- ════════════════════════════════════════════════════════

DROP SCHEMA IF EXISTS raw       CASCADE;
DROP SCHEMA IF EXISTS warehouse CASCADE;

CREATE SCHEMA raw;
CREATE SCHEMA warehouse;

CREATE TABLE raw.sales (
    date        TEXT,
    store_id    TEXT,
    product_id  TEXT,
    qty         TEXT,
    price       TEXT,
    cashier     TEXT
);

CREATE TABLE raw.products (
    product_id  TEXT,
    name        TEXT,
    category    TEXT,
    unit_cost   TEXT
);
