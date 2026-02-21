CREATE DATABASE data_transformer;
USE data_transformer;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Email VARCHAR(100),
RegistrationDate DATE
);

CREATE TABLE Orders (
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Department VARCHAR(50),
HireDate DATE,
Salary DECIMAL(10,2)
);

INSERT INTO Customers VALUES
(1,'John','Doe',' john.doe@email.com ','2023-06-15'),
(2,'Jane','Smith',' jane.smith@email.com ','2023-06-20'),
(3,'Robert','Brown',' robert.brown@email.com ','2023-07-01');

INSERT INTO Orders VALUES
(101,1,'2023-07-01',150.50),
(102,2,'2023-07-03',200.75),
(103,1,'2023-07-10',500.00),
(104,3,'2023-07-15',1200.00);

INSERT INTO Employees VALUES
(1,'Mark','Johnson','Sales','2022-01-10',45000),
(2,'Susan','Lee','HR','2021-03-15',55000),
(3,'David','Clark','IT','2020-07-20',70000),
(4,'Emma','Watson','Sales','2019-05-18',30000);

SELECT o.OrderID, c.FirstName, c.LastName, o.OrderDate, o.TotalAmount
FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID;

SELECT c.CustomerID, c.FirstName, o.OrderID, o.TotalAmount
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT o.OrderID, c.FirstName, c.LastName
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT c.CustomerID, c.FirstName, o.OrderID
FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerID, c.FirstName, o.OrderID
FROM Customers c
RIGHT JOIN Orders o
ON c.CustomerID = o.CustomerID;

SELECT DISTINCT CustomerID
FROM Orders
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Orders);

SELECT *
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

SELECT OrderID,
YEAR(OrderDate) AS OrderYear,
MONTH(OrderDate) AS OrderMonth
FROM Orders;

SELECT OrderID,
DATEDIFF(CURDATE(), OrderDate) AS DaysDifference
FROM Orders;

SELECT OrderID,
DATE_FORMAT(OrderDate,'%d-%M-%Y') AS FormattedDate
FROM Orders;

SELECT CustomerID,
CONCAT(FirstName,' ',LastName) AS FullName
FROM Customers;

SELECT REPLACE(FirstName,'John','Jonathan') AS UpdatedName
FROM Customers;

SELECT UPPER(FirstName) AS UpperFirstName,
LOWER(LastName) AS LowerLastName
FROM Customers;

SELECT TRIM(Email) AS CleanEmail
FROM Customers;

SELECT OrderID,
TotalAmount,
SUM(TotalAmount) OVER (ORDER BY OrderDate) AS RunningTotal
FROM Orders;

SELECT OrderID,
TotalAmount,
RANK() OVER (ORDER BY TotalAmount DESC) AS OrderRank
FROM Orders;

SELECT OrderID,
TotalAmount,
CASE
WHEN TotalAmount > 1000 THEN '10% Discount'
WHEN TotalAmount > 500 THEN '5% Discount'
ELSE 'No Discount'
END AS DiscountCategory
FROM Orders;

SELECT EmployeeID,
Salary,
CASE
WHEN Salary >= 60000 THEN 'High'
WHEN Salary >= 40000 THEN 'Medium'
ELSE 'Low'
END AS SalaryCategory
FROM Employees;