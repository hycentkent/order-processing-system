-- Create the database
CREATE DATABASE db_batch5_ops;

-- Use the created database
USE db_batch5_ops;

-- Create users table
CREATE TABLE tbl_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id int,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO tbl_users (firstname, email, password, role_id) 
VALUES
    ('admin' , 'hycentkent@gmail.com' , ' 12345' , 1);



-- create table products 
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255) NOT NULL, 
    address VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(255) NOT NULL, 
    description TEXT, 
    price DECIMAL(10, 2) NOT NULL, 
    stock_quantity INT DEFAULT 0, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending', -- Pending, Processed, Shipped, Delivered
    shipping_address VARCHAR(255),
    payment_status VARCHAR(50) DEFAULT 'Unpaid', -- Unpaid, Paid
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) AS (quantity * unit_price) STORED, -- Calculate subtotal automatically
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    quantity_in_stock INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50), -- Credit Card, PayPal, etc.
    payment_status VARCHAR(50) DEFAULT 'Completed', -- Completed, Pending, Failed
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);