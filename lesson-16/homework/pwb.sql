CREATE database lsn16

CREATE TABLE Numbers1(Number INT)

INSERT INTO Numbers1 VALUES (5),(9),(8),(6),(7)

CREATE TABLE FindSameCharacters
(
     Id INT
    ,Vals VARCHAR(10)
)
 
INSERT INTO FindSameCharacters VALUES
(1,'aa'),
(2,'cccc'),
(3,'abc'),
(4,'aabc'),
(5,NULL),
(6,'a'),
(7,'zzz'),
(8,'abc')



CREATE TABLE RemoveDuplicateIntsFromNames
(
      PawanName INT
    , Pawan_slug_name VARCHAR(1000)
)
 
 
INSERT INTO RemoveDuplicateIntsFromNames VALUES
(1,  'PawanA-111'  ),
(2, 'PawanB-123'   ),
(3, 'PawanB-32'    ),
(4, 'PawanC-4444' ),
(5, 'PawanD-3'  )





CREATE TABLE Example
(
Id       INTEGER IDENTITY(1,1) PRIMARY KEY,
String VARCHAR(30) NOT NULL
);


INSERT INTO Example VALUES('123456789'),('abcdefghi');


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    DepartmentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2)
);

INSERT INTO Employees (EmployeeID, DepartmentID, FirstName, LastName, Salary) VALUES
(1, 1, 'John', 'Doe', 60000.00),
(2, 1, 'Jane', 'Smith', 65000.00),
(3, 2, 'James', 'Brown', 70000.00),
(4, 3, 'Mary', 'Johnson', 75000.00),
(5, 4, 'Linda', 'Williams', 80000.00),
(6, 2, 'Michael', 'Jones', 85000.00),
(7, 1, 'Robert', 'Miller', 55000.00),
(8, 3, 'Patricia', 'Davis', 72000.00),
(9, 4, 'Jennifer', 'García', 77000.00),
(10, 1, 'William', 'Martínez', 69000.00);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Finance'),
(5, 'IT'),
(6, 'Operations'),
(7, 'Customer Service'),
(8, 'R&D'),
(9, 'Legal'),
(10, 'Logistics');

