1. Find the Minimum Price in the Products table
SELECT MIN(Price) AS MinPrice
FROM Products;
 2. Find the Maximum Salary in the Employees table
SELECT MAX(Salary) AS MaxSalary
FROM Employees;
 3. Count the Number of Rows in the Customers table
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
 4. Count the Number of Unique Product Categories in Products
SELECT COUNT(DISTINCT ProductCategory) AS UniqueCategories
FROM Products;
 5. Total Sales Amount for Product with ID = 7 in Sales table
(Assumes columns like ProductID and Amount exist)
SELECT SUM(Amount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;
 6. Average Age of Employees in the Employees table
SELECT AVG(Age) AS AverageAge
FROM Employees;
 7. Count of Employees in Each Department
(Assumes a column like DeptID)
SELECT DeptID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;
 8. Min and Max Price of Products Grouped by Category
SELECT ProductCategory, 
       MIN(Price) AS MinPrice, 
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY ProductCategory;
 9. Total Sales per Customer in the Sales table
(Assumes a column like CustomerID and Amount)
SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID;
 10. Departments with More Than 5 Employees
SELECT DeptID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 5;


1. Total and Average Sales per Product Category (Sales + Products Tables)
SELECT 
    P.ProductCategory,
    SUM(S.Amount) AS TotalSales,
    AVG(S.Amount) AS AvgSales
FROM 
    Sales S
JOIN 
    Products P ON S.ProductID = P.ProductID
GROUP BY 
    P.ProductCategory;
2. Count Employees from Department 'HR'
SELECT 
    COUNT(*) AS HR_Employee_Count
FROM 
    Employees
WHERE 
    Department = 'HR';
3. Highest and Lowest Salary by Department
SELECT 
    DeptID,
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM 
    Employees
GROUP BY 
    DeptID;
4. Average Salary per Department
SELECT 
    DeptID,
    AVG(Salary) AS AverageSalary
FROM 
    Employees
GROUP BY 
    DeptID;
5. Average Salary and Employee Count per Department
SELECT 
    DeptID,
    AVG(Salary) AS AvgSalary,
    COUNT(*) AS EmployeeCount
FROM 
    Employees
GROUP BY 
    DeptID;
6. Filter Product Categories with Average Price > 400
SELECT 
    ProductCategory,
    AVG(Price) AS AvgPrice
FROM 
    Products
GROUP BY 
    ProductCategory
HAVING 
    AVG(Price) > 400;
7. Total Sales per Year
SELECT 
    YEAR(SaleDate) AS SaleYear,
    SUM(Amount) AS TotalSales
FROM 
    Sales
GROUP BY 
    YEAR(SaleDate);
8. Customers Who Placed at Least 3 Orders
SELECT 
    CustomerID,
    COUNT(*) AS OrderCount
FROM 
    Sales
GROUP BY 
    CustomerID
HAVING 
    COUNT(*) >= 3;
9. Departments with Average Salary Greater Than 60000
SELECT 
    DeptID,
    AVG(Salary) AS AvgSalary
FROM 
    Employees
GROUP BY 
    DeptID
HAVING 
    AVG(Salary) > 60000;


    -- 1. Average price per category (only > 150)
SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

-- 2. Total sales per customer > 1500
SELECT CustomerID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

-- 3. Total and average salary per department (avg > 65000)
SELECT DepartmentName, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

-- 4. Total amount for orders with freight > $50 and least purchase per customer (TSQL2012.sales.orders required)
-- NOTE: This query assumes columns [Freight], [OrderAmount] exist in [TSQL2012].[Sales].[Orders] table
SELECT CustomerID,
       SUM(CASE WHEN Freight > 50 THEN OrderAmount ELSE 0 END) AS TotalHighFreightAmount,
       MIN(OrderAmount) AS LeastPurchaseAmount
FROM TSQL2012.Sales.Orders
GROUP BY CustomerID;

-- 5. Total sales and unique products sold per month-year, filtering for 2+ products
SELECT
    YEAR(OrderDate) AS OrderYear,
    MONTH(OrderDate) AS OrderMonth,
    SUM(TotalAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProducts
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;

-- 6. Min and Max order quantity per year
SELECT
    YEAR(OrderDate) AS OrderYear,
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
