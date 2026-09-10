--Creation of 'customers' table:
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_code VARCHAR(20) UNIQUE NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    signup_date DATE
);


--Creation of 'warehouses' table:
CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    warehouse_code VARCHAR(20) UNIQUE NOT NULL,
    warehouse_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    capacity_units INTEGER CHECK (capacity_units > 0)
);

--Creation of table 'suppliers':
CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_code VARCHAR(20) UNIQUE NOT NULL,
    supplier_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    state VARCHAR(50),
    average_lead_days INTEGER CHECK (average_lead_days >= 0),
    reliability_score NUMERIC(5,3)
        CHECK (reliability_score BETWEEN 0 AND 1)
);

--Creation of table 'products':
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_code VARCHAR(20) UNIQUE NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(80),
    subcategory VARCHAR(80),
    supplier_id INTEGER REFERENCES suppliers(supplier_id),
    selling_price NUMERIC(12,2) CHECK (selling_price >= 0),
    unit_cost NUMERIC(12,2) CHECK (unit_cost >= 0),
    lead_time_days INTEGER CHECK (lead_time_days >= 0)
);

--Creation of table 'orders':
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_code VARCHAR(20) UNIQUE NOT NULL,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date DATE NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    payment_method VARCHAR(30),
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    subtotal NUMERIC(14,2),
    shipping_cost NUMERIC(12,2),
    total_amount NUMERIC(14,2)
);

-- Creation of table 'order items':
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(order_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(12,2) NOT NULL,
    discount_pct NUMERIC(5,2)
        CHECK (discount_pct BETWEEN 0 AND 1)
);

-- Creation of table 'shipments':
CREATE TABLE shipments (
    order_id INTEGER PRIMARY KEY REFERENCES orders(order_id),
    shipment_code VARCHAR(20) UNIQUE NOT NULL,
    carrier VARCHAR(50),
    shipped_date DATE,
    promised_date DATE,
    delivered_date DATE,
    shipment_status VARCHAR(20)
);

-- Creation of table 'inventory':
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    warehouse_id INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    product_id INTEGER NOT NULL REFERENCES products(product_id),
    stock_qty INTEGER NOT NULL CHECK (stock_qty >= 0),
    reorder_level INTEGER NOT NULL CHECK (reorder_level >= 0),
    unit_value NUMERIC(12,2) NOT NULL,
    snapshot_date DATE NOT NULL,
    UNIQUE (warehouse_id, product_id, snapshot_date)
);


--Inserting data into tables: 
INSERT INTO warehouses
(warehouse_code, warehouse_name, city, state, capacity_units)
VALUES
('WH-MUM-01', 'Mumbai Central Warehouse', 'Mumbai', 'Maharashtra', 25000),
('WH-PUN-01', 'Pune Distribution Center', 'Pune', 'Maharashtra', 18000),
('WH-DEL-01', 'Delhi North Warehouse', 'Delhi', 'Delhi', 22000),
('WH-BLR-01', 'Bangalore Distribution Hub', 'Bangalore', 'Karnataka', 20000),
('WH-HYD-01', 'Hyderabad Warehouse', 'Hyderabad', 'Telangana', 16000);


INSERT INTO customers
(customer_code, customer_name, city, state, signup_date)
VALUES
('CUST-001', 'Aarav Sharma', 'Mumbai', 'Maharashtra', '2023-01-15'),
('CUST-002', 'Riya Patel', 'Pune', 'Maharashtra', '2023-02-20'),
('CUST-003', 'Aditya Mehta', 'Delhi', 'Delhi', '2023-03-11'),
('CUST-004', 'Sneha Iyer', 'Bangalore', 'Karnataka', '2023-03-25'),
('CUST-005', 'Rahul Verma', 'Hyderabad', 'Telangana', '2023-04-02'),
('CUST-006', 'Priya Shah', 'Mumbai', 'Maharashtra', '2023-04-18'),
('CUST-007', 'Karan Joshi', 'Pune', 'Maharashtra', '2023-05-09'),
('CUST-008', 'Ananya Rao', 'Delhi', 'Delhi', '2023-05-27'),
('CUST-009', 'Vivek Nair', 'Bangalore', 'Karnataka', '2023-06-14'),
('CUST-010', 'Ishita Kapoor', 'Mumbai', 'Maharashtra', '2023-07-03'),
('CUST-011', 'Rohan Desai', 'Pune', 'Maharashtra', '2023-07-19'),
('CUST-012', 'Neha Kulkarni', 'Hyderabad', 'Telangana', '2023-08-08'),
('CUST-013', 'Arjun Singh', 'Delhi', 'Delhi', '2023-08-21'),
('CUST-014', 'Meera Nair', 'Bangalore', 'Karnataka', '2023-09-05'),
('CUST-015', 'Yash Malhotra', 'Mumbai', 'Maharashtra', '2023-09-22'),
('CUST-016', 'Pooja Agarwal', 'Pune', 'Maharashtra', '2023-10-10'),
('CUST-017', 'Dev Patel', 'Hyderabad', 'Telangana', '2023-10-28'),
('CUST-018', 'Simran Kaur', 'Delhi', 'Delhi', '2023-11-12'),
('CUST-019', 'Kabir Khan', 'Mumbai', 'Maharashtra', '2023-11-25'),
('CUST-020', 'Tanya Gupta', 'Bangalore', 'Karnataka', '2023-12-08');



INSERT INTO suppliers
(supplier_code, supplier_name, city, state, average_lead_days, reliability_score)
VALUES
('SUP-001', 'Alpha Industrial Supplies', 'Mumbai', 'Maharashtra', 5, 0.95),
('SUP-002', 'Prime Mechanical Works', 'Pune', 'Maharashtra', 8, 0.91),
('SUP-003', 'TechParts India', 'Bangalore', 'Karnataka', 6, 0.94),
('SUP-004', 'Reliable Electricals', 'Delhi', 'Delhi', 10, 0.87),
('SUP-005', 'Metro Tools & Hardware', 'Hyderabad', 'Telangana', 12, 0.82),
('SUP-006', 'National Components', 'Ahmedabad', 'Gujarat', 7, 0.90),
('SUP-007', 'Industrial Solutions Ltd', 'Chennai', 'Tamil Nadu', 15, 0.78),
('SUP-008', 'FastTrack Engineering', 'Mumbai', 'Maharashtra', 4, 0.97),
('SUP-009', 'Quality Parts India', 'Pune', 'Maharashtra', 9, 0.88),
('SUP-010', 'Eastern Industrial Supply', 'Kolkata', 'West Bengal', 13, 0.80);



INSERT INTO products
(product_code, product_name, category, subcategory,
 supplier_id, selling_price, unit_cost, lead_time_days)
VALUES
('PROD-001', 'Industrial Bearing 6205', 'Mechanical', 'Bearings', 2, 850.00, 520.00, 7),
('PROD-002', 'Industrial Bearing 6206', 'Mechanical', 'Bearings', 2, 1100.00, 690.00, 8),
('PROD-003', 'Heavy Duty Gear', 'Mechanical', 'Gears', 6, 3500.00, 2200.00, 9),
('PROD-004', 'Drive Shaft', 'Mechanical', 'Shafts', 7, 6200.00, 3900.00, 15),
('PROD-005', 'Flexible Coupling', 'Mechanical', 'Couplings', 2, 2800.00, 1700.00, 8),

