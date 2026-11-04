-- ==========================================
-- Capstone 1: Data Storytelling, Excel & SQL
-- Student: Mahir Ishtiaq
-- Territory: New York
-- Purpose:
-- Analyze New York sales performance using
-- transaction, product, category, and
-- store-level metrics.
-- ==========================================

USE sample_sales;

-- Check table structure
DESCRIBE store_sales;

-- New York Store Locations
SELECT *
FROM store_locations
WHERE State = 'New York';

-- New York Revenue Summary
SELECT
    COUNT(*) AS TotalSalesTransactions,
    SUM(ss.Sale_Amount) AS TotalRevenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York';

-- Top 10 Products in New York
SELECT
    p.Product,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
JOIN products p
    ON ss.Prod_Num = p.ProdNum
WHERE sl.State = 'New York'
GROUP BY p.Product
ORDER BY Revenue DESC
LIMIT 10;

-- Lowest Revenue Products in New York
SELECT
    p.Product,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
JOIN products p
    ON ss.Prod_Num = p.ProdNum
WHERE sl.State = 'New York'
GROUP BY p.Product
ORDER BY Revenue ASC
LIMIT 10;

-- Revenue by Store Location
SELECT
    sl.StoreLocation,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
GROUP BY sl.StoreLocation
ORDER BY Revenue DESC;

-- Revenue by Category in New York
SELECT
    ic.Category,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN products p
    ON ss.Prod_Num = p.ProdNum
JOIN inventory_categories ic
    ON p.CategoryId = ic.CategoryId
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
GROUP BY ic.Category
ORDER BY Revenue DESC;

-- Monthly Revenue Trend for New York
SELECT
    YEAR(Transaction_Date) AS SalesYear,
    MONTH(Transaction_Date) AS SalesMonth,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
GROUP BY YEAR(Transaction_Date), MONTH(Transaction_Date)
ORDER BY SalesYear, SalesMonth;

-- Average Transaction Value for New York
SELECT
    ROUND(AVG(ss.Sale_Amount), 2) AS AvgTransactionValue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York';

-- Revenue by Year for New York
SELECT
    YEAR(Transaction_Date) AS SalesYear,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
GROUP BY YEAR(Transaction_Date)
ORDER BY SalesYear;

-- Top Technology Products in New York
SELECT
    p.Product,
    SUM(ss.Sale_Amount) AS Revenue
FROM store_sales ss
JOIN products p
    ON ss.Prod_Num = p.ProdNum
JOIN inventory_categories ic
    ON p.CategoryId = ic.CategoryId
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
AND ic.Category = 'Technology & Accessories'
GROUP BY p.Product
ORDER BY Revenue DESC
LIMIT 10;

-- Top Store and Category Combinations in New York
SELECT
    sl.StoreLocation,
    ic.Category,
    SUM(ss.Sale_Amount

-- New York Data Coverage Period
SELECT
    MIN(Transaction_Date) AS StartDate,
    MAX(Transaction_Date) AS EndDate
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York';

-- East Region Revenue Comparison
SELECT
    m.Region,
    SUM(ss.Sale_Amount) AS RegionRevenue
FROM store_sales ss
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
JOIN management m
    ON sl.State = m.State
WHERE m.Region = 'East'
GROUP BY m.Region;

-- Transactions and Average Transaction Amount by Category
SELECT
    ic.Category,
    COUNT(*) AS Transactions,
    ROUND(AVG(ss.Sale_Amount), 2) AS AvgTransactionAmount
FROM store_sales ss
JOIN products p
    ON ss.Prod_Num = p.ProdNum
JOIN inventory_categories ic
    ON p.CategoryId = ic.CategoryId
JOIN store_locations sl
    ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'New York'
GROUP BY ic.Category
ORDER BY Transactions DESC;

