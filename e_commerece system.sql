CREATE DATABASE e_commerce_system;

USE e_commerce_system;

-- Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories Table
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

-- Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT,

    FOREIGN KEY (category_id)
    REFERENCES categories(category_id)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    payment_date DATE,

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

-- Shipping Table
CREATE TABLE shipping (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    shipping_address VARCHAR(200),
    delivery_date DATE,
    shipping_status VARCHAR(50),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);


-- Insert Customers
INSERT INTO customers (customer_name, email, phone, city)
VALUES
('Aman Sharma', 'aman@gmail.com', '9876543210', 'Delhi'),
('Riya Khan', 'riya@gmail.com', '9876543211', 'Mumbai'),
('Rahul Verma', 'rahul@gmail.com', '9876543212', 'Lucknow');
update customers
set phone ='9718014240'
where customer_id =1;

SELECT * FROM CUSTOMERS;

-- Insert Categories
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Books');

SELECT * FROM CATEGORIES;

-- Insert Products
INSERT INTO products (product_name, price, stock, category_id)
VALUES
('Laptop', 55000, 10, 1),
('Mobile Phone', 25000, 20, 1),
('T-Shirt', 800, 50, 2),
('SQL Book', 500, 30, 3);

SELECT * FROM PRODUCTS;

-- Insert Orders
INSERT INTO orders (customer_id, order_date, total_amount, order_status)
VALUES
(1, '2026-05-01', 55800, 'Delivered'),
(2, '2026-05-02', 25000, 'Shipped'),
(3, '2026-05-03', 1300, 'Processing');

SELECT * FROM ORDERS;

-- Insert Order Items
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 1, 55000),
(1, 3, 1, 800),
(2, 2, 1, 25000),
(3, 4, 1, 500),
(3, 3, 1, 800);

SELECT * FROM ORDER_ITEMS;

-- Insert Payments
INSERT INTO payments (order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'UPI', 'Paid', '2026-05-01'),
(2, 'Credit Card', 'Paid', '2026-05-02'),
(3, 'Cash on Delivery', 'Pending', '2026-05-03');

SELECT * FROM PAYMENTS;

-- Insert Shipping
INSERT INTO shipping (order_id, shipping_address, delivery_date, shipping_status)
VALUES
(1, 'Delhi, India', '2026-05-05', 'Delivered'),
(2, 'Mumbai, India', '2026-05-06', 'In Transit'),
(3, 'Lucknow, India', NULL, 'Pending');

SELECT * FROM SHIPPING;

-- Show Products
SELECT * FROM products;

-- Orders with Customer Names
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;
-- list top 5 selling product
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- top sales in may 2026
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date,
    o.total_amount
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE MONTH(o.order_date) = 5
AND YEAR(o.order_date) = 2026
ORDER BY o.total_amount DESC;

-- check list of product with less than 10 quantity in stock-high stock
SELECT 
    product_id,
    product_name,
    stock
FROM products
WHERE stock >10;

-- show list of total orders for all users
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- monthly sales grwoth
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS monthly_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;
-- active customers(paid orders only)
SELECT DISTINCT
    c.customer_id,
    c.customer_name,
    c.email,
    c.city
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN payments p
ON o.order_id = p.order_id
WHERE p.payment_status = 'Paid';

-- top 3 customers by pending
	SELECT 
		c.customer_id,
		c.customer_name,
		COUNT(p.payment_id) AS pending_payments,
		SUM(o.total_amount) AS pending_amount
	FROM customers c
	JOIN orders o
	ON c.customer_id = o.customer_id
	JOIN payments p
	ON o.order_id = p.order_id
	WHERE p.payment_status = 'Pending'
	GROUP BY c.customer_id, c.customer_name
	ORDER BY pending_amount DESC
	LIMIT 3;
    
    select * from customers;
    
