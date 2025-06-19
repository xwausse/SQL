 Select top 5 employees from the Employees table:
SELECT TOP 5 * 
FROM Employees;
 Select unique Category values from the Products table:
SELECT DISTINCT Category 
FROM Products;
 Filter Products where Price > 100:
SELECT * 
FROM Products
WHERE Price > 100;
 Select all Customers whose FirstName starts with 'A':
SELECT * 
FROM Customers
WHERE FirstName LIKE 'A%';
 Order Products table by Price in ascending order:
SELECT * 
FROM Products
ORDER BY Price ASC;
 Filter Employees with Salary ≥ 60000 and Department = 'HR':
SELECT * 
FROM Employees
WHERE Salary >= 60000 AND Department = 'HR';
 Use ISNULL on Email column in Employees table:
SELECT EmpID, Name, ISNULL(Email, 'noemail@example.com') AS Email 
FROM Employees;
 Show all Products with Price BETWEEN 50 AND 100:
SELECT * 
FROM Products
WHERE Price BETWEEN 50 AND 100;
 SELECT DISTINCT on two columns: Category and ProductName:
SELECT DISTINCT Category, ProductName 
FROM Products;
 SELECT DISTINCT on two columns and order by ProductName DESC:
SELECT DISTINCT Category, ProductName 
FROM Products
ORDER BY ProductName DESC;м

 Top 10 products from Products table ordered by Price descending:
SELECT TOP 10 * 
FROM Products
ORDER BY Price DESC;
 Use COALESCE to return first non-NULL value from FirstName or LastName:
SELECT EmployeeID, COALESCE(FirstName, LastName) AS Name
FROM Employees;
 Select distinct Category and Price from Products:
SELECT DISTINCT Category, Price 
FROM Products;
 Filter Employees where Age is between 30 and 40 OR Department = 'Marketing':
SELECT * 
FROM Employees
WHERE (Age BETWEEN 30 AND 40) OR Department = 'Marketing';
 Use OFFSET-FETCH to get rows 11 to 20 from Employees, ordered by Salary DESC:
SELECT * 
FROM Employees
ORDER BY Salary DESC
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
 Display all products with Price ≤ 1000 and Stock > 50, sorted by Stock ASC:
SELECT * 
FROM Products
WHERE Price <= 1000 AND Stock > 50
ORDER BY Stock ASC;
 Filter Products where ProductName contains letter 'e':
SELECT * 
FROM Products
WHERE ProductName LIKE '%e%';
 Filter Employees who work in 'HR', 'IT', or 'Finance':
SELECT * 
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');
 Order Customers by City (ASC) and PostalCode (DESC):
SELECT * 
FROM Customers
ORDER BY City ASC, PostalCode DESC;


 Top 5 products with the highest sales (ordered by SalesAmount DESC):
SELECT TOP(5) * 
FROM Products
ORDER BY SalesAmount DESC;
 Combine FirstName and LastName into FullName in the Employees table:
SELECT EmployeeID, FirstName + ' ' + LastName AS FullName, Department
FROM Employees;
 Select distinct Category, ProductName, and Price for products priced above $50:
SELECT DISTINCT Category, ProductName, Price 
FROM Products
WHERE Price > 50;
 Select products where Price < 10% of average Price in Products table:
SELECT * 
FROM Products
WHERE Price < (SELECT AVG(Price) * 0.10 FROM Products);
 Employees whose Age < 30 and Department is 'HR' or 'IT':
SELECT * 
FROM Employees
WHERE Age < 30 AND Department IN ('HR', 'IT');
 Customers whose Email contains @gmail.com:
SELECT * 
FROM Customers
WHERE Email LIKE '%@gmail.com%';
 Employees whose Salary > ALL salaries in the 'Sales' department:
SELECT * 
FROM Employees
WHERE Salary > ALL (
    SELECT Salary FROM Employees WHERE Department = 'Sales'
);
 Orders placed in the last 180 days using BETWEEN and GETDATE():
SELECT * 
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
 GETDATE() returns the current system date in SQL Server.
 DATEADD(DAY, -180, GETDATE()) calculates the date 180 days ago.
