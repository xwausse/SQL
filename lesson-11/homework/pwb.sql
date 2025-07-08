
 Orders after 2022 with customer names
Return: OrderID, CustomerName, OrderDate
Tables: Orders, Customers
SELECT 
    o.OrderID, 
    c.FirstName + ' ' + c.LastName AS CustomerName, 
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31';
 Employees in Sales or Marketing
Return: EmployeeName, DepartmentName
Tables: Employees, Departments
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeName, 
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');
 Max salary per department
Return: DepartmentName, MaxSalary
Tables: Departments, Employees
SELECT 
    d.DepartmentName, 
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;
 Customers from USA who placed orders in 2023
Return: CustomerName, OrderID, OrderDate
Tables: Customers, Orders
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA' AND YEAR(o.OrderDate) = 2023;
 Total orders per customer
Return: CustomerName, TotalOrders
Tables: Orders, Customers
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
 Products supplied by specific suppliers
Return: ProductName, SupplierName
Tables: Products, Suppliers
SELECT 
    p.ProductName, 
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');
 Most recent order per customer (including those with none)
Return: CustomerName, MostRecentOrderDate
Tables: Customers, Orders
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;




 Customers with orders over 500
Return: CustomerName, OrderTotal
Tables: Orders, Customers
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;
 Sales in 2022 or over 400
Return: ProductName, SaleDate, SaleAmount
Tables: Products, Sales
SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;
 Total sales amount per product
Return: ProductName, TotalSalesAmount
Tables: Sales, Products
SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;
 HR employees with salary > 60000
Return: EmployeeName, DepartmentName, Salary
Tables: Employees, Departments
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR' AND e.Salary > 60000;
 Products sold in 2023 with stock > 100
Return: ProductName, SaleDate, StockQuantity
Tables: Products, Sales
SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;
 Employees in Sales OR hired after 2020
Return: EmployeeName, DepartmentName, HireDate
Tables: Employees, Departments
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR e.HireDate > '2020-12-31';



 Orders by USA customers with address starting with 4 digits
Return: CustomerName, OrderID, Address, OrderDate
Tables: Customers, Orders
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';
LIKE '[0-9][0-9][0-9][0-9]%' — SQL Server’da ishlaydi, 4 raqam bilan boshlanuvchi addresslar uchun.
 Product sales for Electronics or SaleAmount > 350
Return: ProductName, Category, SaleAmount
Tables: Products, Sales
SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;
 Product count per category
Return: CategoryName, ProductCount
Tables: Products, Categories
SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;
 Orders from Los Angeles > 300
Return: CustomerName, City, OrderID, Amount
Tables: Customers, Orders
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;
 Employees in HR or Finance or with ≥4 vowels in name
Return: EmployeeName, DepartmentName
Tables: Employees, Departments
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE 
    d.DepartmentName IN ('HR', 'Finance')
    OR LEN(e.FirstName + e.LastName) 
       - LEN(REPLACE(LOWER(e.FirstName + e.LastName), 'a', ''))
       - LEN(REPLACE(LOWER(e.FirstName + e.LastName), 'e', ''))
       - LEN(REPLACE(LOWER(e.FirstName + e.LastName), 'i', ''))
       - LEN(REPLACE(LOWER(e.FirstName + e.LastName), 'o', ''))
       - LEN(REPLACE(LOWER(e.FirstName + e.LastName), 'u', '')) <= -4;
Ushbu usul SQL Server uchun mos va ism ichidagi unli harflarni hisoblab beradi.
 Employees in Sales or Marketing with salary > 60000
Return: EmployeeName, DepartmentName, Salary
Tables: Employees, Departments
SELECT 
    e.FirstName + ' ' + e.LastName AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 60000;
