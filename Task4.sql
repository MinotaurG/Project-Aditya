-- Task 3: Perform OLAP operations on sales data

-- Step 1: Create a database (using PostgreSQL) and a table for sales data

-- Create the "sales_sample" table with the specified columns
CREATE TABLE sales_sample (
    Product_id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC
);

-- Step 2: Insert 10 sample records into the "sales_sample" table
INSERT INTO sales_sample (Product_id, Region, Date, Sales_Amount)
VALUES
    (101, 'East', '2023-05-01', 50000),
    (102, 'West', '2023-05-02', 60000),
    (103, 'North', '2023-05-03', 55000),
    (104, 'South', '2023-05-04', 48000),
    (101, 'East', '2023-05-05', 52000),
    (102, 'West', '2023-05-06', 61000),
    (105, 'North', '2023-05-07', 49000),
    (103, 'South', '2023-05-08', 54000),
    (106, 'East', '2023-05-09', 53000),
    (104, 'West', '2023-05-10', 62000);

-- Step 3: Perform OLAP operations

-- a) Drill Down - Analyze sales data from region to product level
SELECT Region, Product_id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_id
ORDER BY Region, Product_id;

-- b) Rollup - Summarize sales data from product to region level
SELECT Region, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region
ORDER BY Region;

-- c) Cube - Explore sales data from different dimensions
SELECT Region, Product_id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY ROLLUP (Region, Product_id, Date)
ORDER BY Region, Product_id, Date;

-- d) Slice - Extract data for a specific region and date range
SELECT Region, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE Region = 'East' AND Date BETWEEN '2023-05-01' AND '2023-05-05'
GROUP BY Region, Date
ORDER BY Region, Date;

-- e) Dice - Extract data based on specific combinations of product, region, and date
SELECT Region, Product_id, Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
WHERE Region = 'East' AND Product_id = 101 AND Date BETWEEN '2023-05-01' AND '2023-05-05'
GROUP BY Region, Product_id, Date
ORDER BY Region, Product_id, Date;
