-- Insert Query
INSERT INTO Products (ProductName, Category, Size, Color, Price, StockQuantity)
VALUES ('Hoodie', 'Outerwear', 'M', 'Black', 45.99, 20);

-- Delete Query
DELETE FROM customers WHERE CustomerID = 3 ;



-- Update Query
UPDATE Customers
SET Address = '789 Updated Address St'
WHERE CustomerID = 3;

-- Select Query
SELECT * FROM Orders WHERE Status = 'Pending';

-- Aggregate Function Query 1
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;

-- Aggregate Function Query 2
SELECT AVG(Price) AS AveragePrice, MAX(Price) AS MaxPrice, MIN(Price) AS MinPrice
FROM Products;

-- Join Query 1
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Join Query 2
SELECT OrderDetails.OrderID, Products.ProductName, OrderDetails.Quantity, OrderDetails.Subtotal
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID;
