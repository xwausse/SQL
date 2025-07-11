--Using Products, Suppliers table List all combinations of product names and supplier names.
SELECT Products.ProductName, Suppliers.ContactName from Products cross join Suppliers

--Using Departments, Employees table Get all combinations of departments and employees.
SELECT Departments.DepartmentName, Employees.Name from Departments cross join Employees

--Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. Return supplier name and product name
SELECT Products.ProductName, Suppliers.SupplierName from Products join Suppliers on Products.ProductID = Suppliers.SupplierID
SELECT 
    s.SupplierName,
    p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID;

--Using Orders, Customers table List customer names and their orders ID.
SELECT Customers.FirstName, Orders.OrderID from Customers join Orders on Customers.CustomerID = Orders.CustomerID

--Using Courses, Students table Get all combinations of students and courses.
SELECT Students.Name, Courses.CourseName from Students cross join Courses

--Using Products, Orders table Get product names and orders where product IDs match.
SELECT Products.ProductName, Orders.OrderID from Products join Orders on Products.ProductID = Orders.ProductID

--Using Departments, Employees table List employees whose DepartmentID matches the department.
SELECT Employees.Name, Departments.DepartmentID from Employees join Departments on Employees.DepartmentID = Departments.DepartmentID

--Using Students, Enrollments table List student names and their enrolled course IDs.
SELECT Students.Name, Enrollments.CourseID from Students join Enrollments on Students.StudentID = Enrollments.StudentID

--Using Payments, Orders table List all orders that have matching payments.
SELECT Orders.OrderID, Payments.PaymentID from Orders join Payments on Orders.OrderID = Payments.OrderID

--Using Orders, Products table Show orders where product price is more than 100.
select Products.ProductName, Orders.ProductID, Products.Price from Products join Orders on Products.ProductID = Orders.ProductID where Price > 100

--Using Employees, Departments table List employee names and department names where department IDs are not equal. It means: Show all mismatched employee-department combinations.
SELECT Employees.Name, Departments.DepartmentName from Employees join Departments on Employees.Name <> Departments.DepartmentName

--Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.
SELECT Orders.Quantity, Products.StockQuantity from Orders join Products on Orders.Quantity > Products.StockQuantity

--Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.
SELECT Customers.FirstName, Sales.ProductID, Sales.SaleAmount from Customers join Sales on Customers.CustomerID = Sales.CustomerID WHERE Sales.SaleAmount >= 500


--Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.
SELECT Students.Name, Courses.CourseName from Enrollments join Students on Enrollments.StudentID = Students.StudentID join Courses on Enrollments.CourseID = Courses.CourseID
SELECT 
    Students.Name,
    Courses.CourseName
FROM 
    Enrollments
JOIN 
    Students ON Enrollments.StudentID = Students.StudentID
JOIN 
    Courses ON Enrollments.CourseID = Courses.CourseID;

--Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.
SELECT Suppliers.SupplierName, Products.ProductName from Suppliers join Products on Suppliers.SupplierID = Products.SupplierID where Suppliers.SupplierName like '%tech%'

--Using Orders, Payments table Show orders where payment amount is less than total amount.
SELECT Orders.OrderID, Orders.TotalAmount, Payments.Amount from Orders join Payments on Orders.TotalAmount > Payments.Amount

--Using Employees and Departments tables, get the Department Name for each employee.
SELECT Employees.Name, Departments.DepartmentName from Departments join Employees on Departments.DepartmentID = Employees.DepartmentID

--Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.
SELECT Products.ProductName, Categories.CategoryName from Products join Categories on Products.Category = Categories.CategoryID where Categories.CategoryName IN ('Electronics', 'Furniture');

--Using Sales, Customers table Show all sales from customers who are from 'USA'.
SELECT Sales.CustomerID, Customers.Country, Sales.SaleAmount from Sales join Customers on Sales.CustomerID = Customers.CustomerID where Customers.Country IN ('USA')

--Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.
SELECT Orders.OrderID, Customers.FirstName, Customers.Country, Orders.TotalAmount from Customers join Orders on Customers.CustomerID = Orders.CustomerID where Customers.Country = 'Germany' and Orders.TotalAmount > 100

--Using Employees table List all pairs of employees from different departments.
SELECT * from Orders
SELECT * from Employees
SELECT 
    A.Name AS Employee1,
    B.Name AS Employee2
FROM 
    Employees A
JOIN 
    Employees B ON A.DepartmentID <> B.DepartmentID;
    SELECT 
    A.Name AS Employee1,
    B.Name AS Employee2
FROM 
    Employees A
JOIN 
    Employees B ON A.DepartmentID <> B.DepartmentID
              AND A.EmployeeID < B.EmployeeID;

--Using Payments, Orders, Products table List payment details where the paid amount is not equal to (Quantity × Product Price).
SELECT Payments.Amount, Orders.Quantity, Products.Price from Payments join Orders on Orders.OrderID = Payments.OrderID join Products on Products.ProductID = Orders.ProductID
where Payments.Amount <> Orders.Quantity * Products.Price

--Using Students, Enrollments, Courses table Find students who are not enrolled in any course.
SELECT Students.Name, Courses.CourseName from Students full join Enrollments on Students.StudentID = Enrollments.StudentID full join Courses on Courses.CourseID = Enrollments.CourseID where Courses.CourseName is null

--Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it.
SELECT Orders.OrderID, Customers.FirstName, Customers.CustomerID from Orders FULL JOIN Payments on Orders.OrderID = Payments.OrderID FULL JOIN Customers on Customers.CustomerID = Orders.CustomerID where Payments.OrderID is null
