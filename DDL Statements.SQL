-- Create Suppliers table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

-- Create Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    qoh INT DEFAULT 0 CHECK (qoh >= 0),
    CONSTRAINT fk_category FOREIGN KEY (category_id) 
        REFERENCES Categories(category_id),
    CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) 
        REFERENCES Suppliers(supplier_id)
);

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    order_amount DECIMAL(10,2) NOT NULL CHECK (order_amount > 0),
    order_date DATE NOT NULL,
    order_time TIME,
    CONSTRAINT fk_product FOREIGN KEY (product_id) 
        REFERENCES Products(product_id),
    CONSTRAINT chk_order_date CHECK (order_date <= CURRENT_DATE)
);

-- Create index for frequently queried columns
CREATE INDEX idx_product_category ON Products(category_id);
CREATE INDEX idx_product_supplier ON Products(supplier_id);
CREATE INDEX idx_order_product ON Orders(product_id);
CREATE INDEX idx_order_date ON Orders(order_date);