('PROD-006', 'Temperature Sensor', 'Electronics', 'Sensors', 3, 1450.00, 850.00, 6),
('PROD-007', 'Pressure Sensor', 'Electronics', 'Sensors', 3, 1800.00, 1050.00, 6),
('PROD-008', 'PLC Controller', 'Electronics', 'Controllers', 3, 12500.00, 7800.00, 10),
('PROD-009', 'Industrial Cable', 'Electronics', 'Cables', 1, 950.00, 550.00, 5),
('PROD-010', 'Power Supply Unit', 'Electronics', 'Power Supplies', 4, 4200.00, 2700.00, 10),

('PROD-011', 'Electric Motor 5HP', 'Electrical', 'Motors', 4, 18500.00, 12000.00, 12),
('PROD-012', 'Electric Motor 10HP', 'Electrical', 'Motors', 4, 32000.00, 21000.00, 14),
('PROD-013', 'Industrial Relay', 'Electrical', 'Relays', 6, 1250.00, 720.00, 7),
('PROD-014', 'Control Switch', 'Electrical', 'Switches', 1, 650.00, 360.00, 5),
('PROD-015', 'Electrical Panel', 'Electrical', 'Panels', 7, 14500.00, 9200.00, 15),

('PROD-016', 'Safety Helmet', 'Safety', 'Helmets', 5, 750.00, 420.00, 10),
('PROD-017', 'Industrial Safety Gloves', 'Safety', 'Gloves', 5, 350.00, 180.00, 8),
('PROD-018', 'Safety Shoes', 'Safety', 'Shoes', 5, 1800.00, 1050.00, 12),

('PROD-019', 'Cordless Power Drill', 'Tools', 'Power Tools', 8, 6500.00, 4100.00, 4),
('PROD-020', 'Digital Caliper', 'Tools', 'Measuring Tools', 9, 2200.00, 1300.00, 9),
('PROD-021', 'Torque Wrench', 'Tools', 'Hand Tools', 9, 3800.00, 2300.00, 9),

('PROD-022', 'Hydraulic Oil 20L', 'Lubricants', 'Hydraulic Oil', 7, 3200.00, 2100.00, 15),
('PROD-023', 'Industrial Grease 5KG', 'Lubricants', 'Grease', 10, 1850.00, 1100.00, 13),
('PROD-024', 'Machine Coolant 20L', 'Lubricants', 'Coolants', 10, 2400.00, 1450.00, 13),

('PROD-025', 'Industrial Fastener Kit', 'Fasteners', 'Fasteners', 6, 950.00, 580.00, 7);




INSERT INTO orders
(order_code, customer_id, order_date, order_status,
 payment_method, warehouse_id, subtotal, shipping_cost, total_amount)
VALUES
('ORD-001',1,'2024-01-05','Completed','UPI',1,8500,150,8650),
('ORD-002',2,'2024-01-08','Completed','Credit Card',2,12400,200,12600),
('ORD-003',3,'2024-01-12','Completed','Debit Card',3,18500,250,18750),
('ORD-004',4,'2024-01-15','Cancelled','UPI',4,6200,150,6350),
('ORD-005',5,'2024-01-19','Completed','Net Banking',5,32000,400,32400),
('ORD-006',6,'2024-01-23','Returned','Credit Card',1,5600,150,5750),
('ORD-007',7,'2024-01-27','Completed','UPI',2,14500,200,14700),
('ORD-008',8,'2024-02-02','Completed','Debit Card',3,8200,150,8350),
('ORD-009',9,'2024-02-06','Completed','UPI',4,18500,300,18800),
('ORD-010',10,'2024-02-10','Completed','Credit Card',5,9400,150,9550),

('ORD-011',11,'2024-02-14','Cancelled','UPI',1,3500,100,3600),
('ORD-012',12,'2024-02-18','Completed','Net Banking',2,12600,200,12800),
('ORD-013',13,'2024-02-21','Completed','Debit Card',3,7200,150,7350),
('ORD-014',14,'2024-02-25','Returned','Credit Card',4,14500,250,14750),
('ORD-015',15,'2024-03-01','Completed','UPI',5,21000,300,21300),
('ORD-016',16,'2024-03-05','Completed','UPI',1,4800,150,4950),
('ORD-017',17,'2024-03-09','Completed','Credit Card',2,9200,150,9350),
('ORD-018',18,'2024-03-13','Completed','Debit Card',3,18500,250,18750),
('ORD-019',19,'2024-03-18','Cancelled','UPI',4,6500,150,6650),
('ORD-020',20,'2024-03-22','Completed','Net Banking',5,32000,400,32400),

('ORD-021',1,'2024-03-27','Completed','UPI',1,10500,200,10700),
('ORD-022',2,'2024-04-02','Completed','Credit Card',2,7600,150,7750),
('ORD-023',3,'2024-04-07','Returned','Debit Card',3,18500,300,18800),
('ORD-024',4,'2024-04-11','Completed','UPI',4,14200,250,14450),
('ORD-025',5,'2024-04-16','Completed','Net Banking',5,9500,150,9650),
('ORD-026',6,'2024-04-20','Completed','Credit Card',1,21500,300,21800),
('ORD-027',7,'2024-04-25','Cancelled','UPI',2,3800,100,3900),
('ORD-028',8,'2024-04-29','Completed','Debit Card',3,12600,200,12800),
('ORD-029',9,'2024-05-04','Completed','UPI',4,18500,300,18800),
('ORD-030',10,'2024-05-09','Completed','Credit Card',5,7200,150,7350),

('ORD-031',11,'2024-05-13','Completed','UPI',1,14500,200,14700),
('ORD-032',12,'2024-05-17','Returned','Net Banking',2,6200,150,6350),
('ORD-033',13,'2024-05-22','Completed','Debit Card',3,32000,400,32400),
('ORD-034',14,'2024-05-27','Completed','UPI',4,8800,150,8950),
('ORD-035',15,'2024-06-01','Completed','Credit Card',5,12600,200,12800),
('ORD-036',16,'2024-06-06','Cancelled','UPI',1,5400,100,5500),
('ORD-037',17,'2024-06-10','Completed','Debit Card',2,18500,300,18800),
('ORD-038',18,'2024-06-15','Completed','UPI',3,7600,150,7750),
('ORD-039',19,'2024-06-19','Completed','Credit Card',4,14200,250,14450),
('ORD-040',20,'2024-06-24','Completed','Net Banking',5,21500,300,21800),

('ORD-041',1,'2024-06-29','Completed','UPI',1,9500,150,9650),
('ORD-042',2,'2024-07-03','Completed','Credit Card',2,18500,300,18800),
('ORD-043',3,'2024-07-08','Returned','Debit Card',3,8200,150,8350),
('ORD-044',4,'2024-07-12','Completed','UPI',4,32000,400,32400),
('ORD-045',5,'2024-07-17','Completed','Net Banking',5,12600,200,12800),
('ORD-046',6,'2024-07-22','Completed','Credit Card',1,7200,150,7350),
('ORD-047',7,'2024-07-27','Cancelled','UPI',2,6200,150,6350),
('ORD-048',8,'2024-08-01','Completed','Debit Card',3,14500,250,14750),
('ORD-049',9,'2024-08-06','Completed','UPI',4,21500,300,21800),
('ORD-050',10,'2024-08-11','Completed','Credit Card',5,9400,150,9550),