CREATE TABLE Sales (
    SalesID INT PRIMARY KEY,
    EmployeeID INT,
    ProductID INT,
    SalesAmount DECIMAL(10, 2),
    SaleDate DATE
);
INSERT INTO Sales (SalesID, EmployeeID, ProductID, SalesAmount, SaleDate) VALUES
-- January 2025
(1, 1, 1, 1550.00, '2025-01-02'),
(2, 2, 2, 2050.00, '2025-01-04'),
(3, 3, 3, 1250.00, '2025-01-06'),
(4, 4, 4, 1850.00, '2025-01-08'),
(5, 5, 5, 2250.00, '2025-01-10'),
(6, 6, 6, 1450.00, '2025-01-12'),
(7, 7, 1, 2550.00, '2025-01-14'),
(8, 8, 2, 1750.00, '2025-01-16'),
(9, 9, 3, 1650.00, '2025-01-18'),
(10, 10, 4, 1950.00, '2025-01-20'),
(11, 1, 5, 2150.00, '2025-02-01'),
(12, 2, 6, 1350.00, '2025-02-03'),
(13, 3, 1, 2050.00, '2025-02-05'),
(14, 4, 2, 1850.00, '2025-02-07'),
(15, 5, 3, 1550.00, '2025-02-09'),
(16, 6, 4, 2250.00, '2025-02-11'),
(17, 7, 5, 1750.00, '2025-02-13'),
(18, 8, 6, 1650.00, '2025-02-15'),
(19, 9, 1, 2550.00, '2025-02-17'),
(20, 10, 2, 1850.00, '2025-02-19'),
(21, 1, 3, 1450.00, '2025-03-02'),
(22, 2, 4, 1950.00, '2025-03-05'),
(23, 3, 5, 2150.00, '2025-03-08'),
(24, 4, 6, 1700.00, '2025-03-11'),
(25, 5, 1, 1600.00, '2025-03-14'),
(26, 6, 2, 2050.00, '2025-03-17'),
(27, 7, 3, 2250.00, '2025-03-20'),
(28, 8, 4, 1350.00, '2025-03-23'),
(29, 9, 5, 2550.00, '2025-03-26'),
(30, 10, 6, 1850.00, '2025-03-29'),
(31, 1, 1, 2150.00, '2025-04-02'),
(32, 2, 2, 1750.00, '2025-04-05'),
(33, 3, 3, 1650.00, '2025-04-08'),
(34, 4, 4, 1950.00, '2025-04-11'),
(35, 5, 5, 2050.00, '2025-04-14'),
(36, 6, 6, 2250.00, '2025-04-17'),
(37, 7, 1, 2350.00, '2025-04-20'),
(38, 8, 2, 1800.00, '2025-04-23'),
(39, 9, 3, 1700.00, '2025-04-26'),
(40, 10, 4, 2000.00, '2025-04-29'),
(41, 1, 5, 2200.00, '2025-05-03'),
(42, 2, 6, 1650.00, '2025-05-07'),
(43, 3, 1, 2250.00, '2025-05-11'),
(44, 4, 2, 1800.00, '2025-05-15'),
(45, 5, 3, 1900.00, '2025-05-19'),
(46, 6, 4, 2000.00, '2025-05-23'),
(47, 7, 5, 2400.00, '2025-05-27'),
(48, 8, 6, 2450.00, '2025-05-31'),
(49, 9, 1, 2600.00, '2025-06-04'),
(50, 10, 2, 2050.00, '2025-06-08'),
(51, 1, 3, 1550.00, '2025-06-12'),
(52, 2, 4, 1850.00, '2025-06-16'),
(53, 3, 5, 1950.00, '2025-06-20'),
(54, 4, 6, 1900.00, '2025-06-24'),
(55, 5, 1, 2000.00, '2025-07-01'),
(56, 6, 2, 2100.00, '2025-07-05'),
(57, 7, 3, 2200.00, '2025-07-09'),
(58, 8, 4, 2300.00, '2025-07-13'),
(59, 9, 5, 2350.00, '2025-07-17'),
(60, 10, 6, 2450.00, '2025-08-01');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    CategoryID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, CategoryID, ProductName, Price) VALUES
(1, 1, 'Laptop', 1000.00),
(2, 1, 'Smartphone', 800.00),
(3, 2, 'Tablet', 500.00),
(4, 2, 'Monitor', 300.00),
(5, 3, 'Headphones', 150.00),
(6, 3, 'Mouse', 25.00),
(7, 4, 'Keyboard', 50.00),
(8, 4, 'Speaker', 200.00),
(9, 5, 'Smartwatch', 250.00),
(10, 5, 'Camera', 700.00);


--Create a numbers table using a recursive query from 1 to 1000.
WITH cte as(
    SELECT 1 as num 
    UNION ALL
    SELECT num+1 as num from cte
    where num<1000
)
SELECT * from cte
OPTION (maxrecursion 1000)

--Write a query to find the total sales per employee using a derived table.(Sales, Employees)
SELECT e.FirstName, s.JamiSotuvlar
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS JamiSotuvlar
    FROM Sales
    GROUP BY EmployeeID
) AS s
    ON e.EmployeeID = s.EmployeeID;

--Create a CTE to find the average salary of employees.(Employees)
WITH cte as (
SELECT  AVG(salary) as avg from Employees )
SELECT * from cte;


--Write a query using a derived table to find the highest sales for each product.(Sales, Products)
WITH cte as (
SELECT Productid, MAX(SalesAmount) as max_amount from Sales GROUP BY Productid )
SELECT Products.ProductName, cte.max_amount from cte JOIN Products on cte.ProductID = Products.ProductID
SELECT * from Sales;

