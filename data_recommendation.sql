-- Create Databases
CREATE DATABASE ECommerce;

--use ECommerce;

-- Create the Products table
CREATE TABLE Products (
    product_id VARCHAR(20),
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    brand VARCHAR(50)
);

-- Insert data into the Products table
INSERT INTO Products (product_id, product_name, category, price, brand) VALUES
('P001', 'Laptop', 'Electronics', 1200.00, 'Dell'),
('P002', 'Smartphone', 'Electronics', 800.00, 'Samsung'),
('P003', 'Headphones', 'Electronics', 100.00, 'Sony'),
('P004', 'T-shirt', 'Clothing', 20.00, 'Nike'),
('P005', 'Jeans', 'Clothing', 50.00, 'Levi''s'),
('P006', 'Watch', 'Accessories', 150.00, 'Casio'),
('P007', 'Sneakers', 'Shoes', 80.00, 'Adidas'),
('P008', 'Backpack', 'Bags', 40.00, 'JanSport'),
('P009', 'Gaming Console', 'Electronics', 300.00, 'Microsoft'),
('P010', 'Tablet', 'Electronics', 250.00, 'Apple'),
('P011', 'Running Shoes', 'Shoes', 90.00, 'Nike'),
('P012', 'Sweater', 'Clothing', 45.00, 'H&M'),
('P013', 'Printer', 'Electronics', 150.00, 'HP'),
('P014', 'Dress Shirt', 'Clothing', 30.00, 'Calvin Klein'),
('P015', 'Camera', 'Electronics', 500.00, 'Canon'),
('P016', 'Sandals', 'Shoes', 25.00, 'Crocs'),
('P017', 'Handbag', 'Bags', 60.00, 'Michael Kors'),
('P018', 'Bluetooth Speaker', 'Electronics', 70.00, 'JBL'),
('P019', 'Hoodie', 'Clothing', 35.00, 'Under Armour'),
('P020', 'Desk Lamp', 'Home & Kitchen', 25.00, 'Ikea'),
('P021', 'Smart TV', 'Electronics', 700.00, 'LG'),
('P022', 'Wireless Earbuds', 'Electronics', 120.00, 'Bose'),
('P023', 'Backpack', 'Accessories', 35.00, 'SwissGear'),
('P024', 'Running Shorts', 'Clothing', 25.00, 'Adidas'),
('P025', 'Blender', 'Home & Kitchen', 50.00, 'Ninja'),
('P026', 'Dress Shoes', 'Shoes', 100.00, 'Cole Haan'),
('P027', 'Laptop Sleeve', 'Accessories', 20.00, 'AmazonBasics'),
('P028', 'Portable Charger', 'Electronics', 40.00, 'Anker'),
('P029', 'Yoga Mat', 'Sports & Fitness', 30.00, 'Gaiam'),
('P030', 'Coffee Maker', 'Home & Kitchen', 80.00, 'Keurig'),
('P031', 'Office Chair', 'Furniture', 150.00, 'Herman Miller'),
('P032', 'Sunglasses', 'Accessories', 60.00, 'Ray-Ban'),
('P033', 'Soccer Ball', 'Sports & Fitness', 15.00, 'Adidas'),
('P034', 'Hard Drive', 'Electronics', 90.00, 'Western Digital'),
('P035', 'Bath Towel', 'Home & Kitchen', 10.00, 'Fieldcrest'),
('P036', 'Backpack', 'Bags', 45.00, 'The North Face'),
('P037', 'Smart Speaker', 'Electronics', 120.00, 'Google'),
('P038', 'Dress', 'Clothing', 55.00, 'Zara'),
('P039', 'Dumbbell Set', 'Sports & Fitness', 75.00, 'CAP Barbell'),
('P040', 'Bookshelf', 'Furniture', 200.00, 'IKEA');


-- Create the Interactions table
CREATE TABLE Interactions (
    interaction_id INT PRIMARY KEY,
    user_id VARCHAR(20),  -- Change the data type to VARCHAR
    product_id VARCHAR(20),
    interaction_type VARCHAR(20)
);

-- Insert data into the Interactions table
INSERT INTO Interactions (interaction_id, user_id, product_id, interaction_type) VALUES
(1, 'USER001', 'P001', 'View'),
(2, 'USER002', 'P002', 'Add to Cart'),
(3, 'USER003', 'P003', 'Purchase'),
(4, 'USER004', 'P004', 'View'),
(5, 'USER005', 'P005', 'Add to Wishlist'),
(6, 'USER001', 'P006', 'View'),
(7, 'USER002', 'P007', 'Purchase'),
(8, 'USER003', 'P008', 'View'),
(9, 'USER004', 'P009', 'Add to Cart'),
(10, 'USER005', 'P010', 'View'),
(11, 'USER001', 'P011', 'Add to Cart'),
(12, 'USER002', 'P012', 'Purchase'),
(13, 'USER003', 'P013', 'View'),
(14, 'USER004', 'P014', 'Add to Wishlist'),
(15, 'USER005', 'P015', 'View'),
(16, 'USER001', 'P016', 'Add to Cart'),
(17, 'USER002', 'P017', 'Purchase'),
(18, 'USER003', 'P018', 'View'),
(19, 'USER004', 'P019', 'View'),
(20, 'USER005', 'P020', 'Purchase');

-- Create the Past Purchases table
CREATE TABLE Past_Purchases (
    purchase_id INT PRIMARY KEY,
    user_id VARCHAR(20), -- Change the data type to VARCHAR
    product_id VARCHAR(20),
    purchase_date TIMESTAMP,
    quantity INT,
    total_amount DECIMAL(10,2)
);

-- Insert data into the Past Purchases table
INSERT INTO Past_Purchases (purchase_id, user_id, product_id, purchase_date, quantity, total_amount) VALUES
(1, 'USER001', 'P001', '2023-10-15', 1, 1200),
(2, 'USER002', 'P002', '2023-10-16', 1, 800),
(3, 'USER003', 'P003', '2023-10-17', 2, 200),
(4, 'USER004', 'P004', '2023-10-18', 1, 20),
(5, 'USER005', 'P005', '2023-10-19', 3, 150),
(6, 'USER006', 'P006', '2023-10-20', 1, 150),
(7, 'USER007', 'P007', '2023-10-21', 2, 160),
(8, 'USER008', 'P008', '2023-10-22', 1, 40),
(9, 'USER009', 'P009', '2023-10-23', 1, 30),
(10, 'USER010', 'P010', '2023-10-24', 1, 250),
(11, 'USER011', 'P011', '2023-10-25', 1, 1200),
(12, 'USER012', 'P012', '2023-10-26', 1, 800),
(13, 'USER013', 'P013', '2023-10-27', 1, 100),
(14, 'USER014', 'P014', '2023-10-28', 2, 40),
(15, 'USER015', 'P015', '2023-10-29', 1, 50),
(16, 'USER016', 'P016', '2023-10-30', 1, 150),
(17, 'USER017', 'P017', '2023-10-31', 1, 80),
(18, 'USER018', 'P018', '2023-11-01', 1, 40),
(19, 'USER019', 'P019', '2023-11-02', 1, 300),
(20, 'USER020', 'P020', '2023-11-03', 1, 250),
(21, 'USER021', 'P021', '2023-11-04', 1, 90),
(22, 'USER022', 'P022', '2023-11-05', 1, 45),
(23, 'USER023', 'P023', '2023-11-06', 1, 150),
(24, 'USER024', 'P024', '2023-11-07', 1, 30),
(25, 'USER025', 'P025', '2023-11-08', 1, 500);