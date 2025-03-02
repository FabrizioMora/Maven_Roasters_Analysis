-- 1️ Creating the main table for Coffee Shop Sales
CREATE TABLE coffee_shop_sales (
    transaction_id SERIAL PRIMARY KEY,  -- Unique identifier for each transaction
    transaction_date DATE NOT NULL,  -- Date of the transaction
    transaction_time TIME NOT NULL,  -- Time of the transaction
    transaction_qty INT NOT NULL CHECK (transaction_qty > 0),  -- Quantity of items sold (must be positive)
    store_id INT NOT NULL,  -- Unique identifier for the store
    store_location VARCHAR(100) NOT NULL,  -- Store's location
    product_id INT NOT NULL,  -- Unique identifier for the product
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),  -- Price per unit of the product (non-negative)
    product_category VARCHAR(50) NOT NULL,  -- General category of the product
    product_type VARCHAR(100) NOT NULL,  -- Specific type of the product
    product_detail VARCHAR(255) NOT NULL  -- Detailed product description
);

-- 2️ Data Exploration (Checking Data Quality)
-- 2.1 ✅ Verify if data has been loaded
SELECT COUNT(*) AS total_records FROM coffee_shop_sales;

-- 2.2 ✅ Preview the first 10 records
SELECT * FROM coffee_shop_sales LIMIT 10;

-- 2.3 ✅ Check for missing values in key columns
SELECT * FROM coffee_shop_sales
WHERE transaction_date IS NULL OR product_id IS NULL OR transaction_qty IS NULL;

-- 2.4 ✅ Identify duplicate transactions
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM coffee_shop_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- 3️ Sales & Revenue Analysis
-- 3.1 ✅ Total Sales and Revenue
SELECT 
    COUNT(*) AS total_transactions, 
    SUM(transaction_qty) AS total_units_sold, 
    SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales;

-- 3.2 ✅ Count of Unique Product Types
SELECT COUNT(DISTINCT product_type) AS unique_products
FROM coffee_shop_sales;

-- 3.3 ✅ Top 5 Best-Selling Products
SELECT product_type, SUM(transaction_qty) AS total_units_sold
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY total_units_sold DESC
LIMIT 5;

-- 3.4 ✅ Top 5 Products by Revenue
SELECT 
    product_type, 
    SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY total_revenue DESC
LIMIT 5;

-- 3.5 ✅ Revenue by Store Location
SELECT store_location, 
       SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales
GROUP BY store_location
ORDER BY total_revenue DESC;

-- 4️ Sales Trends Over Time
-- 4.1 ✅ Best Day of the Week for Sales
SELECT 
    TRIM(TO_CHAR(transaction_date, 'Day')) AS day_of_week,
    EXTRACT(DOW FROM transaction_date) AS day_number,
    SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY day_of_week, day_number
ORDER BY day_number;  -- Orders from Sunday (0) to Saturday (6)

-- 4.2 ✅ Monthly Sales Performance
SELECT 
    TRIM(TO_CHAR(transaction_date, 'Month')) AS month,
    EXTRACT(MONTH FROM transaction_date) AS month_number,
    SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY month, month_number
ORDER BY month_number;  -- Orders from January (1) to December (12)

-- 4.3 ✅ Best Hours for Sales
SELECT 
    EXTRACT(HOUR FROM transaction_time) AS hour, 
    SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY hour 
ORDER BY total_sales DESC;
