

1. Define and explain the purpose of BULK INSERT in SQL Server:
BULK INSERT SQL Serverda tashqi fayllardan (odatda .txt, .csv va hokazo) katta hajmdagi ma'lumotlarni jadvalga tez va samarali tarzda yuklash uchun ishlatiladi.

2. List four file formats that can be imported into SQL Server:

CSV (.csv)
Text (.txt)
XML (.xml)
JSON (.json)
3. Create a table Products:

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
4. Insert three records:

INSERT INTO Products VALUES (1, 'Laptop', 1200.00);
INSERT INTO Products VALUES (2, 'Mouse', 25.50);
INSERT INTO Products VALUES (3, 'Keyboard', 45.99);
5. Difference between NULL and NOT NULL:

NULL – qiymat kiritilmagan (noma'lum).
NOT NULL – ustunga har doim qiymat kiritilishi shart.
6. Add UNIQUE constraint to ProductName:

ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
7. SQL comment example:

-- Ushbu so‘rov Products jadvalidan barcha mahsulotlarni chiqaradi
SELECT * FROM Products;
8. Add CategoryID column:

ALTER TABLE Products
ADD CategoryID INT;
9. Create Categories table:

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
10. Purpose of IDENTITY column:
IDENTITY ustuni avtomatik raqamlanishni ta'minlaydi. Har yangi yozuv qo‘shilganda qiymat avtomatik oshadi.

1. Use BULK INSERT:

BULK INSERT Products
FROM 'C:\Data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
2. Create FOREIGN KEY in Products:

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
3. Differences between PRIMARY KEY and UNIQUE KEY:

PRIMARY KEY – yagona bo‘ladi va NOT NULL bo‘lishi shart.
UNIQUE – bir nechta bo‘lishi mumkin, lekin NULL qabul qilishi mumkin.
4. Add CHECK constraint (Price > 0):

ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);
5. Add Stock column:

ALTER TABLE Products
ADD Stock INT NOT NULL;
6. Use ISNULL for Price:

SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
7. FOREIGN KEY constraints – purpose:
FOREIGN KEY boshqa jadvalga bog‘lanishni ta'minlaydi, ma'lumotlar yaxlitligini saqlaydi (integrity).

1. Customers table with CHECK constraint:

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);
2. Table with IDENTITY (100, 10):

CREATE TABLE SerialNumbers (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    Code VARCHAR(20)
);
3. Composite PRIMARY KEY in OrderDetails:

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
4. COALESCE vs ISNULL:

ISNULL(expr, replacement) – faqat 2 ta qiymat uchun.
COALESCE(expr1, expr2, ...) – birinchi NOT NULL qiymatni qaytaradi, ko‘proq moslashuvchan.
5. Employees table with PRIMARY and UNIQUE:

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);
6. FOREIGN KEY with CASCADE:

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories_Cascade
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;
