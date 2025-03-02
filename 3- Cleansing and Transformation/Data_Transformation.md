# 📄 Step 3: Data Transformation Documentation - Maven Roasters Sales Analysis  

## 🔹 1. Overview  

This document describes the data transformation process for the dataset **coffee-shop-sales-revenue.csv**, covering:  

✅ **Importing the dataset into PostgreSQL**  
✅ **Data cleaning and quality checks**  
✅ **Aggregating business metrics**  
✅ **Exporting processed data for Power BI visualization**  

---

## 📂 2. Data Import & Table Creation  

### 📌 Import Method  

**pgAdmin → Import/Export Data (CSV format)**  
The dataset **coffee-shop-sales-revenue.csv** was imported into **PostgreSQL**  

### 📌 Table Creation 

The following SQL command was used to create the main table:  

```sql
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
```
## 🧹 3. Data Cleaning & Quality Checks
✅ Verify that the data was loaded successfully
```
SELECT COUNT(*) AS total_records FROM coffee_shop_sales;
```
✅ Check for missing values in key columns
```
SELECT * FROM coffee_shop_sales
WHERE transaction_date IS NULL OR product_id IS NULL OR transaction_qty IS NULL;
```
✅ Identify duplicate transactions

```
SELECT transaction_id, COUNT(*) AS duplicate_count
FROM coffee_shop_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;
```
✔️ No missing values or duplicates were found. The dataset is clean.

## 📊 4. Data Aggregation & Business Metrics

📌 Total sales and revenue
```
SELECT 
    COUNT(*) AS total_transactions, 
    SUM(transaction_qty) AS total_units_sold, 
    SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales;
```
📌 Top 5 best-selling products (by units sold)
```
SELECT product_type, SUM(transaction_qty) AS total_units_sold
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY total_units_sold DESC
LIMIT 5;
```
📌 Top 5 revenue-generating products
```
SELECT product_type, SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales
GROUP BY product_type
ORDER BY total_revenue DESC
LIMIT 5;
```
📌 Revenue by store location
```
SELECT store_location, SUM(transaction_qty * unit_price) AS total_revenue
FROM coffee_shop_sales
GROUP BY store_location
ORDER BY total_revenue DESC;
```
📌 Sales by hour of the day
```
SELECT EXTRACT(HOUR FROM transaction_time) AS hour, 
       SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY hour 
ORDER BY total_sales DESC;
```
📌 Best-selling days of the week
```
SELECT TRIM(TO_CHAR(transaction_date, 'Day')) AS day_of_week,
       EXTRACT(DOW FROM transaction_date) AS day_number,
       SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY day_of_week, day_number
ORDER BY day_number;
```
📌 Monthly sales performance
```
SELECT TRIM(TO_CHAR(transaction_date, 'Month')) AS month,
       EXTRACT(MONTH FROM transaction_date) AS month_number,
       SUM(transaction_qty) AS total_sales
FROM coffee_shop_sales
GROUP BY month, month_number
ORDER BY month_number;
```
✔️ These queries were used to generate insights for the Power BI dashboard.

## 📂 5. Data Export for Power BI

📌 Export Method
pgAdmin → Export Data (CSV format)

📌 Generated CSV Files

The processed data was exported as CSV files for visualization in Power BI:

```
📁 exported_data/
├── total_sales_revenue.csv
├── top_selling_products.csv
├── top_revenue_products.csv
├── revenue_by_store.csv
├── sales_by_hour.csv
├── sales_by_day.csv
└── sales_by_month.csv
```
## ✅ 6. Conclusion & Next Steps

✔️ A structured database was created in PostgreSQL.

✔️ Data quality checks were performed.

✔️ Key sales metrics were calculated.

✔️ Data was exported for visualization in Power BI.

🔜 Next Step: Build the Power BI Dashboard.
