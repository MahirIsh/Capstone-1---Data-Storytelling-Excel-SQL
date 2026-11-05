# Daily Progress

## November 2, 2026

### Project Setup

- Created GitHub repository
- Configured Git username and email
- Cloned repository to local machine
- Created daily progress log

### Database Setup

- Installed MySQL Server
- Connected MySQL Workbench to local server
- Created and verified MySQL connection
- Imported sample_sales database
- Verified all tables loaded correctly
- Verified 335,129 sales records were imported successfully

### Tables Identified

- inventory_categories
- inventory_subcategories
- management
- online_sales
- products
- shipper_list
- store_locations
- store_sales

## November 3, 2026

### New York Territory Analysis

- Calculated total revenue and transaction volume
- Identified top-performing products
- Identified lowest-performing products
- Analyzed revenue by store location
- Analyzed revenue by product category
- Analyzed monthly revenue trends
- Added SQL queries to queries.sql
- Calculated average transaction value ($139.53)
- Identified revenue growth from 2022 through 2025
- Analyzed top-performing technology products
- Identified highest-performing store-category combinations
- Completed SQL analysis for the New York territory

## November 4, 2026

### Query Fixes and Reorganization

- Renamed queries.sql to ishtiaq_sales_analysis.sql to match the project naming convention
- Resolved a merge conflict and removed leftover conflict markers from the script
- Reorganized the script by the six sales manager questions with clear comment labels
- Fixed an incomplete store-category combination query
- Combined total revenue and data coverage period into one query, with dates formatted to display correctly
- Rebuilt the region comparison to show New York revenue, East region revenue, and New York's share
- Added monthly transaction counts and average transaction amount by category
- Added an explicit store ranking using RANK()
- Added a growth-drivers query (active stores, transactions, and average sale by year)
- Added quarterly revenue by category to support the next-quarter recommendation
- Replaced the duplicate top-technology query with top products outside Technology & Accessories
- Wrote the Q1 2026 recommendation in the script

### Excel PivotChart

- Added a chart-export query for quarterly revenue by category
- Built a stacked-column PivotChart of New York quarterly revenue by category, 2022–2025

### Key Findings

- The data covers four full years: January 1, 2022 to December 31, 2025.
- New York accounts for 64.4% of East region in-store revenue ($4.33M of $6.72M).
- All 12 New York stores were active every year, so growth came from more transactions at existing stores, not new locations.
- Transactions rose 49% in 2023 with a similar average sale, stayed flat in 2024, and rose 74% in 2025 while the average sale fell 15%.
- Technology & Accessories is 21% of transactions but 71% of revenue; Stationery has the most transactions but only 1.5% of revenue.
- The New York and Rochester stores earn about twice the revenue of the other ten stores because they get about twice the transactions.
- Q1 has been strong for Technology and the weakest quarter for Textbooks every year.
- Q4 2025 was the best quarter on record at $440,455.

