-- 1. Total sales by product category
SELECT 
    c.category_name,
    SUM(o.order_amount) AS total_sales,
    COUNT(o.order_id) AS transaction_count
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_sales DESC;
-- Purpose: Provides sales performance metrics by product category for business analysis

-- 2. Formatted product and supplier information
SELECT 
    CONCAT(UPPER(LEFT(p.product_name, 1)), LOWER(SUBSTRING(p.product_name, 2))) AS formatted_product_name,
    CONCAT(s.supplier_name, ' (', SUBSTRING(s.phone, 1, 3), ') ', SUBSTRING(s.email, 1, POSITION('@' IN s.email) - 1)) AS supplier_contact
FROM Products p
JOIN Suppliers s ON p.supplier_id = s.supplier_id;
-- Purpose: Creates standardized display formats for product names and supplier contact info

-- 3. Monthly order analysis
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(order_id) AS order_count,
    SUM(order_amount) AS monthly_sales
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month DESC;
-- Purpose: Shows sales trends by month for inventory and marketing planning

-- 4. Discounted price calculation
SELECT 
    product_name,
    unit_price AS original_price,
    ROUND(unit_price * 0.8, 2) AS discounted_price
FROM Products
ORDER BY unit_price DESC
LIMIT 1;
-- Purpose: Calculates promotional pricing for the most expensive product