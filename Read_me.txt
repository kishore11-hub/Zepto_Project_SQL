Zepto E-commerce Data Analysis

In these project i have Explored the data, Cleaned the data, and answerd Business Insights by using Postgresql


Simple SQL data cleaning and business insights project on Zepto product dataset.

Table Schema
sql
CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    Category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
Data Cleaning Steps
Check null values across all columns

Identify duplicate product names

Remove products with MRP = 0

Convert prices from paise to rupees (mrp/100.0, discountedSellingPrice/100.0)

Data Quality Queries
text
- Total records: SELECT COUNT(*) FROM zepto;
- Null values check
- Categories: SELECT DISTINCT category FROM zepto ORDER BY category;
- Stock status: SELECT outofstock, COUNT(sku_id) FROM zepto GROUP BY outofstock;
- Duplicates: SELECT name, COUNT(sku_id) FROM zepto GROUP BY name HAVING COUNT(sku_id) > 1;
Business Questions Answered
1. Top 10 Products by Discount %
sql
SELECT name, mrp, discountpercent
FROM zepto ORDER BY discountpercent DESC LIMIT 10;
2. High MRP Out-of-Stock Products
sql
SELECT name, mrp FROM zepto 
WHERE outofstock = true AND mrp > 300 
ORDER BY mrp DESC;
3. Total Revenue by Category
sql
SELECT category, SUM(discountedSellingPrice * availableQuantity) as total_revenue
FROM zepto GROUP BY category ORDER BY total_revenue DESC;
4. Expensive Products Low Discount
sql
SELECT name, mrp, discountpercent 
FROM zepto WHERE mrp > 500 AND discountpercent < 10 
ORDER BY mrp DESC;
5. Top 5 Categories by Avg Discount
sql
SELECT category, ROUND(AVG(discountpercent), 2) as avg_discount
FROM zepto GROUP BY category ORDER BY avg_discount DESC LIMIT 5;
6. Price per Gram Analysis (>100g)
sql
SELECT name, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice/weightInGms, 2) as price_per_gm
FROM zepto WHERE weightInGms > 100 
ORDER BY price_per_gm ASC;
7. Weight Categories
sql
SELECT name, weightInGms,
       CASE 
           WHEN weightInGms < 1000 THEN 'Low'
           WHEN weightInGms < 5000 THEN 'Medium'
           ELSE 'Bulk'
       END as weight_category
FROM zepto;
8. Total Weight by Category
sql
SELECT category, SUM(weightInGms * availableQuantity) as total_weight
FROM zepto GROUP BY category ORDER BY total_weight DESC;
Key Findings
Stock availability distribution

Best discount categories

Revenue leaders by category

Value-for-money products (price/gm)

High-value out-of-stock items

Skills demonstrated: SQL data cleaning, aggregation, window functions, CASE statements, business reporting