('ORD-051',11,'2024-08-16','Completed','UPI',1,18500,300,18800),
('ORD-052',12,'2024-08-21','Returned','Net Banking',2,7600,150,7750),
('ORD-053',13,'2024-08-26','Completed','Debit Card',3,32000,400,32400),
('ORD-054',14,'2024-09-01','Completed','UPI',4,10500,200,10700),
('ORD-055',15,'2024-09-06','Completed','Credit Card',5,14200,250,14450),
('ORD-056',16,'2024-09-11','Cancelled','UPI',1,3500,100,3600),
('ORD-057',17,'2024-09-16','Completed','Debit Card',2,21500,300,21800),
('ORD-058',18,'2024-09-21','Completed','UPI',3,8200,150,8350),
('ORD-059',19,'2024-09-26','Completed','Credit Card',4,12600,200,12800),
('ORD-060',20,'2024-10-01','Completed','Net Banking',5,18500,300,18800),

('ORD-061',1,'2024-10-06','Completed','UPI',1,7200,150,7350),
('ORD-062',2,'2024-10-11','Completed','Credit Card',2,14500,250,14750),
('ORD-063',3,'2024-10-16','Returned','Debit Card',3,9400,150,9550),
('ORD-064',4,'2024-10-21','Completed','UPI',4,32000,400,32400),
('ORD-065',5,'2024-10-26','Completed','Net Banking',5,12600,200,12800),
('ORD-066',6,'2024-11-01','Completed','Credit Card',1,18500,300,18800),
('ORD-067',7,'2024-11-06','Cancelled','UPI',2,5400,100,5500),
('ORD-068',8,'2024-11-11','Completed','Debit Card',3,21500,300,21800),
('ORD-069',9,'2024-11-16','Completed','UPI',4,7600,150,7750),
('ORD-070',10,'2024-11-21','Completed','Credit Card',5,14200,250,14450),

('ORD-071',11,'2024-11-26','Completed','UPI',1,32000,400,32400),
('ORD-072',12,'2024-12-01','Returned','Net Banking',2,8200,150,8350),
('ORD-073',13,'2024-12-06','Completed','Debit Card',3,18500,300,18800),
('ORD-074',14,'2024-12-11','Completed','UPI',4,12600,200,12800),
('ORD-075',15,'2024-12-16','Completed','Credit Card',5,7200,150,7350),
('ORD-076',16,'2024-12-21','Cancelled','UPI',1,3800,100,3900),
('ORD-077',17,'2024-12-26','Completed','Debit Card',2,14500,250,14750),
('ORD-078',18,'2024-12-29','Completed','UPI',3,21500,300,21800),
('ORD-079',19,'2025-01-03','Completed','Credit Card',4,9500,150,9650),
('ORD-080',20,'2025-01-07','Completed','Net Banking',5,32000,400,32400),

('ORD-081',1,'2025-01-12','Completed','UPI',1,12600,200,12800),
('ORD-082',2,'2025-01-17','Completed','Credit Card',2,18500,300,18800),
('ORD-083',3,'2025-01-22','Returned','Debit Card',3,7600,150,7750),
('ORD-084',4,'2025-01-27','Completed','UPI',4,14200,250,14450),
('ORD-085',5,'2025-02-01','Completed','Net Banking',5,21500,300,21800),
('ORD-086',6,'2025-02-06','Cancelled','Credit Card',1,6200,150,6350),
('ORD-087',7,'2025-02-11','Completed','UPI',2,32000,400,32400),
('ORD-088',8,'2025-02-16','Completed','Debit Card',3,9400,150,9550),
('ORD-089',9,'2025-02-21','Completed','UPI',4,18500,300,18800),
('ORD-090',10,'2025-02-26','Completed','Credit Card',5,12600,200,12800),

('ORD-091',11,'2025-03-03','Completed','UPI',1,7200,150,7350),
('ORD-092',12,'2025-03-08','Completed','Net Banking',2,14500,250,14750),
('ORD-093',13,'2025-03-13','Returned','Debit Card',3,8200,150,8350),
('ORD-094',14,'2025-03-18','Completed','UPI',4,21500,300,21800),
('ORD-095',15,'2025-03-23','Completed','Credit Card',5,32000,400,32400),
('ORD-096',16,'2025-03-28','Cancelled','UPI',1,3500,100,3600),
('ORD-097',17,'2025-04-02','Completed','Debit Card',2,12600,200,12800),
('ORD-098',18,'2025-04-07','Completed','UPI',3,18500,300,18800),
('ORD-099',19,'2025-04-12','Completed','Credit Card',4,9400,150,9550),
('ORD-100',20,'2025-04-17','Completed','Net Banking',5,14200,250,14450);



INSERT INTO order_items
(order_id, product_id, warehouse_id, quantity, unit_price, discount_pct)
VALUES
(1,1,1,5,850,0.05),
(1,6,1,2,1450,0.00),
(2,2,2,4,1100,0.00),
(2,9,2,5,950,0.10),
(3,3,3,3,3500,0.05),
(3,13,3,4,1250,0.00),
(4,4,4,1,6200,0.00),
(4,25,4,3,950,0.05),
(5,12,5,1,32000,0.00),
(5,17,5,5,350,0.00),
(6,5,1,2,2800,0.10),
(6,18,1,1,1800,0.00),
(7,15,2,1,14500,0.05),
(7,14,2,3,650,0.00),
(8,7,3,3,1800,0.00),
(8,20,3,2,2200,0.05),
(9,11,4,1,18500,0.00),
(9,16,4,4,750,0.00),
(10,10,5,2,4200,0.05),
(10,21,5,1,3800,0.00),

(11,1,1,4,850,0.00),
(11,17,1,5,350,0.00),
(12,8,2,1,12500,0.00),
(12,9,2,3,950,0.05),
(13,22,3,2,3200,0.00),
(13,23,3,1,1850,0.00),
(14,15,4,1,14500,0.00),
(14,14,4,2,650,0.00),
(15,12,5,1,32000,0.00),
(15,18,5,2,1800,0.05),
(16,6,1,2,1450,0.00),
(16,25,1,3,950,0.10),
(17,3,2,2,3500,0.05),
(17,13,2,2,1250,0.00),
(18,11,3,1,18500,0.00),
(18,17,3,5,350,0.00),
(19,4,4,1,6200,0.00),
(19,16,4,2,750,0.00),
(20,12,5,1,32000,0.00),

(21,2,1,5,1100,0.05),
(21,9,1,3,950,0.00),
(22,7,2,2,1800,0.00),
(22,20,2,1,2200,0.05),
(23,15,3,1,14500,0.00),
(23,17,3,4,350,0.00),
(24,5,4,3,2800,0.05),
(24,14,4,2,650,0.00),
(25,6,5,4,1450,0.00),
(25,25,5,3,950,0.00),
(26,3,1,4,3500,0.05),
(26,13,1,2,1250,0.00),
(27,1,2,2,850,0.00),
(27,16,2,3,750,0.00),
(28,8,3,1,12500,0.00),
(28,9,3,1,950,0.00),
(29,11,4,1,18500,0.00),
(29,18,4,2,1800,0.05),
(30,22,5,2,3200,0.00),
(30,23,5,2,1850,0.00),

