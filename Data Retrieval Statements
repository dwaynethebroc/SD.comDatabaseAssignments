-- 1. List all products with key details
SELECT product_name, category_id, unit_price, qoh
FROM Products;
-- Purpose: Provides a complete inventory overview showing product names, their categories, prices, and current stock levels

-- 2. Retrieve out-of-stock products
SELECT product_id, product_name, unit_price
FROM Products
WHERE qoh = 0;
-- Purpose: Identifies products needing restock by finding items with zero quantity on hand

-- 3. Display mid-range priced products ($100-$500)
SELECT product_id, product_name, unit_price
FROM Products
WHERE unit_price BETWEEN 100 AND 500
ORDER BY unit_price DESC;
-- Purpose: Finds products in the common price range for promotional opportunities

-- 4. Count products by category
SELECT category_id, COUNT(*) AS product_count
FROM Products
GROUP BY category_id
ORDER BY product_count DESC;
-- Purpose: Shows product distribution across categories to identify strongest/weakest categories

-- 5. Average product price by category
SELECT category_id, AVG(unit_price) AS avg_price
FROM Products
GROUP BY category_id
ORDER BY avg_price DESC;
-- Purpose: Reveals pricing trends across categories, highlighting premium vs value categories