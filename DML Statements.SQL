-- =============================================
-- INSERT statements (5 per table as before)
-- =============================================

-- Insert into Suppliers
INSERT INTO Suppliers (supplier_id, supplier_name, phone, email)
VALUES 
(1, 'Black Lotus', '555-0100', 'black.lotus@mtg.com'),
(2, 'Mox Pearl', '555-0101', 'mox.pearl@mtg.com'),
(3, 'Time Walk', '555-0102', 'time.walk@mtg.com'),
(4, 'Ancestral Recall', '555-0103', 'ancestral.recall@mtg.com'),
(5, 'Mox Sapphire', '555-0104', 'mox.sapphire@mtg.com');

-- Insert into Categories
INSERT INTO Categories (category_id, category_name)
VALUES
(1, 'Power Nine'),
(2, 'Dual Lands'),
(3, 'Planeswalkers'),
(4, 'Creatures'),
(5, 'Instants');

-- Insert into Products
INSERT INTO Products (product_id, product_name, category_id, supplier_id, unit_price, qoh)
VALUES
(1, 'Alpha Black Lotus', 1, 1, 25000.00, 2),
(2, 'Beta Mox Pearl', 1, 2, 12000.00, 3),
(3, 'Unlimited Time Walk', 1, 3, 8000.00, 5),
(4, 'Ancestral Recall', 1, 4, 7500.00, 4),
(5, 'Mox Sapphire', 1, 5, 11000.00, 3);

-- Insert into Orders
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_amount, order_date, order_time)
VALUES
(1, 101, 1, 1, 25000.00, '2023-01-15', '10:30:00'),
(2, 102, 2, 1, 12000.00, '2023-01-16', '11:45:00'),
(3, 103, 3, 1, 8000.00, '2023-01-17', '14:20:00'),
(4, 104, 4, 1, 7500.00, '2023-01-18', '09:15:00'),
(5, 105, 5, 1, 11000.00, '2023-01-19', '16:30:00');

-- =============================================
-- UPDATE and DELETE for each table
-- =============================================

-- SUPPLIERS --
-- Update: Change Black Lotus's phone number
UPDATE Suppliers
SET phone = '555-0199'
WHERE supplier_id = 1;

-- Delete: Remove test supplier (must have no products)
INSERT INTO Suppliers (supplier_id, supplier_name) VALUES (99, 'Test Supplier');
DELETE FROM Suppliers WHERE supplier_id = 99;

-- CATEGORIES --
-- Update: Rename 'Instants' category
UPDATE Categories
SET category_name = 'Instant Spells'
WHERE category_id = 5;

-- Delete: Remove test category (must have no products)
INSERT INTO Categories (category_id, category_name) VALUES (99, 'Test Category');
DELETE FROM Categories WHERE category_id = 99;

-- PRODUCTS --
-- Update: Increase stock of Alpha Black Lotus
UPDATE Products
SET qoh = qoh + 1
WHERE product_id = 1;

-- Delete: Remove test product (must have no orders)
INSERT INTO Products (product_id, product_name, category_id, supplier_id, unit_price, qoh)
VALUES (99, 'Test Product', 1, 1, 100.00, 10);
DELETE FROM Products WHERE product_id = 99;

-- ORDERS --
-- Update: Correct order amount for order #2
UPDATE Orders
SET order_amount = 12500.00
WHERE order_id = 2;

-- Delete: Remove test order
INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_amount, order_date)
VALUES (99, 999, 1, 1, 100.00, '2023-01-01');
DELETE FROM Orders WHERE order_id = 99;

-- =============================================
-- Verification queries
-- =============================================
SELECT * FROM Suppliers WHERE supplier_id = 1; -- Check phone update
SELECT * FROM Categories WHERE category_id = 5; -- Check category rename
SELECT * FROM Products WHERE product_id = 1; -- Check QOH increase
SELECT * FROM Orders WHERE order_id = 2; -- Check amount correction