(31,15,1,1,14500,0.00),
(31,14,1,2,650,0.00),
(32,4,2,1,6200,0.00),
(32,25,2,2,950,0.05),
(33,12,3,1,32000,0.00),
(33,17,3,5,350,0.00),
(34,10,4,1,4200,0.00),
(34,20,4,2,2200,0.05),
(35,7,5,2,1800,0.00),
(35,6,5,3,1450,0.00),
(36,5,1,1,2800,0.00),
(36,16,1,3,750,0.00),
(37,11,2,1,18500,0.00),
(37,13,2,3,1250,0.00),
(38,2,3,3,1100,0.05),
(38,9,3,2,950,0.00),
(39,3,4,2,3500,0.00),
(39,21,4,1,3800,0.05),
(40,12,5,1,32000,0.00),

(41,6,1,4,1450,0.00),
(41,25,1,2,950,0.00),
(42,11,2,1,18500,0.00),
(42,18,2,2,1800,0.05),
(43,8,3,1,12500,0.00),
(43,17,3,4,350,0.00),
(44,12,4,1,32000,0.00),
(44,14,4,2,650,0.00),
(45,7,5,3,1800,0.00),
(45,20,5,2,2200,0.05),
(46,22,1,2,3200,0.00),
(46,23,1,1,1850,0.00),
(47,4,2,1,6200,0.00),
(47,16,2,2,750,0.00),
(48,15,3,1,14500,0.05),
(48,17,3,5,350,0.00),
(49,3,4,2,3500,0.00),
(49,13,4,3,1250,0.00),
(50,10,5,2,4200,0.00),
(50,9,5,2,950,0.05),

(51,1,1,5,850,0.00),
(52,2,2,6,1100,0.05),
(53,3,3,2,3500,0.00),
(54,4,4,1,6200,0.00),
(55,5,5,4,2800,0.05),
(56,6,1,3,1450,0.00),
(57,7,2,5,1800,0.00),
(58,8,3,1,12500,0.10),
(59,9,4,6,950,0.00),
(60,10,5,2,4200,0.05),
(61,11,1,1,18500,0.00),
(62,12,2,1,32000,0.00),
(63,13,3,5,1250,0.00),
(64,14,4,8,650,0.05),
(65,15,5,1,14500,0.00),
(66,16,1,6,750,0.00),
(67,17,2,10,350,0.00),
(68,18,3,2,1800,0.05),
(69,19,4,1,6500,0.00),
(70,20,5,3,2200,0.00),
(71,21,1,2,3800,0.05),
(72,22,2,2,3200,0.00),
(73,23,3,3,1850,0.00),
(74,24,4,2,2400,0.05),
(75,25,5,6,950,0.00),
(76,1,1,3,850,0.00),
(77,2,2,4,1100,0.05),
(78,3,3,3,3500,0.00),
(79,4,4,2,6200,0.00),
(80,5,5,3,2800,0.05),
(81,6,1,4,1450,0.00),
(82,7,2,2,1800,0.00),
(83,8,3,1,12500,0.00),
(84,9,4,5,950,0.05),
(85,10,5,3,4200,0.00),
(86,11,1,1,18500,0.00),
(87,12,2,1,32000,0.00),
(88,13,3,4,1250,0.05),
(89,14,4,6,650,0.00),
(90,15,5,1,14500,0.00),
(91,16,1,5,750,0.00),
(92,17,2,12,350,0.05),
(93,18,3,2,1800,0.00),
(94,19,4,2,6500,0.00),
(95,20,5,3,2200,0.05),
(96,21,1,1,3800,0.00),
(97,22,2,3,3200,0.00),
(98,23,3,2,1850,0.05),
(99,24,4,4,2400,0.00),
(100,25,5,5,950,0.00);



INSERT INTO shipments
(order_id, shipment_code, carrier,
 shipped_date, promised_date, delivered_date, shipment_status)
VALUES
(1,'SHP-001','Delhivery','2024-01-06','2024-01-10','2024-01-10','Delivered'),
(2,'SHP-002','Blue Dart','2024-01-09','2024-01-14','2024-01-13','Delivered'),
(3,'SHP-003','DTDC','2024-01-13','2024-01-19','2024-01-21','Delivered'),
(4,'SHP-004','Delhivery','2024-01-16','2024-01-21',NULL,'Cancelled'),
(5,'SHP-005','XpressBees','2024-01-20','2024-01-27','2024-01-29','Delivered'),
(6,'SHP-006','DTDC','2024-01-24','2024-01-29','2024-01-30','Returned'),
(7,'SHP-007','Blue Dart','2024-01-28','2024-02-03','2024-02-02','Delivered'),
(8,'SHP-008','Delhivery','2024-02-03','2024-02-08','2024-02-08','Delivered'),
(9,'SHP-009','Ecom Express','2024-02-07','2024-02-14','2024-02-17','Delivered'),
(10,'SHP-010','Delhivery','2024-02-11','2024-02-16','2024-02-15','Delivered'),

(11,'SHP-011','DTDC','2024-02-19','2024-02-24',NULL,'Cancelled'),
(12,'SHP-012','Blue Dart','2024-02-19','2024-02-25','2024-02-24','Delivered'),
(13,'SHP-013','Delhivery','2024-02-22','2024-02-27','2024-02-28','Delivered'),
(14,'SHP-014','XpressBees','2024-02-26','2024-03-03','2024-03-05','Returned'),
(15,'SHP-015','Ecom Express','2024-03-02','2024-03-08','2024-03-07','Delivered'),
(16,'SHP-016','Delhivery','2024-03-06','2024-03-11','2024-03-10','Delivered'),
(17,'SHP-017','Blue Dart','2024-03-10','2024-03-16','2024-03-17','Delivered'),
(18,'SHP-018','DTDC','2024-03-14','2024-03-20','2024-03-23','Delivered'),
(19,'SHP-019','Delhivery','2024-03-19','2024-03-24',NULL,'Cancelled'),
(20,'SHP-020','Ecom Express','2024-03-23','2024-03-29','2024-03-30','Delivered'),

(21,'SHP-021','Blue Dart','2024-03-28','2024-04-03','2024-04-03','Delivered'),
(22,'SHP-022','Delhivery','2024-04-03','2024-04-08','2024-04-07','Delivered'),
(23,'SHP-023','DTDC','2024-04-08','2024-04-14','2024-04-16','Returned'),
(24,'SHP-024','XpressBees','2024-04-12','2024-04-18','2024-04-21','Delivered'),
(25,'SHP-025','Delhivery','2024-04-17','2024-04-22','2024-04-22','Delivered'),
(26,'SHP-026','Blue Dart','2024-04-21','2024-04-27','2024-04-26','Delivered'),
(27,'SHP-027','DTDC','2024-04-26','2024-05-01',NULL,'Cancelled'),
(28,'SHP-028','Ecom Express','2024-04-30','2024-05-06','2024-05-08','Delivered'),
(29,'SHP-029','Delhivery','2024-05-05','2024-05-11','2024-05-11','Delivered'),
(30,'SHP-030','Blue Dart','2024-05-10','2024-05-16','2024-05-14','Delivered'),

