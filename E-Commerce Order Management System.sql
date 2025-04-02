 --E-Commerce Order Management System By Kasali A. Samson
 --Create Database
 CREATE DATABASE Ecommerce;
  USE Ecommerce;

 --CREATE TABLE 
 CREATE TABLE Customers (
    CustomerID INT IDENTITY (1,1) PRIMARY KEY, --AUTO_INCREMENT used here is identity (1,1)
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    CustomerAddress TEXT
);

CREATE TABLE Products (
    ProductID INT IDENTITY (1,1) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT NOT NULL
);

CREATE TABLE Orders (
    OrderID INT IDENTITY (1,1) PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    OrderStatus varchar (50), --Pending', 'Shipped', 'Delivered', 'Cancelled'
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY (1,1) PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY (1,1) PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentStatus varchar (50), --'Pending', 'Completed', 'Failed
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Deliveries (
    DeliveryID INT IDENTITY (1,1) PRIMARY KEY,
    OrderID INT,
    DeliveryDate DATE,
    DeliveryStatus varchar (50), --In Transit', 'Delivered', 'Failed'
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

CREATE TABLE Admins (
    AdminID INT IDENTITY (1,1) PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    AminRole varchar (50), --'Admin', 'CustomerService') DEFAULT 'CustomerService'
);

--INSERT INTO TABLE
INSERT INTO Customers VALUES 
('Alice Johnson', 'alice@example.com', '08165756432', '123 Market St'),
('Bob Smith', 'bob@example.com', '0987654321', '456 Commerce Rd'),
('Charlie Brown', 'charlie@example.com', '1122334455', '789 Elm Street'),
('Diana Prince', 'diana@example.com', '2233445566', '321 Amazon Blvd'),
('Ethan Hunt', 'ethan@example.com', '3344556677', '555 Mission Rd'),
('Fiona Gallagher', 'fiona@example.com', '4455667788', '741 Lakeside Ave'),
('George Lopez', 'george@example.com', '5566778899', '963 Riverside St'),
('Hannah Baker', 'hannah@example.com', '6677889900', '852 Sunset Blvd'),
('Isaac Newton', 'isaac@example.com', '7788990011', '159 Apple St'),
('Jessica Pearson', 'jessica@example.com', '8899001122', '753 Court Avenue')
;

INSERT INTO Products VALUES
('Laptop', 'Electronics', 1200.00, 10),
('Smartphone', 'Electronics', 800.00, 15),
('Headphones', 'Accessories', 100.00, 30),
('Smartwatch', 'Electronics', 250.00, 20),
('Gaming Console', 'Electronics', 500.00, 8),
('Wireless Mouse', 'Accessories', 40.00, 50),
('Mechanical Keyboard', 'Accessories', 120.00, 25),
('4K Monitor', 'Electronics', 350.00, 12),
('Bluetooth Speaker', 'Audio', 150.00, 18),
('External Hard Drive', 'Storage', 90.00, 40)
;

INSERT INTO Orders VALUES
(1, 2019, 'Pending'),
(2, 2020, 'Shipped'),
(3, 2021, 'Delivered'),
(4, 2022, 'Cancelled'),
(5, 2023, 'Pending'),
(6, 2024,  'Shipped'),
(7, 2025, 'Delivered'),
(8, 2023, 'Cancelled'),
(9, 2022, 'Pending'),
(10, 2021, 'Shipped')
;

INSERT INTO Payments VALUES
(1, 1400.00, 'Completed'),
(2, 800.00, 'Pending'),
(3, 200.00, 'Failed'),
(4, 500.00, 'Completed'),
(5, 250.00, 'Pending'),
(6, 90.00, 'Failed'),
(7, 350.00, 'Completed'),
(8, 150.00, 'Pending'),
(9, 40.00, 'Completed'),
(10, 120.00, 'Failed')
;

INSERT INTO Deliveries VALUES
(1, '2024-04-07', 'Delivered'),
(2, '2020-02-04', 'In Transit'),
(3, '2019-05-07', 'Failed'),
(4, '2023-12-01', 'Delivered'),
(5, '2022-11-15', 'In Transit'),
(6, '2021-09-20', 'Failed'),
(7, '2023-07-30', 'Delivered'),
(8, '2020-06-10', 'In Transit'),
(9, '2018-03-05', 'Failed'),
(10, '2024-01-12', 'Delivered')
;

INSERT INTO Admins VALUES
('admin1', 'hashed_password', 'Admin'),
('support1', 'hashed_password', 'CustomerService'),
('manager1', 'hashed_password', 'Admin'),
('support2', 'hashed_password', 'CustomerService'),
('admin2', 'hashed_password', 'Admin'),
('tech_support', 'hashed_password', 'CustomerService'),
('superadmin', 'hashed_password', 'Admin'),
('assistant1', 'hashed_password', 'CustomerService'),
('moderator1', 'hashed_password', 'CustomerService'),
('admin_support', 'hashed_password', 'Admin')
;


INSERT INTO OrderDetails VALUES
(1, 1, 1, 1200.00),
(2, 2, 2, 200.00),
(3, 3, 1, 800.00),
(4, 4, 1, 500.00),
(5, 5, 2, 500.00),
(6, 6, 3, 120.00),
(7, 7, 1, 350.00),
(8, 8, 2, 300.00),
(9, 9, 1, 40.00),
(10, 10, 2, 240.00)
;

--RETRIEVE RECORDS
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Payments;
SELECT * FROM Deliveries;
SELECT * FROM Admins;
SELECT * FROM OrderDetails;

--JOIN Query
SELECT * FROM Products WHERE Category = 'Electronics';
SELECT c.FullName, o.OrderDate, o.OrderStatus FROM Orders o JOIN Customers c ON o.CustomerID = c.CustomerID;


--Step 5: Update and Delete (DML)
UPDATE Orders SET OrderStatus = 'Delivered' WHERE OrderID = 2;
DELETE FROM OrderDetails WHERE OrderDetailID = 3;

--Transactions (TCL)
START TRANSACTION,
UPDATE Payments SET PaymentStatus = 'Completed' WHERE PaymentID = 2;
UPDATE Orders SET OrderStatus = 'Shipped' WHERE OrderID = 9;
COMMIT;

--User Access Control (DCL)
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'hashed_password';
GRANT SELECT, INSERT, UPDATE ON ECommerceDB.* TO 'manager'@'localhost';
REVOKE DELETE ON ECommerceDB.* FROM 'manager'@'localhost';