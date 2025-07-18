Rename ProductName column as Name in Products table
SELECT ProductName AS Name
FROM Products;
 Rename Customers table as Client for easier reference
SELECT Client.FirstName, Client.LastName
FROM Customers AS Client;
 Use UNION to combine ProductName from Products and Products_Discounted
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
UNION removes duplicates. If you want duplicates, use UNION ALL.
 Find intersection (common rows) using INTERSECT
SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;
 Select distinct customer names and their Country
SELECT DISTINCT FirstName + ' ' + LastName AS CustomerName, Country
FROM Customers;
 Use CASE to create a conditional column for Price
SELECT ProductName, Price,
       CASE 
         WHEN Price > 1000 THEN 'High'
         ELSE 'Low'
       END AS PriceCategory
FROM Products;
 Use IIF to show 'Yes' if Stock > 100, otherwise 'No' (Products_Discounted)
SELECT ProductName, StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStock
FROM Products_Discounted;





 UNION: Combine ProductName from Products and Products_Discounted
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
UNION returns distinct product names across both tables.
 EXCEPT: Find products in Products but not in Products_Discounted
SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;
 Conditional column using IIF for expensive vs affordable
SELECT ProductName, Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;
 Employees with Age < 25 or Salary > 60000
Assuming Employees table has an Age column:
SELECT * 
FROM Employees
WHERE Age < 25 OR Salary > 60000;
 Update salary: +10% if department is 'HR' or EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentID IN (
    SELECT DepartmentID FROM Departments WHERE DepartmentName = 'HR'
)
OR EmployeeID = 5;




 CASE to assign 'Top Tier', 'Mid Tier', 'Low Tier' (from Sales table)
SELECT 
    SaleID,
    SaleAmount,
    CASE
        WHEN SaleAmount > 500 THEN 'Top Tier'
        WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS Tier
FROM Sales;
 Use EXCEPT to find customers who placed orders but are not in Sales table
Assuming both Orders and Sales tables have a CustomerID column:
SELECT CustomerID FROM Orders
EXCEPT
SELECT CustomerID FROM Sales;
 CASE for discount % by quantity (Orders table)
SELECT 
    CustomerID, 
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