(31,'SHP-031','Delhivery','2024-05-14','2024-05-20','2024-05-19','Delivered'),
(32,'SHP-032','DTDC','2024-05-18','2024-05-24','2024-05-27','Returned'),
(33,'SHP-033','Ecom Express','2024-05-23','2024-05-29','2024-05-30','Delivered'),
(34,'SHP-034','Blue Dart','2024-05-28','2024-06-03','2024-06-03','Delivered'),
(35,'SHP-035','Delhivery','2024-06-02','2024-06-08','2024-06-07','Delivered'),
(36,'SHP-036','DTDC','2024-06-07','2024-06-12',NULL,'Cancelled'),
(37,'SHP-037','Blue Dart','2024-06-11','2024-06-17','2024-06-19','Delivered'),
(38,'SHP-038','Delhivery','2024-06-16','2024-06-21','2024-06-20','Delivered'),
(39,'SHP-039','XpressBees','2024-06-20','2024-06-27','2024-06-30','Delivered'),
(40,'SHP-040','Ecom Express','2024-06-25','2024-07-01','2024-07-02','Delivered'),

(41,'SHP-041','Delhivery','2024-06-30','2024-07-05','2024-07-05','Delivered'),
(42,'SHP-042','Blue Dart','2024-07-04','2024-07-10','2024-07-09','Delivered'),
(43,'SHP-043','DTDC','2024-07-09','2024-07-15','2024-07-17','Returned'),
(44,'SHP-044','Ecom Express','2024-07-13','2024-07-19','2024-07-22','Delivered'),
(45,'SHP-045','Delhivery','2024-07-18','2024-07-24','2024-07-23','Delivered'),
(46,'SHP-046','Blue Dart','2024-07-23','2024-07-29','2024-07-28','Delivered'),
(47,'SHP-047','DTDC','2024-07-28','2024-08-02',NULL,'Cancelled'),
(48,'SHP-048','Delhivery','2024-08-02','2024-08-08','2024-08-07','Delivered'),
(49,'SHP-049','Ecom Express','2024-08-07','2024-08-13','2024-08-16','Delivered'),
(50,'SHP-050','Blue Dart','2024-08-12','2024-08-18','2024-08-17','Delivered'),

(51,'SHP-051','Delhivery','2024-08-17','2024-08-23','2024-08-22','Delivered'),
(52,'SHP-052','DTDC','2024-08-22','2024-08-28','2024-08-30','Returned'),
(53,'SHP-053','Ecom Express','2024-08-27','2024-09-02','2024-09-03','Delivered'),
(54,'SHP-054','Blue Dart','2024-09-02','2024-09-08','2024-09-07','Delivered'),
(55,'SHP-055','Delhivery','2024-09-07','2024-09-13','2024-09-12','Delivered'),
(56,'SHP-056','DTDC','2024-09-12','2024-09-17',NULL,'Cancelled'),
(57,'SHP-057','Blue Dart','2024-09-17','2024-09-23','2024-09-25','Delivered'),
(58,'SHP-058','Delhivery','2024-09-22','2024-09-28','2024-09-27','Delivered'),
(59,'SHP-059','Ecom Express','2024-09-27','2024-10-03','2024-10-05','Delivered'),
(60,'SHP-060','Delhivery','2024-10-02','2024-10-08','2024-10-07','Delivered'),

(61,'SHP-061','Blue Dart','2024-10-07','2024-10-13','2024-10-12','Delivered'),
(62,'SHP-062','DTDC','2024-10-12','2024-10-18','2024-10-20','Delivered'),
(63,'SHP-063','Delhivery','2024-10-17','2024-10-23','2024-10-25','Returned'),
(64,'SHP-064','Ecom Express','2024-10-22','2024-10-28','2024-10-29','Delivered'),
(65,'SHP-065','Blue Dart','2024-10-27','2024-11-02','2024-11-01','Delivered'),
(66,'SHP-066','Delhivery','2024-11-02','2024-11-08','2024-11-07','Delivered'),
(67,'SHP-067','DTDC','2024-11-07','2024-11-13',NULL,'Cancelled'),
(68,'SHP-068','Ecom Express','2024-11-12','2024-11-18','2024-11-20','Delivered'),
(69,'SHP-069','Delhivery','2024-11-17','2024-11-23','2024-11-22','Delivered'),
(70,'SHP-070','Blue Dart','2024-11-22','2024-11-28','2024-11-27','Delivered'),

(71,'SHP-071','Delhivery','2024-11-27','2024-12-03','2024-12-04','Delivered'),
(72,'SHP-072','DTDC','2024-12-02','2024-12-08','2024-12-10','Returned'),
(73,'SHP-073','Ecom Express','2024-12-07','2024-12-13','2024-12-12','Delivered'),
(74,'SHP-074','Blue Dart','2024-12-12','2024-12-18','2024-12-17','Delivered'),
(75,'SHP-075','Delhivery','2024-12-17','2024-12-23','2024-12-22','Delivered'),
(76,'SHP-076','DTDC','2024-12-22','2024-12-28',NULL,'Cancelled'),
(77,'SHP-077','Blue Dart','2024-12-27','2025-01-02','2025-01-03','Delivered'),
(78,'SHP-078','Delhivery','2024-12-30','2025-01-05','2025-01-05','Delivered'),
(79,'SHP-079','Ecom Express','2025-01-04','2025-01-10','2025-01-12','Delivered'),
(80,'SHP-080','Blue Dart','2025-01-08','2025-01-14','2025-01-13','Delivered'),

(81,'SHP-081','Delhivery','2025-01-13','2025-01-19','2025-01-18','Delivered'),
(82,'SHP-082','DTDC','2025-01-18','2025-01-24','2025-01-26','Delivered'),
(83,'SHP-083','Ecom Express','2025-01-23','2025-01-29','2025-01-31','Returned'),
(84,'SHP-084','Blue Dart','2025-01-28','2025-02-03','2025-02-02','Delivered'),
(85,'SHP-085','Delhivery','2025-02-02','2025-02-08','2025-02-07','Delivered'),
(86,'SHP-086','DTDC','2025-02-07','2025-02-13',NULL,'Cancelled'),
(87,'SHP-087','Blue Dart','2025-02-12','2025-02-18','2025-02-17','Delivered'),
(88,'SHP-088','Delhivery','2025-02-17','2025-02-23','2025-02-24','Delivered'),
(89,'SHP-089','Ecom Express','2025-02-22','2025-02-28','2025-03-02','Delivered'),
(90,'SHP-090','Blue Dart','2025-02-27','2025-03-05','2025-03-04','Delivered');



INSERT INTO inventory
(warehouse_id, product_id, stock_qty, reorder_level, unit_value, snapshot_date)
VALUES
(1,1,12,30,520,'2025-04-30'),
(1,2,65,35,690,'2025-04-30'),
(1,3,210,50,2200,'2025-04-30'),
(1,4,8,25,3900,'2025-04-30'),
(1,5,74,40,1700,'2025-04-30'),
(1,6,18,30,850,'2025-04-30'),
(1,7,92,40,1050,'2025-04-30'),
(1,8,15,20,7800,'2025-04-30'),
(1,9,145,60,550,'2025-04-30'),
(1,10,52,30,2700,'2025-04-30'),
(1,11,6,15,12000,'2025-04-30'),
(1,12,22,10,21000,'2025-04-30'),
(1,13,88,40,720,'2025-04-30'),
(1,14,120,50,360,'2025-04-30'),
(1,15,11,20,9200,'2025-04-30'),
(1,16,75,40,420,'2025-04-30'),
(1,17,180,80,180,'2025-04-30'),
(1,18,32,25,1050,'2025-04-30'),
(1,19,9,15,4100,'2025-04-30'),
(1,20,67,30,1300,'2025-04-30'),

