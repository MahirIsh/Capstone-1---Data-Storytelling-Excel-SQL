# Capstone 1: New York Sales Analysis by Mahir Ishtiaq

## Project Overview

This project analyzes New York sales performance for EmporiUm, a student bookstore chain that sells textbooks, technology, art supplies and other products. Using SQL and Excel, I answered a sales manager's questions about revenue trends, regional performance, product categories and store rankings, and recommended where to focus sales attention next quarter.

## Territory and Region

- **Territory:** New York
- **Region:** East
- **Scope:** In-store sales, January 1, 2022 to December 31, 2025
- **Stores (12):** Albany, Brooklyn, Buffalo, Elmira, Ithaca, New York, Oswego, Plattsburgh, Poestenkill, Queens, Rochester, Syracuse

## Tools Used

- **MySQL Workbench:** wrote and ran queries using JOINs, aggregate functions, GROUP BY, CASE, subqueries and the RANK() window function
- **Microsoft Excel:** built a PivotTable and PivotChart from the query results
- **Git and GitHub:** tracked daily progress and published the project files

## Analysis Questions

1. What is total New York revenue, and what period does the data cover?
2. How much revenue did New York generate each year and month?
3. How does New York revenue compare with the East region?
4. What are the monthly transaction counts and average transaction amounts by product category?
5. How do New York stores rank by in-store revenue?
6. What should the business prioritize next quarter?

## Key Findings

### 1. Total Revenue

- Total revenue: **$4,330,817.09** across 31,039 transactions
- Average transaction: $139.53
- Data range: four full years, January 1, 2022 to December 31, 2025

### 2. Yearly and Monthly Trends

| Year | Revenue | Change |
|---|---|---|
| 2022 | $687,382.03 | — |
| 2023 | $1,044,157.05 | +51.9% |
| 2024 | $1,046,676.37 | +0.2% |
| 2025 | $1,552,601.64 | +48.3% |

- All 12 stores were open every year, so growth came from more customers at existing stores, not new locations.
- Transactions rose 49% in 2023, stayed flat in 2024, and rose 74% in 2025, while the average sale fell 15% in 2025.
- Q4 2025 was the best quarter on record at $440,455.29.

### 3. New York vs. the East Region

- New York revenue: $4,330,817.09
- East region in-store revenue: $6,723,039.53
- New York contributed **64.42%** of East region in-store revenue.

### 4. Product Categories

| Category | Transactions | Avg. Transaction | Revenue |
|---|---|---|---|
| Technology & Accessories | 6,452 | $476.00 | $3,071,158.25 |
| Textbooks | 4,424 | $173.34 | $766,877.54 |
| Apparel and Merchandise | 6,129 | $32.34 | $198,205.14 |
| Art Supplies | 5,052 | $31.44 | $158,826.79 |
| Books (General) | 2,433 | $28.74 | $69,919.28 |
| Stationery and Supplies | 6,549 | $10.05 | $65,830.09 |

- Technology & Accessories brought in 71% of revenue from only 21% of transactions, and all 10 top-selling products are laptops.
- Stationery had the most transactions but only 1.5% of revenue.

### 5. Store Rankings

- Highest-performing stores: New York ($621,565.02) and Rochester ($607,148.21)
- Lowest-performing store: Queens ($288,553.14)
- The other ten stores are closely grouped between $289K and $334K.
- New York and Rochester earn about twice the revenue of the rest because they get about twice the transactions. Average sale amounts are similar across all stores ($133 to $153).

## Excel PivotChart

I created a stacked-column PivotChart of New York quarterly revenue by product category from 2022 to 2025. It shows overall growth, Technology's share of revenue, and the seasonal pattern behind the recommendation: Technology rises from Q4 to Q1 every year, while Textbooks hit their low point in Q1.

## Business Recommendation

For Q1 2026, I recommend focusing sales attention on **Technology & Accessories, especially laptops, at the New York and Rochester stores.**

- Technology is 71% of New York revenue, and all 10 top-selling products are laptops.
- Q1 has been strong for technology every year: tech revenue rose from Q4 to Q1 by 75% in 2023, 26% in 2024 and 68% in 2025.
- Momentum is strong going in, since Q4 2025 was the best quarter on record.
- New York and Rochester have the most customer traffic, so stock and staff there reach the most buyers.
- Pushing high-value technology sales also helps recover average transaction size, which fell 15% in 2025.
- Textbook promotions are better timed for Q2 and Q3, because Q1 has been the weakest quarter for Textbooks every year.

## Project Files

- `ishtiaq_sales_analysis.sql`: SQL queries answering all six questions, with the recommendation in comments
- `ishtiaq_NewYork_chart.xlsx`: Excel PivotTable and PivotChart of quarterly revenue by category
- `daily_progress.md`: daily log of project progress
- `README.md`: project overview, findings and recommendation

## Capstone Video
[Watch the 10-minute project walkthrough](https://1drv.ms/p/c/50f06bd31489f7c4/IQBxCmnr5OrPSKgEbIjA06TFAYez-VuECZRure133NyMTjc?e=qT9FJD)
 
The walkthrough was recorded in PowerPoint. Open the file and start the slideshow to play the narration.
