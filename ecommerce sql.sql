
CREATE DATABASE ecommercesqldata;
USE ecommercesqldata;

-- 1. Customers table
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255)
);

-- 2. Products table
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    description TEXT
);

-- 3. Orders table
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

-- 4. Order Items table (to handle multiple products per order)
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 5. Categories table
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

-- 6. Product Categories table (many-to-many relationship)
CREATE TABLE product_categories (
    product_id INT,
    category_id INT,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 7. Users table (admin or staff users)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    password VARCHAR(100),
    role ENUM('admin', 'staff') DEFAULT 'staff'
);

-- 8. Payments table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10, 2),
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- 9. Shipping table
CREATE TABLE shipping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    shipping_address VARCHAR(255),
    shipping_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- 10. Reviews table
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (name, email, address) VALUES
('Alice Smith', 'alice@example.com', '123 Main St, Springfield'),
('Bob Johnson', 'bob@example.com', '456 Oak Ave, Metropolis'),
('Carol Lee', 'carol@example.com', '789 Pine Rd, Gotham'),
('David Brown', 'david@example.com', '321 Elm St, Star City'),
('Eva White', 'eva@example.com', '654 Cedar Ln, Central City'),
('Frank Green', 'frank@example.com', '987 Maple Dr, Smallville'),
('Grace Black', 'grace@example.com', '159 Birch Blvd, Coast City'),
('Henry King', 'henry@example.com', '753 Spruce Ct, Blüdhaven'),
('Ivy Adams', 'ivy@example.com', '852 Cherry Way, Midway City'),
('Jack Wilson', 'jack@example.com', '951 Willow Pl, National City');

INSERT INTO products (name, price, description) VALUES
('Laptop', 999.99, 'High-performance laptop with 16GB RAM'),
('Smartphone', 699.99, 'Latest-gen smartphone with OLED display'),
('Wireless Mouse', 29.99, 'Ergonomic wireless mouse'),
('Mechanical Keyboard', 89.99, 'Backlit mechanical keyboard with blue switches'),
('Monitor 24"', 149.99, 'Full HD LED Monitor'),
('Bluetooth Speaker', 59.99, 'Portable Bluetooth speaker with deep bass'),
('Smartwatch', 199.99, 'Fitness tracking smartwatch'),
('Gaming Chair', 249.99, 'Comfortable ergonomic gaming chair'),
('Webcam', 49.99, '1080p HD webcam'),
('USB-C Hub', 39.99, 'Multiport USB-C hub with HDMI');

INSERT INTO categories (name) VALUES
('Electronics'),
('Computers'),
('Accessories'),
('Audio'),
('Wearables'),
('Furniture'),
('Gaming'),
('Peripherals'),
('Mobile'),
('Office');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2025-04-01', 1029.98),
(2, '2025-04-02', 149.99),
(3, '2025-04-02', 729.98),
(4, '2025-04-03', 249.99),
(5, '2025-04-04', 199.99),
(6, '2025-04-04', 89.99),
(7, '2025-04-05', 279.98),
(8, '2025-04-05', 49.99),
(9, '2025-04-06', 699.99),
(10, '2025-04-06', 999.99);

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 999.99),
(1, 3, 1, 29.99),
(2, 5, 1, 149.99),
(3, 2, 1, 699.99),
(3, 9, 1, 29.99),
(4, 8, 1, 249.99),
(5, 7, 1, 199.99),
(6, 4, 1, 89.99),
(7, 6, 2, 59.99),
(8, 9, 1, 49.99);

INSERT INTO product_categories (product_id, category_id) VALUES
(1, 2),
(1, 1),
(2, 1),
(2, 9),
(3, 3),
(4, 3),
(5, 1),
(6, 4),
(7, 5),
(8, 6);

INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2025-04-01', 1029.98, 'Credit Card'),
(2, '2025-04-02', 149.99, 'PayPal'),
(3, '2025-04-02', 729.98, 'Credit Card'),
(4, '2025-04-03', 249.99, 'UPI'),
(5, '2025-04-04', 199.99, 'Credit Card'),
(6, '2025-04-04', 89.99, 'Debit Card'),
(7, '2025-04-05', 279.98, 'Wallet'),
(8, '2025-04-05', 49.99, 'Cash on Delivery'),
(9, '2025-04-06', 699.99, 'Credit Card'),
(10, '2025-04-06', 999.99, 'PayPal');

INSERT INTO shipping (order_id, shipping_address, shipping_date, status) VALUES
(1, '123 Main St', '2025-04-02', 'Shipped'),
(2, '456 Oak Ave', '2025-04-03', 'Delivered'),
(3, '789 Pine Rd', '2025-04-03', 'Processing'),
(4, '321 Elm St', '2025-04-04', 'Shipped'),
(5, '654 Cedar Ln', '2025-04-05', 'Delivered'),
(6, '987 Maple Dr', '2025-04-05', 'Pending'),
(7, '159 Birch Blvd', '2025-04-06', 'Shipped'),
(8, '753 Spruce Ct', '2025-04-06', 'Delivered'),
(9, '852 Cherry Way', '2025-04-07', 'Processing'),
(10, '951 Willow Pl', '2025-04-07', 'Shipped');

INSERT INTO reviews (product_id, customer_id, rating, comment, review_date) VALUES
(1, 1, 5, 'Amazing laptop. Super fast.', '2025-04-05'),
(2, 3, 4, 'Good value for money.', '2025-04-05'),
(3, 1, 5, 'Very handy and works well.', '2025-04-06'),
(4, 6, 4, 'Great keyboard but noisy.', '2025-04-06'),
(5, 2, 3, 'Decent monitor, average colors.', '2025-04-06'),
(6, 7, 5, 'Awesome sound!', '2025-04-07'),
(7, 5, 4, 'Helpful for workouts.', '2025-04-07'),
(8, 4, 5, 'Very comfortable.', '2025-04-07'),
(9, 3, 3, 'Okay webcam for meetings.', '2025-04-08'),
(10, 8, 4, 'Useful for Macbook users.', '2025-04-08');

/*Retrieve Data*/

SELECT DISTINCT c.id, c.name, c.email, c.address
FROM customers c
JOIN orders o ON c.id = o.customer_id
WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;

/*Total number of order*/

SELECT 
    c.id AS customer_id,
    c.name AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;


/* Update values */

SET SQL_SAFE_UPDATES = 0;

UPDATE products
SET price = 45.00
WHERE name = 'Product C';

SET SQL_SAFE_UPDATES = 1;


/*SQL Alter Table Query*/

ALTER TABLE products
ADD COLUMN discount DECIMAL(5, 2) DEFAULT 0.00;


/*Retrieve the top 3 products with the highest price.*/

SELECT id, name, price
FROM products
ORDER BY price DESC
LIMIT 3;

/*Get the names of customers who have ordered "Laptop" */
/*Search with product name "Laptop" */

SELECT DISTINCT c.name AS customer_name
FROM customers c
JOIN orders o ON c.id = o.customer_id
JOIN order_items oi ON o.id = oi.order_id
JOIN products p ON oi.product_id = p.id
WHERE p.name = 'Laptop';

/* Join the orders and customers tables to retrieve the customer's name and order date for each order.  */
SELECT 
    c.name AS customer_name,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.id
ORDER BY o.order_date DESC;

/* Retrieve the orders with a total amount greater than 150.00. */

SELECT *
FROM orders
WHERE total_amount > 150.00;

/* Normalize the database by creating a separate table for order items and updating the orders table to reference the order_items table. */

ALTER TABLE orders
DROP COLUMN total_amount;

SELECT 
    o.id AS order_id,
    c.name AS customer_name,
    o.order_date,
    SUM(oi.quantity * oi.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, c.name, o.order_date;


/*Retrieve the average total of all orders.*/

SELECT AVG(total_amount) AS average_order_total
FROM orders;


