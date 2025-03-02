# 📌 Step 1: Setup Environment  

## 🛠 Tools Used  
- **PostgreSQL**: Database for storing sales data.  
- **pgAdmin 4**: Used to write SQL queries and import/export data.  
- **Power BI**: For creating data visualizations.  

---

## 📥 How to Import Data into PostgreSQL  
The dataset was imported using **pgAdmin’s Import/Export Data Wizard**.  

### 🔹 Steps to Import Data:  
1. Open **pgAdmin 4** and navigate to the database schema (`public`).  
2. Right-click on the `coffee_shop_sales` table and select **Import/Export Data...**  
3. In the **Import** tab:  
   - Select the **CSV file**.  
   - Set **Delimiter:** `|`  
   - Enable **Header Row**.  
   - Choose **UTF-8 encoding**.  
4. Click **OK** to complete the import.  
5. Verify the import by running:  

   ```sql
   SELECT COUNT(*) FROM coffee_shop_sales;
   ```

---

## 📊 Database Structure  
After importing the data, we created the table with the following SQL script:

```sql
CREATE TABLE coffee_shop_sales (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE NOT NULL,
    transaction_time TIME NOT NULL,
    transaction_qty INT NOT NULL CHECK (transaction_qty > 0),
    store_id INT NOT NULL,
    store_location VARCHAR(100) NOT NULL,
    product_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    product_category VARCHAR(50) NOT NULL,
    product_type VARCHAR(100) NOT NULL,
    product_detail VARCHAR(255) NOT NULL
);
```
