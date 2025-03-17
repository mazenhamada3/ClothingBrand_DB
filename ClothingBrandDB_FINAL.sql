CREATE DATABASE ClothingBrandDB;
USE ClothingBrandDB;

-- Table for products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Size ENUM('XS', 'S', 'M', 'L', 'XL', 'XXL'),
    Color VARCHAR(30),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0
);


-- Table for customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15),
    Address TEXT
);

-- Table for discounts
CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY,
    DiscountName VARCHAR(100),
    DiscountType ENUM('Percentage', 'Fixed'),
    DiscountValue DECIMAL(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

-- Table for orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    DiscountID INT,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
	FOREIGN KEY (CustomerID) 
    REFERENCES Customers(CustomerID) 
    ON DELETE CASCADE,
	 CONSTRAINT FK_DiscountID FOREIGN KEY (DiscountID)
    REFERENCES Discounts(DiscountID)
    ON DELETE CASCADE
);


-- Table for order details
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) AS (Quantity * Price) STORED,
     FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);


-- Table for inventory
CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    QuantityChange INT NOT NULL,
    ChangeReason ENUM('Restock', 'Sale', 'Adjustment') NOT NULL,
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);




-- Table for suppliers
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(150),
    SuppliedProducts TEXT
);










-- Populate the Products table
INSERT INTO Products (ProductName, Category, Size, Color, Price, StockQuantity)
VALUES 
('T-Shirt', 'Tops', 'M', 'Blue', 15.99, 50),
('Jeans', 'Bottoms', 'L', 'Black', 39.99, 30),
('Jacket', 'Outerwear', 'XL', 'Green', 59.99, 20),
('Skirt', 'Bottoms', 'S', 'Red', 25.99, 40),
('Sweater', 'Tops', 'M', 'Yellow', 35.99, 25),
('Shirt', 'Tops', 'L', 'White', 29.99, 60),
('Shorts', 'Bottoms', 'M', 'Blue', 19.99, 15),
('Dress', 'Dresses', 'M', 'Pink', 49.99, 10),
('Coat', 'Outerwear', 'L', 'Gray', 89.99, 5),
('Blouse', 'Tops', 'S', 'Purple', 24.99, 35);

-- Populate the Customers table
INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber, Address)
VALUES
('Alice', 'Smith', 'alice.smith@example.com', '1234567890', '123 Elm St'),
('Bob', 'Johnson', 'bob.johnson@example.com', '0987654321', '456 Oak St'),
('Charlie', 'Brown', 'charlie.brown@example.com', '1122334455', '789 Pine St'),
('Diana', 'Prince', 'diana.prince@example.com', '6677889900', '101 Maple St'),
('Eve', 'White', 'eve.white@example.com', '7788990011', '202 Birch St'),
('Frank', 'Green', 'frank.green@example.com', '3344556677', '303 Cedar St'),
('Grace', 'Hopper', 'grace.hopper@example.com', '4455667788', '404 Spruce St'),
('Hank', 'Hill', 'hank.hill@example.com', '5566778899', '505 Walnut St'),
('Ivy', 'Clark', 'ivy.clark@example.com', '6677889901', '606 Fir St'),
('Jack', 'Brown', 'jack.brown@example.com', '7788990022', '707 Ash St');

-- Populate the Discounts table
INSERT INTO Discounts (DiscountName, DiscountType, DiscountValue, StartDate, EndDate)
VALUES
('Holiday Sale', 'Percentage', 10.00, '2024-12-01', '2024-12-31'),
('Black Friday', 'Percentage', 20.00, '2024-11-25', '2024-11-30'),
('Summer Sale', 'Fixed', 5.00, '2024-06-01', '2024-06-30'),
('Clearance', 'Percentage', 15.00, '2024-01-01', '2024-01-15'),
('VIP Discount', 'Fixed', 10.00, '2024-12-01', '2024-12-31');

INSERT INTO Orders (CustomerID, DiscountID, TotalAmount, Status)
VALUES
(1, NULL, 55.97, 'Shipped'),  -- NULL DiscountID is allowed
(2, 1, 89.97, 'Delivered'),   -- DiscountID 1 exists in Discounts table
(3, 2, 45.99, 'Pending'),     -- DiscountID 2 exists in Discounts table
(4, NULL, 25.99, 'Cancelled'),-- NULL DiscountID is allowed
(5, 3, 75.99, 'Shipped'),     -- DiscountID 3 exists in Discounts table
(6, NULL, 39.99, 'Delivered'),-- NULL DiscountID is allowed
(7, 4, 59.99, 'Pending'),     -- DiscountID 4 exists in Discounts table
(8, NULL, 49.99, 'Shipped'),  -- NULL DiscountID is allowed
(9, 5, 89.99, 'Delivered'),   -- DiscountID 5 exists in Discounts table
(10, NULL, 24.99, 'Pending'); -- NULL DiscountID is allowed

-- Populate the OrderDetails table
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 2, 15.99),
(1, 2, 1, 39.99),
(2, 3, 1, 59.99),
(2, 4, 2, 25.99),
(3, 5, 1, 35.99),
(4, 6, 1, 29.99),
(5, 7, 3, 19.99),
(6, 8, 2, 49.99),
(7, 9, 1, 89.99),
(8, 10, 1, 24.99);

-- Populate the Inventory table
INSERT INTO Inventory (ProductID, QuantityChange, ChangeReason)
VALUES
(1, 50, 'Restock'),
(2, -10, 'Sale'),
(3, 20, 'Restock'),
(4, -5, 'Sale'),
(5, 15, 'Restock'),
(6, -8, 'Sale'),
(7, 25, 'Restock'),
(8, -2, 'Sale'),
(9, 5, 'Restock'),
(10, -3, 'Sale');



-- Populate the Suppliers table
INSERT INTO Suppliers (Name, ContactInfo, SuppliedProducts)
VALUES
('Alpha Textiles', '1234567890', 'T-Shirt,Jeans,Jacket'),
('Beta Fabrics', '0987654321', 'Skirt,Sweater'),
('Gamma Apparel', '1122334455', 'Shirt,Shorts,Dress'),
('Delta Clothing', '6677889900', 'Coat,Blouse'),
('Epsilon Wear', '7788990011', 'Jacket,Skirt');