--Beginning at 1, write a statement to double the number for each record, the max value you get should be less than 1000000.
WITH cte AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2 AS num
    FROM cte
    WHERE num * 2 < 10000
)
SELECT *
FROM cte
OPTION (MAXRECURSION 10000);

--Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
WITH cte as(
SELECT EmployeeID, COUNT(SalesID) as count from Sales GROUP BY EmployeeID)
SELECT Employees.FirstName, cte.[count] from cte join Employees on cte.EmployeeID = Employees.EmployeeID where cte.[count] > 5

--Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
WITH cte as (
SELECT Productid, SUM(SalesAmount) as sum from Sales GROUP by Productid)
SELECT Products.ProductName, cte.[sum] from cte join Products on cte.ProductID = Products.ProductID where cte.[sum] > 500

--Create a CTE to find employees with salaries above the average salary.(Employees)
WITH cte as(
SELECT AVG(Salary) as avg from Employees)
SELECT * from Employees where Salary > (select avg from cte)

--Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
WITH cte as(
SELECT  EmployeeID, COUNT(SalesID) as COUNT from Sales GROUP BY  EmployeeID)
SELECT top 5 Employees.FirstName, cte.[COUNT] from cte join Employees on cte.EmployeeID = Employees.EmployeeID ORDER BY cte.[COUNT] DESC

--Write a query using a derived table to find the sales per product category.(Sales, Products)
WITH cte AS (
    SELECT 
        p.CategoryID,
        SUM(s.SalesAmount) AS total_sales
    FROM Sales s
    JOIN Products p 
        ON s.ProductID = p.ProductID
    GROUP BY p.CategoryID
)
SELECT 
    p.ProductName,
    cte.total_sales
FROM cte
JOIN Products p
    ON cte.CategoryID = p.CategoryID;

--This script uses recursion to split a string into rows of substrings for each character in the string.(Example)

WITH SplitCTE AS (
    SELECT 
        Id,
        CAST(SUBSTRING(String, 1, 1) AS VARCHAR(1)) AS Ch, 
        SUBSTRING(String, 2, LEN(String)) AS Remainder      
    FROM Example

    UNION ALL

    SELECT 
        Id,
        CAST(SUBSTRING(Remainder, 1, 1) AS VARCHAR(1)) AS Ch,
        SUBSTRING(Remainder, 2, LEN(Remainder)) AS Remainder
    FROM SplitCTE
    WHERE LEN(Remainder) > 0
)
SELECT Id, Ch
FROM SplitCTE
ORDER BY Id
OPTION (MAXRECURSION 0);

--Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS SalesYear,
        MONTH(SaleDate) AS SalesMonth,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
DiffCTE AS (
    SELECT 
        SalesYear,
        SalesMonth,
        TotalSales,
        TotalSales - LAG(TotalSales) OVER (ORDER BY SalesYear, SalesMonth) AS SalesDiff
    FROM MonthlySales
)
SELECT * 
FROM DiffCTE;

--Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)
WITH cte as(
SELECT EmployeeID, DATEPART(QUARTER, Sales.SaleDate) as QUARTERNUM, SUM(Sales.SalesAmount) as SUM_AMOUNT from Sales GROUP BY EmployeeID, DATEPART(QUARTER, Sales.SaleDate) HAVING SUM(Sales.SalesAmount) > 45000)
SELECT Employees.FirstName, cte.QUARTERNUM, cte.SUM_AMOUNT from cte join Employees on cte.EmployeeID = Employees.EmployeeID

--Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
WITH cte as(
SELECT EmployeeID, COUNT(Sales.SalesID) total_count from Sales where SaleDate>= DATEADD(MONTH, -6, GETDATE()) GROUP BY EmployeeID)
SELECT  Employees.FirstName, cte.total_count from cte join Employees on cte.EmployeeID = Employees.EmployeeID ORDER by cte.total_count desc
SELECT * from Sales
SELECT * from Products