(2,1,45,30,520,'2025-04-30'),
(2,2,9,25,690,'2025-04-30'),
(2,3,130,45,2200,'2025-04-30'),
(2,4,34,20,3900,'2025-04-30'),
(2,5,18,30,1700,'2025-04-30'),
(2,6,75,35,850,'2025-04-30'),
(2,7,11,25,1050,'2025-04-30'),
(2,8,7,15,7800,'2025-04-30'),
(2,9,110,50,550,'2025-04-30'),
(2,10,36,25,2700,'2025-04-30'),
(2,11,19,15,12000,'2025-04-30'),
(2,12,5,10,21000,'2025-04-30'),
(2,13,64,35,720,'2025-04-30'),
(2,14,95,40,360,'2025-04-30'),
(2,15,27,20,9200,'2025-04-30'),
(2,16,42,35,420,'2025-04-30'),
(2,17,210,80,180,'2025-04-30'),
(2,18,14,20,1050,'2025-04-30'),
(2,19,23,15,4100,'2025-04-30'),
(2,20,55,30,1300,'2025-04-30'),

(3,1,82,30,520,'2025-04-30'),
(3,2,58,35,690,'2025-04-30'),
(3,3,15,40,2200,'2025-04-30'),
(3,4,6,20,3900,'2025-04-30'),
(3,5,91,40,1700,'2025-04-30'),
(3,6,33,30,850,'2025-04-30'),
(3,7,48,35,1050,'2025-04-30'),
(3,8,19,20,7800,'2025-04-30'),
(3,9,175,60,550,'2025-04-30'),
(3,10,8,25,2700,'2025-04-30'),
(3,11,12,15,12000,'2025-04-30'),
(3,12,17,10,21000,'2025-04-30'),
(3,13,75,40,720,'2025-04-30'),
(3,14,140,50,360,'2025-04-30'),
(3,15,5,20,9200,'2025-04-30'),
(3,16,90,40,420,'2025-04-30'),
(3,17,155,80,180,'2025-04-30'),
(3,18,38,25,1050,'2025-04-30'),
(3,19,4,15,4100,'2025-04-30'),
(3,20,72,30,1300,'2025-04-30'),

(4,1,25,30,520,'2025-04-30'),
(4,2,71,35,690,'2025-04-30'),
(4,3,185,50,2200,'2025-04-30'),
(4,4,12,25,3900,'2025-04-30'),
(4,5,63,40,1700,'2025-04-30'),
(4,6,14,30,850,'2025-04-30'),
(4,7,86,40,1050,'2025-04-30'),
(4,8,9,20,7800,'2025-04-30'),
(4,9,130,60,550,'2025-04-30'),
(4,10,44,30,2700,'2025-04-30'),
(4,11,7,15,12000,'2025-04-30'),
(4,12,31,10,21000,'2025-04-30'),
(4,13,93,40,720,'2025-04-30'),
(4,14,118,50,360,'2025-04-30'),
(4,15,16,20,9200,'2025-04-30'),
(4,16,68,40,420,'2025-04-30'),
(4,17,195,80,180,'2025-04-30'),
(4,18,21,25,1050,'2025-04-30'),
(4,19,13,15,4100,'2025-04-30'),
(4,20,48,30,1300,'2025-04-30'),

(5,1,51,30,520,'2025-04-30'),
(5,2,14,30,690,'2025-04-30'),
(5,3,95,45,2200,'2025-04-30'),
(5,4,3,20,3900,'2025-04-30'),
(5,5,67,40,1700,'2025-04-30'),
(5,6,27,30,850,'2025-04-30'),
(5,7,105,40,1050,'2025-04-30'),
(5,8,13,20,7800,'2025-04-30'),
(5,9,160,60,550,'2025-04-30'),
(5,10,35,25,2700,'2025-04-30'),
(5,11,10,15,12000,'2025-04-30'),
(5,12,8,10,21000,'2025-04-30'),
(5,13,82,40,720,'2025-04-30'),
(5,14,125,50,360,'2025-04-30'),
(5,15,18,20,9200,'2025-04-30'),
(5,16,55,40,420,'2025-04-30'),
(5,17,225,80,180,'2025-04-30'),
(5,18,29,25,1050,'2025-04-30'),
(5,19,6,15,4100,'2025-04-30'),
(5,20,61,30,1300,'2025-04-30');


--Verifying inserted data :
select 'customers' as table_name, count(*) as total_records from customers
UNION ALL
select 'warehouses' as table_name,count(*) as total_records from warehouses
UNION ALL
select 'suppliers',  count(*) as total_records from suppliers
UNION ALL
select 'products', count(*) as total_records from products
UNION ALL
select 'orders', count(*) as total_records from orders
UNION ALL
select 'order_items',count(*) as total_records from order_items
UNION ALL
select 'shipments',count(*) as total_records from shipments
UNION ALL
select 'inventory',count(*) as total_records from inventory;



-- Bussiness questions : Sales performance

-- Total numbers of orders:
select count(order_id) as total_number_oforders
from orders;

--Total order value:
select sum(total_amount) as total_order_value
from orders;

--Average order value:
select avg(total_amount) as average_order_value
from orders;


-- Bussiness questions: order status

--Completed,Returned,Cancelled
select count(order_id) as numbers_of_orders,order_status
from orders
group by order_status;

-- Revenue by Order Status:
select count(order_id) as numbers_of_orders,order_status, sum(total_amount)as total_value
from orders
group by order_status;


-- Bussiness problem: which warehouse generates the most bussines?

--most money by warehouses: Highest to Lowest
select warehouse_id,sum(total_amount)as total_value
from orders
group by warehouse_id
order by total_value desc;


--Bussiness problem: Warehosue performance
select warehouse_id, count(order_id) as number_orders, sum(total_amount) as total_order_value,round(avg(total_amount),2)as average_order_value
from orders
group by warehouse_id
order by total_order_value desc;

-- Bussiness problem: warehouse performance with name
select 
	warehouses.warehouse_name,
	count(order_id) as number_of_orders,
	sum(total_amount) as total_order_value,
	avg(total_amount) as average_order_value
from orders
INNER JOIN warehouses
	on orders.warehouse_id=warehouses.warehouse_id
group by warehouses.warehouse_name
order by total_order_value desc
;

-- Returned, cancelled orders verification:
select 
	warehouses.warehouse_name,
	sum(
	CASE
		WHEN orders.order_status='Cancelled' THEN 1
		ELSE 0
	END
	) as returned_orders
from orders
INNER JOIN warehouses
	on orders.warehouse_id=warehouses.warehouse_id
group by warehouses.warehouse_name
order by returned_orders DESC;


