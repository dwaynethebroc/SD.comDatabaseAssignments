-- 1. Top 5 best-selling products view
CREATE VIEW vw_top_selling_products AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.order_amount) AS total_revenue
FROM Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;
-- Purpose: Provides quick access to best-performing products for management reporting

-- 2. Product sales stored procedure
DELIMITER //
CREATE PROCEDURE sp_get_product_sales(IN p_product_id INT)
BEGIN
    SELECT 
        p.product_name,
        SUM(o.quantity) AS total_quantity_sold,
        SUM(o.order_amount) AS total_revenue
    FROM Orders o
    JOIN Products p ON o.product_id = p.product_id
    WHERE p.product_id = p_product_id
    GROUP BY p.product_name;
END //
DELIMITER ;

-- Execute the stored procedure
CALL sp_get_product_sales(1);
-- Purpose: Encapsulates product sales logic for reuse in applications and reports

-- 3. Inventory audit trigger and QOH validation
-- First create audit table
CREATE TABLE inventory_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    old_qoh INT NOT NULL,
    new_qoh INT NOT NULL,
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    changed_by VARCHAR(50) DEFAULT USER()
);

-- Create trigger
DELIMITER //
CREATE TRIGGER tr_inventory_update
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    -- Prevent negative inventory
    IF NEW.qoh < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Inventory cannot be negative';
    END IF;
    
    -- Log changes to audit table
    IF NEW.qoh <> OLD.qoh THEN
        INSERT INTO inventory_audit (product_id, old_qoh, new_qoh)
        VALUES (NEW.product_id, OLD.qoh, NEW.qoh);
    END IF;
END //
DELIMITER ;
-- Purpose: Maintains inventory change history and prevents data integrity issues

-- 4. Inventory update transaction
START TRANSACTION;
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Transaction rolled back due to error' AS message;
    END;
    
    -- Update inventory
    UPDATE Products 
    SET qoh = qoh - 2 
    WHERE product_id = 1;
    
    -- Record sale
    INSERT INTO Orders (order_id, customer_id, product_id, quantity, order_amount, order_date)
    VALUES (1001, 501, 1, 2, 50000.00, CURDATE());
    
    COMMIT;
    SELECT 'Transaction completed successfully' AS message;
END;
-- Purpose: Ensures inventory and sales records stay synchronized

-- 5. Performance index creation
CREATE INDEX idx_products_category ON Products(category_id);
-- Purpose: Optimizes queries filtering or joining on category_id, which is frequently used in reports