-- 1. Product-supplier contact information
SELECT p.product_name, s.supplier_name, s.phone, s.email
FROM Products p
INNER JOIN Suppliers s ON p.supplier_id = s.supplier_id
ORDER BY s.supplier_name, p.product_name;
-- Purpose: Creates a vendor contact list with associated products for procurement communications

-- 2. Sales analysis by product category
SELECT p.product_name, c.category_name, o.quantity, o.order_date
FROM Orders o
INNER JOIN Products p ON o.product_id = p.product_id
INNER JOIN Categories c ON p.category_id = c.category_id
ORDER BY o.order_date DESC;
-- Purpose: Provides sales transaction details with product categorization for sales reporting

-- 3. All suppliers with their products (including those supplying nothing)
SELECT s.supplier_name, p.product_name
FROM Suppliers s
LEFT JOIN Products p ON s.supplier_id = p.supplier_id
ORDER BY s.supplier_name;
-- Purpose: Identifies active and inactive supplier relationships for vendor management

-- 4. Complete product-supplier relationship overview
SELECT s.supplier_name, p.product_name
FROM Suppliers s
LEFT JOIN Products p ON s.supplier_id = p.supplier_id
UNION
SELECT s.supplier_name, p.product_name
FROM Products p
LEFT JOIN Suppliers s ON p.supplier_id = s.supplier_id
WHERE s.supplier_id IS NULL;
-- Purpose: Comprehensive relationship analysis showing all possible connections between products and suppliers

-- 5. High-inventory categories
SELECT c.category_name, SUM(p.qoh) AS total_inventory
FROM Products p
INNER JOIN Categories c ON p.category_id = c.category_id
GROUP BY c.category_name
HAVING SUM(p.qoh) > 10
ORDER BY total_inventory DESC;
-- Purpose: Identifies categories with excess inventory that may need sales promotions