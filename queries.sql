-- Capstone 1: Data Storytelling, Excel & SQL
-- Territory: New York

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