--Returned,cancelled and total orders: 
select 
	count(order_id) as total_orders,warehouses.warehouse_name,
	sum(
		CASE
			WHEN orders.order_status='Cancelled' THEN 1
			ELSE 0
		END
	) as cancelled_orders,
	sum(
		CASE
			WHEN orders.order_status='Returned' THEN 1
			ELSE 0
		END
	) as returned_orders
from orders
INNER JOIN warehouses
	on orders.warehouse_id=warehouses.warehouse_id
group by warehouses.warehouse_name;


--Calculation and % rate:
select 
	count(order_id) as total_orders,warehouses.warehouse_name,
	sum(
		CASE
			WHEN orders.order_status='Cancelled' THEN 1
			ELSE 0
		END
	) as cancelled_orders,
	sum(
		CASE
			WHEN orders.order_status='Returned' THEN 1
			ELSE 0
		END
	) as returned_orders,
	sum(
		CASE
			WHEN orders.order_status IN('Cancelled','Returned') THEN 1
			ELSE 0
		END
	) as cancelled_or_returned,
	round(
		sum(
			CASE
				WHEN orders.order_status IN('Cancelled','Returned') THEN 1
				ELSE 0
		END
		)*100.0/count(order_id),2) as cancel_return_rate
from orders
INNER JOIN warehouses
	on orders.warehouse_id=warehouses.warehouse_id
group by warehouses.warehouse_name;



select* from inventory;


--Bussiness problem: 
--how many inventory records have stock below their reorder level?
select* from inventory
where stock_qty<reorder_level;


--Warehouse with products where stock is below reorder level:(Multi-table join)
select 
	products.product_name,
	warehouses.warehouse_name,
	inventory.stock_qty,
	inventory.reorder_level
from inventory
INNER JOIN products
ON 
	inventory.product_id=products.product_id
INNER JOIN warehouses
ON
	inventory.warehouse_id=warehouses.warehouse_id
where inventory.stock_qty< inventory.reorder_level;



--Bussiness problem: 
--Which product has the largest stock shortage?

select 
	products.product_name,
	warehouses.warehouse_name,
	inventory.stock_qty,
	inventory.reorder_level,
	reorder_level-stock_qty as stock_shortage
from inventory
INNER JOIN products
ON 
	inventory.product_id=products.product_id
INNER JOIN warehouses
ON
	inventory.warehouse_id=warehouses.warehouse_id
where inventory.stock_qty<inventory.reorder_level
order by stock_shortage DESC
limit 1;



--Bussiness problem: Supplier Peformance
--Which suppliers provide the most products?
select count(product_id)as product_supplied,supplier_id as supplier
from products
group by supplier_id;


--suppliers name with most products:
select 
count(product_id)as product_supplied,
supplier_name as supplier
from products
INNER JOIN suppliers
ON
	products.supplier_id=suppliers.supplier_id
group by suppliers.supplier_name;

--suppliers with average lead days,reliability score and most products:
select 
count(product_id)as product_supplied,
supplier_name as supplier,
suppliers.average_lead_days,
suppliers.reliability_score
from products
INNER JOIN suppliers
ON
	products.supplier_id=suppliers.supplier_id
group by 
	suppliers.supplier_name,
	suppliers.average_lead_days,
	suppliers.reliability_score;

--Final supplier analysis: 
--which supplier should the company be most concerned about?
select 
count(product_id)as product_supplied,
supplier_name as supplier,
suppliers.average_lead_days,
suppliers.reliability_score
from products
INNER JOIN suppliers
ON
	products.supplier_id=suppliers.supplier_id
group by 
	suppliers.supplier_name,
	suppliers.average_lead_days,
	suppliers.reliability_score
order by suppliers.average_lead_days desc
limit 3;


--Bussiness problem: sales performance
--Sales value for each order item:
select
	order_id,
	product_id,
	quantity,
	unit_price,
	quantity*unit_price as sales_value
from order_items;

-- Sales by product:
select
	product_id,
	sum(quantity*unit_price)as total_sales
from order_items
group by product_id
order by total_sales desc;

--Sales by product names:
select 
	products.product_name, 
	sum(order_items.quantity*order_items.unit_price)as total_sales 
from order_items 
INNER JOIN products 
on 
	order_items.product_id=products.product_id 
group by products.product_name 
order by total_sales desc;

--Products with highest sales volume(units sold):
select 
	products.product_name, 
	sum(quantity)as units_sold,
	sum(order_items.quantity*order_items.unit_price)as total_sales 
from order_items 
INNER JOIN products 
on 
	order_items.product_id=products.product_id 
group by products.product_name 
order by units_sold desc;

--Product profitability:
select 
	products.product_name, 
	sum(quantity)as units_sold,
	sum(order_items.quantity*order_items.unit_price)as total_sales ,
	sum(quantity*order_items.unit_price-products.unit_cost) as total_profit
from order_items 
INNER JOIN products 
on 
	order_items.product_id=products.product_id 
group by products.product_name 
order by total_profit desc;


--Delivery peformance:
--how many shipments are in each status? 
select count(shipment_code) as total_shipments,shipment_status
from shipments
group by shipment_status;


--what is the delievery date for each shipment? 
select
	shipment_code,
	carrier,
	shipped_date,
	delivered_date,
	delivered_date-shipped_date as delivery_days
from shipments;

--Total Late deliveries: 
select
	shipment_code,
	promised_date,
	delivered_date
from shipments
where delivered_date>promised_date;

--How late were they?
select
	shipment_code,
	carrier,
	promised_date,
	delivered_date,
	delivered_date-promised_date as days_late
from shipments
order by days_late desc;

--which carrier performs worst?
select
	count(shipment_code) as late_shipments,
	carrier
from shipments
where delivered_date>promised_date
group by carrier
order by late_shipments desc;


--Delivery performance by Carrirer:
select 
	carrier,
	count(shipment_code) as total_delivered_shipments
from shipments
where shipment_status='Delivered'
group by carrier;

--count late shipments per carrier:
SELECT
    carrier,
    COUNT(shipment_code) AS late_shipments
FROM shipments
WHERE delivered_date > promised_date
GROUP BY carrier;


