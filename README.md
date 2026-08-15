

# E-Commerce System

##  Project Overview

The **E-Commerce  System** is a database management project designed to manage and track an e-commerce business's customers, products, orders, order items, categories, and payments.

The project uses **MySQL** and demonstrates important SQL concepts such as database design, table creation, primary keys, foreign keys, joins, aggregate functions, subqueries, views, and reporting queries.

---

##  Project Objectives

* Manage customer information.
* Manage product and category details.
* Store and track customer orders.
* Maintain order item information.
* Record payment details.
* Track product stock.
* Generate useful sales reports.
* Identify top-selling products and customers.
* Practice real-world SQL database operations.

---

## 🗂️ Database Structure

The system contains the following main tables:

| Table         | Description                            |
| ------------- | -------------------------------------- |
| `customers`   | Stores customer information            |
| `categories`  | Stores product categories              |
| `products`    | Stores product details and stock       |
| `orders`      | Stores customer orders                 |
| `order_items` | Stores products included in each order |
| `payments`    | Stores payment information             |

### 🔗 Relationships

```text
Customers
    │
    │ 1 : N
    ▼
Orders
    │
    │ 1 : N
    ▼
Order_Items
    │
    │ N : 1
    ▼
Products
    │
    │ N : 1
    ▼
Categories

Orders
    │
    │ 1 : 1 / 1 : N
    ▼
Payments
```

---

## 🛠️ Technologies Used

* **MySQL**
* **SQL**
* **MySQL Workbench** (optional)
* **Git & GitHub** (for project management)

---

## 📋 Main SQL Concepts Used

### DDL — Data Definition Language

```sql
CREATE DATABASE
CREATE TABLE
ALTER TABLE
DROP TABLE
TRUNCATE TABLE
```

### DML — Data Manipulation Language

```sql
INSERT
UPDATE
DELETE
```

### DQL — Data Query Language

```sql
SELECT
```

### SQL Functions

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

### SQL Clauses

```sql
WHERE
ORDER BY
GROUP BY
HAVING
LIMIT
```

### Joins

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
```

---

## 🏗️ Example Database Creation

```sql
CREATE DATABASE e_commerce_system;

USE e_commerce_system;
```

---

## 👥 Customers Table

Stores customer information such as name, email, phone number, and address.

Example:

```sql
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);
```

---

## 📦 Products Table

Stores product information including price and available stock.

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
```

---

## 🛍️ Orders Table

Stores customer order information.

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
```

---

## 💳 Payments Table

Stores payment information for orders.

```sql
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_date DATE,
    payment_method VARCHAR(50),
    amount DECIMAL(10,2),
    payment_status VARCHAR(30),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
```

---

## 📊 Sample Reports

The project can generate different business reports using SQL queries.

### 1. Top 5 Selling Products

```sql
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
LIMIT 5;
```

### 2. Products With Low Stock

```sql
SELECT *
FROM products
WHERE stock_quantity < 10;
```

### 3. Total Sales

```sql
SELECT SUM(amount) AS total_sales
FROM payments
WHERE payment_status = 'Paid';
```

### 4. Customer Order Report

```sql
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
```

---

## 📈 Key Features

* Customer management
* Product management
* Category management
* Order management
* Order item tracking
* Payment tracking
* Inventory/stock tracking
* Sales reporting
* Customer order analysis
* Top product analysis
* Low-stock product identification

---

## 📁 Suggested Project Structure

```text
E-Commerce-Order-Tracking-System/
│
├── README.md
├── database/
│   ├── create_database.sql
│   ├── create_tables.sql
│   └── insert_data.sql
│
├── queries/
│   ├── basic_queries.sql
│   ├── joins.sql
│   ├── aggregate_queries.sql
│   └── reports.sql
│
└── screenshots/
    └── database_screenshots/
```

---

## 🚀 How to Run the Project

### Step 1: Install MySQL

Install MySQL Server and MySQL Workbench.

### Step 2: Create the Database

Run:

```sql
CREATE DATABASE e_commerce_system;
USE e_commerce_system;
```

### Step 3: Create Tables

Execute the table creation SQL scripts.

### Step 4: Insert Data

Run the sample data/insert queries.

### Step 5: Run Queries

Execute the reporting and analysis queries to view the results.

---

## 🔍 Learning Outcomes

By completing this project, you can practice:

* Relational database design
* Primary and foreign keys
* Table relationships
* CRUD operations
* SQL joins
* Aggregate functions
* Grouping and filtering
* Subqueries
* Data analysis
* Business reporting
* Database normalization concepts

---

## 👨‍💻 Author

**Gulam Shabir**

**Project:** E-Commerce Order Tracking System
**Database:** MySQL
**Education:** Master of Computer Applications (MCA)

---

## 📄 License

This project is created for **educational and learning purposes**.
