-- Capstone 1: Business Analysis with SQL and Excel
-- Student: Mahir Ishtiaq
-- Territory: New York
-- Region: East

USE sample_sales;

-- Setup: New York store locations (12 stores)

SELECT *
FROM store_locations
WHERE State = 'New York';

-- Question 1: Total revenue for New York and the date range the data covers
-- (DATE_FORMAT returns the dates as text so Workbench shows them exactly as stored)

SELECT
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue,
    DATE_FORMAT(MIN(SS.Transaction_Date), '%Y-%m-%d') AS First_Transaction,
    DATE_FORMAT(MAX(SS.Transaction_Date), '%Y-%m-%d') AS Last_Transaction
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York';

-- Question 2: Revenue by year

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    ROUND(SUM(SS.Sale_Amount), 2) AS Yearly_Revenue
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    YEAR(SS.Transaction_Date)
ORDER BY
    Sales_Year;

-- Question 2: Revenue by year and month

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    MONTH(SS.Transaction_Date) AS Sales_Month,
    ROUND(SUM(SS.Sale_Amount), 2) AS Monthly_Revenue
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    YEAR(SS.Transaction_Date),
    MONTH(SS.Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Month;

-- Question 2: Growth drivers by year
-- (did revenue grow from more stores, more transactions, or bigger purchases?)

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    COUNT(DISTINCT SS.Store_ID) AS Active_Stores,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(SS.Sale_Amount), 2) AS Average_Transaction_Amount,
    ROUND(SUM(SS.Sale_Amount), 2) AS Yearly_Revenue,
    ROUND(SUM(SS.Sale_Amount) / COUNT(DISTINCT SS.Store_ID), 2) AS Revenue_Per_Store
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    YEAR(SS.Transaction_Date)
ORDER BY
    Sales_Year;

-- Question 3: New York revenue compared to the East region
-- (the region is looked up from the management table, and the result
--  shows New York revenue, region revenue, and New York's share)

SELECT
    (SELECT Region FROM management WHERE State = 'New York' LIMIT 1) AS Region,
    ROUND(SUM(CASE WHEN SL.State = 'New York' THEN SS.Sale_Amount ELSE 0 END), 2) AS New_York_Revenue,
    ROUND(SUM(SS.Sale_Amount), 2) AS Region_Revenue,
    ROUND(100 * SUM(CASE WHEN SL.State = 'New York' THEN SS.Sale_Amount ELSE 0 END)
          / SUM(SS.Sale_Amount), 2) AS New_York_Pct_Of_Region
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State IN (
    SELECT State
    FROM management
    WHERE Region = (SELECT Region FROM management WHERE State = 'New York' LIMIT 1)
);

-- Question 4: Transactions per month and average transaction amount by category

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    MONTH(SS.Transaction_Date) AS Sales_Month,
    IC.Category,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(SS.Sale_Amount), 2) AS Average_Transaction_Amount
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    YEAR(SS.Transaction_Date),
    MONTH(SS.Transaction_Date),
    IC.Category
ORDER BY
    Sales_Year,
    Sales_Month,
    Transaction_Count DESC;

-- Question 4: Category totals across the whole period (summary view)

SELECT
    IC.Category,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(SS.Sale_Amount), 2) AS Average_Transaction_Amount,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    IC.Category
ORDER BY
    Total_Revenue DESC;

-- Question 5: Rank New York stores by in-store revenue

SELECT
    RANK() OVER (ORDER BY SUM(SS.Sale_Amount) DESC) AS Store_Rank,
    SL.StoreId AS Store_ID,
    SL.StoreLocation AS Store_Location,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue,
    COUNT(*) AS Transaction_Count,
    ROUND(AVG(SS.Sale_Amount), 2) AS Average_Transaction_Amount
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    SL.StoreId,
    SL.StoreLocation
ORDER BY
    Store_Rank;

-- Question 6: Supporting query - revenue by quarter, one column per category
-- (the data ends in Q4 2025, so "next quarter" is Q1 2026)