--Carrier late delivery rate:
SELECT
    carrier,

    COUNT(shipment_code) AS total_delivered_shipments,

    SUM(
        CASE
            WHEN delivered_date > promised_date THEN 1
            ELSE 0
        END
    ) AS late_shipments,

    ROUND(
        SUM(
            CASE
                WHEN delivered_date > promised_date THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(shipment_code),
        2
    ) AS late_delivery_rate
FROM shipments
WHERE shipment_status = 'Delivered'
GROUP BY carrier
ORDER BY late_delivery_rate DESC;

--Average delivery delay by carrier:
select 
	carrier,
	avg(delivered_date-promised_date) as average_late_days
from shipments
where delivered_date>promised_date
group by carrier
order by average_late_days desc;

--Which warehouse has the highest number of late deliveries? 
select
	warehouses.warehouse_name,
	warehouses.warehouse_id,
	count(shipment_code) as late_shipments
from shipments
INNER JOIN orders
	ON shipments.order_id=orders.order_id
INNER JOIN warehouses
	ON orders.warehouse_id=warehouses.warehouse_id
where delivered_date>promised_date
group by warehouses.warehouse_id
order by late_shipments desc;

--percentage of each warehouse's delivered shipments were late?
select
	warehouses.warehouse_name,
	count(shipment_code) as total_delivered_shipments,
	sum(
		case
			when delivered_date>promised_date then 1
			else 0
		end
	) as late_shipments,
	ROUND(
        SUM(
            CASE
                WHEN delivered_date > promised_date THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(shipment_code),
        2
    ) AS late_delivery_rate
from shipments
INNER JOIN orders
	ON shipments.order_id=orders.order_id
INNER JOIN warehouses
	ON orders.warehouse_id=warehouses.warehouse_id
where shipment_status='Delivered'
group by warehouses.warehouse_name
order by late_delivery_rate desc;

--average delivery time by warehouse:
select 
	warehouses.warehouse_name,
	avg(delivered_date-shipped_date) as average_delivery_days
from shipments
INNER JOIN orders
on 
	shipments.order_id=orders.order_id
INNER JOIN warehouses
on 
	orders.warehouse_id=warehouses.warehouse_id
where shipment_status='Delivered'
group by warehouses.warehouse_name
order by average_delivery_days desc;

--Worst individual delivery: 
select
	shipment_code,
	carrier,
	shipped_date,
	delivered_date,
	delivered_date-shipped_date as delivery_days
from shipments
where shipment_status='Delivered'
order by delivery_days desc
limit 1;


--Customer analysis: 
--which customers have generated the most bussiness?
select
	customers.customer_name,
	count(orders.order_id) as total_orders,
	sum(orders.total_amount) as total_order_value,
	avg(orders.total_amount) as average_order_value
from customers	
INNER JOIN orders
on 
	customers.customer_id=orders.customer_id
group by customers.customer_name
order by total_order_value desc;


--High value customers;
select 
	customers.customer_name,
	count(orders.order_id) as completed_orders,
	sum(orders.total_amount) as completed_order_value
from customers
inner join orders
on 
	customers.customer_id=orders.customer_id
where order_status='Completed'
group by customers.customer_name
order by completed_order_value desc;


--Customer order frequency: 
--which customers place orders most frequently? 
select
	customers.customer_name,
	count(orders.order_id) as total_orders,
	sum(total_amount)as total_order_value
from orders
INNER JOIN customers
ON
	orders.customer_id=customers.customer_id
group by customers.customer_name
order by total_orders DESC;

	
--Customer value VS order frequency:
--which customers have an average order value above the overall average order value?

SELECT 
    customers.customer_name,
    AVG(total_amount) AS average_order_value
FROM orders
INNER JOIN customers
    ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_name
HAVING AVG(orders.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
)
ORDER BY average_order_value DESC
limit 1;

--Product & Supplier Analysis:
--which products have a selling price higher than the average selling price of all products?

select
	product_name,
	selling_price
from products
where selling_price>(
	select avg(selling_price)
	from products
);

--which suppliers have a reliability score higher than the average reliability score of all suppliers?

select
	supplier_name,
	reliability_score,
	average_lead_days
from suppliers
where reliability_score>(
	select avg(reliability_score)
	from suppliers
);


--which products have a selling price higher than the average selling price of products in their own category?
SELECT
    p1.product_name,
    p1.category,
    p1.selling_price
FROM products p1
WHERE p1.selling_price > (
    SELECT AVG(p2.selling_price)
    FROM products p2
    WHERE p2.category = p1.category
);


--High value customers:
--which customers generated more than 70,000 in total order value?
WITH customer_summary AS (
    SELECT
        c.customer_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_order_value
    FROM customers c
    INNER JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    total_orders,
    total_order_value
FROM customer_summary
WHERE total_order_value > 70000
ORDER BY total_order_value DESC;

--warehouse performance:
--which warehouses generate the most revenue and what is their average order value?
WITH warehouse_summary AS (
    SELECT
        w.warehouse_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_revenue,
        AVG(o.total_amount) AS average_order_value
    FROM warehouses w
    INNER JOIN orders o
        ON w.warehouse_id = o.warehouse_id
    GROUP BY w.warehouse_name
)
SELECT
    warehouse_name,
    total_orders,
    total_revenue,
    ROUND(average_order_value, 2) AS average_order_value
FROM warehouse_summary
ORDER BY total_revenue DESC;


--Rank products by Sales:
--Rank product according to their total sales value
WITH product_sales AS (
    SELECT
        p.product_name,
        p.category,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    INNER JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY
        p.product_name,
        p.category
)
SELECT
    product_name,
    category,
    total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_sales
ORDER BY sales_rank;

--Rank warehouses:
--Rank warehouses by revenue
WITH warehouse_sales AS (
    SELECT
        w.warehouse_name,
        SUM(o.total_amount) AS total_revenue
    FROM warehouses w
    INNER JOIN orders o
        ON w.warehouse_id = o.warehouse_id
    GROUP BY w.warehouse_name
)
SELECT
    warehouse_name,
    total_revenue,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank
FROM warehouse_sales
ORDER BY revenue_rank;

--Monthly revenue ranking:
--for each months, what was the revenue and how does each month rank against other months?
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    monthly_revenue,
    RANK() OVER (
        ORDER BY monthly_revenue DESC
    ) AS revenue_rank
FROM monthly_sales
ORDER BY month;

--Date analysis
--Monthly Revenue Trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

--Yearly Performance:
SELECT
    EXTRACT(YEAR FROM order_date) AS order_year,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY order_year;

--Delivery date Analysis:
--what is the average delivery time by carrirer?
SELECT
    carrier,
    COUNT(order_id) AS delivered_shipments,
    ROUND(
        AVG(delivered_date - shipped_date),
        2
    ) AS average_delivery_days
FROM shipments
WHERE shipment_status = 'Delivered'
GROUP BY carrier
ORDER BY average_delivery_days;

--Late delivery analysis by month:
SELECT
    DATE_TRUNC('month', shipped_date) AS month,
    COUNT(order_id) AS total_shipments,

    SUM(
        CASE
            WHEN delivered_date > promised_date THEN 1
            ELSE 0
        END
    ) AS late_shipments

FROM shipments
WHERE shipment_status = 'Delivered'
GROUP BY DATE_TRUNC('month', shipped_date)
ORDER BY month;

--Inventory Risk Analysis:
SELECT
    w.warehouse_name,
    p.product_name,
    i.stock_qty,
    i.reorder_level,
    (i.reorder_level - i.stock_qty) AS shortage_units,
    CASE
        WHEN i.stock_qty = 0 THEN 'Out of Stock'
        WHEN i.stock_qty < i.reorder_level THEN 'Low Stock'
        ELSE 'Sufficient Stock'
    END AS inventory_status
FROM inventory i
INNER JOIN products p
    ON i.product_id = p.product_id
INNER JOIN warehouses w
    ON i.warehouse_id = w.warehouse_id
ORDER BY shortage_units DESC;

--Final KPI query:
SELECT
    COUNT(order_id) AS total_orders,
	SUM(total_amount) AS total_order_value,
	ROUND(
        AVG(total_amount),
        2
    ) AS average_order_value,

    SUM(
        CASE
            WHEN order_status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS completed_orders,

    SUM(
        CASE
            WHEN order_status = 'Cancelled' THEN 1
            ELSE 0
        END
    ) AS cancelled_orders,

    SUM(
        CASE
            WHEN order_status = 'Returned' THEN 1
            ELSE 0
        END
    ) AS returned_orders

FROM orders;






