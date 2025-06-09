CREATE DATABASE work2
USE work2

--Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).
CREATE table Employees (EmpID INT, Ism VARCHAR(50),  Salary decimal (10,2))

--Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees (EmpID, Ism, Salary)
VALUES 
(1, 'Aziz', 700000),
(2, 'Bobir', 900000),
(3, 'Bsbir', 300000);

--Update the Salary of an employee to 7000 where EmpID = 1.
UPDATE Employees
SET Salary = 7000
where EmpID = 1

--Delete a record from the Employees table where EmpID = 2.
DELETE from Employees
where EmpID = 2

--Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
--Delete
Jadvaldagi muayyan qatorlarni o‘chiradi.
--TRUNCATE
 Hamma qatorlarni o‘chiradi (tezroq ishlaydi).
--DROP
Butun jadvalni butunlay o‘chiradi (strukturasi ham ketadi).
--Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN ism VARCHAR(100);

--Add a new column Department (VARCHAR(50)) to the Employees table
ALTER TABLE Employees
ADD Department VARCHAR(50);

--Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT

--Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE table Departments (DepartmentID INT PRIMARY KEY, Department_Name VARCHAR(50)) ;

--Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees

--Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
CREATE  table Departmants (DeptID int, DeptName VARCHAR(50), Manager VARCHAR(50), Salary int); 

INSERT INTO Departmants (DeptID, DeptName, Manager, Salary)
SELECT 1, 'Buxgalteriya', 'Aliyev', 70000
UNION ALL
SELECT 2, 'IT bo‘limi', 'Karimova', 30000
UNION ALL
SELECT 3, 'Marketing', 'Sobirov', 90000
UNION ALL
SELECT 4, 'Sotuv', 'Islomov', 60000
UNION ALL
SELECT 5, 'Kadrlar bo‘limi', 'Jorayev', 8000;

--Update the Department of all employees where Salary > 5000 to 'Management'.
 UPDATE Departmants
 set Manager = 'Management'
 WHERE Salary > 5000

--Write a query that removes all employees but keeps the table structure intact.
TRUNCATE TABLE Departmants;

--Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department;
SELECT * from Employees

--Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers', 'COLUMN';

--Write a query to completely remove the Departments table from the database.
DROP TABLE Departments;

--Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category
create table Products ( ProductID int Primary Key, ProductName VARCHAR(50),Category VARCHAR(50), StockQuantity INT, CreatedDate DATE)

 SELECT * from Products
 --Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive
CHECK (Price > 0);

--Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

 Rename Category column to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';
 Insert 5 records into the Products table
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, StockQuantity, CreatedDate)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 30, '2025-06-01'),
(2, 'Headphones', 'Electronics', 150.50, 100, '2025-06-01'),
(3, 'Chair', 'Furniture', 85.75, 45, '2025-06-01'),
(4, 'Notebook', 'Stationery', 2.50, 500, '2025-06-01'),
(5, 'Desk Lamp', 'Lighting', 25.00, 60, '2025-06-01');
 Create a backup table Products_Backup using SELECT INTO
SELECT * INTO Products_Backup
FROM Products;
 Rename the Products table to Inventory
EXEC sp_rename 'Products', 'Inventory';
 Change the data type of Price from DECIMAL(10,2) to FLOAT
Note: You must drop and re-add the column to change the type in some cases, or use ALTER COLUMN if supported.
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;
 Add an IDENTITY column ProductCode starting at 1000, incrementing by 5
Note: SQL Server does not allow adding IDENTITY to an existing column directly. So, you need to recreate the table or use a workaround like creating a new table with IDENTITY.
Here’s how to do it by creating a new table:

-- Create new table with IDENTITY column
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    StockQuantity INT,
    CreatedDate DATE
);

-- Copy data from old table
INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, StockQuantity, CreatedDate)
SELECT ProductID, ProductName, ProductCategory, Price, StockQuantity, CreatedDate
FROM Inventory;

-- Drop old table
DROP TABLE Inventory;

-- Rename new table back to Inventory
EXEC sp_rename 'Inventory_New', 'Inventory';