SELECT
    YEAR(SS.Transaction_Date) AS Sales_Year,
    QUARTER(SS.Transaction_Date) AS Sales_Quarter,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue,
    ROUND(SUM(CASE WHEN IC.Category = 'Technology & Accessories' THEN SS.Sale_Amount ELSE 0 END), 2) AS Technology,
    ROUND(SUM(CASE WHEN IC.Category = 'Textbooks' THEN SS.Sale_Amount ELSE 0 END), 2) AS Textbooks,
    ROUND(SUM(CASE WHEN IC.Category = 'Apparel and Merchandise' THEN SS.Sale_Amount ELSE 0 END), 2) AS Apparel,
    ROUND(SUM(CASE WHEN IC.Category = 'Art Supplies' THEN SS.Sale_Amount ELSE 0 END), 2) AS Art_Supplies,
    ROUND(SUM(CASE WHEN IC.Category = 'Books (General)' THEN SS.Sale_Amount ELSE 0 END), 2) AS General_Books,
    ROUND(SUM(CASE WHEN IC.Category = 'Stationery and Supplies' THEN SS.Sale_Amount ELSE 0 END), 2) AS Stationery
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    YEAR(SS.Transaction_Date),
    QUARTER(SS.Transaction_Date)
ORDER BY
    Sales_Year,
    Sales_Quarter;

-- Question 6: Business Recommendation

-- For Q1 2026, I recommend that EmporiUm focus its New York sales
-- attention on Technology & Accessories, especially laptops, at the
-- New York and Rochester stores.
--
-- Technology is 71% of New York revenue ($3.07M of $4.33M), and all
-- 10 top-selling products are laptops. Q1 has been a strong quarter
-- for technology every year: tech revenue rose from Q4 to Q1 by 75%
-- in 2023, 26% in 2024, and 68% in 2025. Momentum going in is strong,
-- since Q4 2025 was the best quarter on record ($440,455), up 83% from
-- Q4 2024, with technology revenue more than doubling.
--
-- New York and Rochester bring in about twice the revenue of any other
-- store because they get about twice the transactions, so stock and
-- staff there reach the most customers. Pushing technology also helps
-- average sale size: 2025 transactions rose 74%, but the average sale
-- fell 15%, and technology sales average $476.
--
-- Textbook promotions should wait until Q2 and Q3, because Q1 has been
-- the weakest quarter for Textbooks every year (down 19-31% from Q4).

-- Chart export: quarterly revenue by category for the Excel PivotChart
-- (one row per quarter per category, the layout a PivotChart needs;
--  export as CSV and save in Excel as ishtiaq_territory_chart.xlsx)

SELECT
    CONCAT(YEAR(SS.Transaction_Date), ' Q', QUARTER(SS.Transaction_Date)) AS Year_Quarter,
    IC.Category,
    COUNT(*) AS Transaction_Count,
    ROUND(SUM(SS.Sale_Amount), 2) AS Revenue
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    Year_Quarter,
    IC.Category
ORDER BY
    Year_Quarter,
    Revenue DESC;

-- Additional Analysis: Top 10 products in New York

SELECT
    P.Product,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
JOIN products P
    ON SS.Prod_Num = P.ProdNum
WHERE SL.State = 'New York'
GROUP BY
    P.Product
ORDER BY
    Total_Revenue DESC
LIMIT 10;

-- Additional Analysis: Lowest 10 revenue products in New York

SELECT
    P.Product,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue
FROM store_sales SS
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
JOIN products P
    ON SS.Prod_Num = P.ProdNum
WHERE SL.State = 'New York'
GROUP BY
    P.Product
ORDER BY
    Total_Revenue ASC
LIMIT 10;

-- Additional Analysis: Top 10 products outside Technology & Accessories
-- (the overall top 10 is all technology, so this shows what else sells)

SELECT
    IC.Category,
    P.Product,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
  AND IC.Category <> 'Technology & Accessories'
GROUP BY
    IC.Category,
    P.Product
ORDER BY
    Total_Revenue DESC
LIMIT 10;

-- Additional Analysis: Top 10 store and category combinations in New York

SELECT
    SL.StoreLocation AS Store_Location,
    IC.Category,
    ROUND(SUM(SS.Sale_Amount), 2) AS Total_Revenue
FROM store_sales SS
JOIN products P
    ON SS.Prod_Num = P.ProdNum
JOIN inventory_categories IC
    ON P.CategoryId = IC.CategoryId
JOIN store_locations SL
    ON SS.Store_ID = SL.StoreId
WHERE SL.State = 'New York'
GROUP BY
    SL.StoreLocation,
    IC.Category
ORDER BY
    Total_Revenue DESC
LIMIT 10;