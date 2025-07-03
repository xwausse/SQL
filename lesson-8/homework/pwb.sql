Eng kichik (MIN) narxni topish (Products jadvalidan):
SELECT MIN(Price) AS MinPrice
FROM Products;
 Eng katta (MAX) maoshni topish (Employees jadvalidan):
SELECT MAX(Salary) AS MaxSalary
FROM Employees;
 Customers jadvalidagi jami qatorlar sonini sanash:
SELECT COUNT(*) AS TotalCustomers
FROM Customers;
 Products jadvalidagi unikal Category lar sonini sanash:
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;
 Sales jadvalidan ID-si 7 bo‘lgan mahsulot uchun umumiy sotuv summasini hisoblash:
SELECT SUM(SaleAmount) AS TotalSalesForProduct7
FROM Sales
WHERE ProductID = 7;
 Employees jadvalidan o‘rtacha yoshni hisoblash:
SELECT AVG(Age) AS AverageAge
FROM Employees;
 Har bir bo‘limdagi xodimlar sonini sanash (Employees jadvalidan):
SELECT Department, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Department;
 Har bir toifadagi (Category) mahsulotlar uchun eng kichik va eng katta narxni topish:
SELECT Category,
       MIN(Price) AS MinPrice,
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;
 Har bir mijoz uchun umumiy sotuv summasini hisoblash (Sales jadvalidan):
SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;
 Har bir bo‘limdan 5 dan ortiq xodim ishlayotgan bo‘limlarni topish (Employees jadvalidan):
SELECT DeptID
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 5;



 --Each product category uchun umumiy (SUM) va o‘rtacha (AVG) sotuv (Sales jadvalidan):
SELECT Category,
       SUM(SaleAmount) AS TotalSales,
       AVG(SaleAmount) AS AverageSales
FROM Sales
GROUP BY Category;
--Eslatma: Bu yerda Category ustuni Sales jadvalida mavjud bo‘lishi kerak yoki JOIN orqali olinishi kerak.
 HR bo‘limida ishlovchi xodimlar sonini sanash:
SELECT COUNT(*) AS HR_EmployeeCount
FROM Employees
WHERE Department = 'HR';
 --Har bir bo‘lim (DeptID) uchun eng yuqori va eng past maosh:
SELECT DeptID,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DeptID;
 --Bo‘lim (DeptID) bo‘yicha o‘rtacha maosh:
SELECT DeptID,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID;
 --Har bir bo‘lim uchun o‘rtacha maosh va xodimlar soni:
SELECT DeptID,
       AVG(Salary) AS AvgSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;
 --Products jadvalidan o‘rtacha narxi 400 dan yuqori bo‘lgan toifalarni tanlash:
SELECT Category
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;
 --Har bir yil uchun umumiy sotuv (Sales jadvalidan):
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);
Eslatma: SaleDate ustuni DATE yoki DATETIME tipida bo‘lishi kerak.
-- Kamida 3 ta buyurtma bergan mijozlar ro‘yxati:
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;
 --Bo‘limlardagi o‘rtacha maosh 60000 dan katta bo‘lganlarini chiqarish:
SELECT DeptID
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 60000;



--Har bir mahsulot toifasi uchun o‘rtacha narx va 150 dan kattalarni filtrlash (Products):
SELECT Category,
       AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;
-- Har bir mijoz uchun umumiy sotuv, va 1500 dan oshganlarini filtrlash (Sales):
SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;
--Har bir bo‘lim uchun jami va o‘rtacha maosh, va o‘rtachasi 65000 dan katta bo‘lsa chiqarish (Employees):
SELECT DeptID,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 65000;
-- TSQL2012.sales.orders jadvalidan:
$50 dan katta bo‘lgan yuk (freight) uchun buyurtmalar summasi va mijozning eng kam xarid summasi:
SELECT CustomerID,
       SUM(Freight) AS TotalFreightOver50,
       MIN(Freight) AS LeastFreight
FROM tsql2012.sales.orders
WHERE Freight > 50
GROUP BY CustomerID;
Eslatma: Agar eng kam xarid barcha xaridlar ichida kerak bo‘lsa (nafaqat >50), unda MIN(Freight) ustunida WHERE qo‘llanilmaydi:
SELECT CustomerID,
       SUM(CASE WHEN Freight > 50 THEN Freight ELSE 0 END) AS TotalFreightOver50,
       MIN(Freight) AS LeastFreight
FROM tsql2012.sales.orders
GROUP BY CustomerID;
--Har yil va oy bo‘yicha jami sotuv va noyob mahsulotlar soni, faqat 2 yoki undan ko‘p mahsulot bo‘lgan oylar (Orders, OrderDetails):
SELECT 
    YEAR(OrderDate) AS SaleYear,
    MONTH(OrderDate) AS SaleMonth,
    SUM(SaleAmount) AS TotalSales,
    COUNT(DISTINCT ProductID) AS UniqueProductsSold
FROM Sales
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
HAVING COUNT(DISTINCT ProductID) >= 2;
Agar Sales jadvalidan foydalanilmasa, Orders bilan OrderDetails jadvali JOIN qilinadi.
--Yil bo‘yicha minimal va maksimal buyurtma soni (Orders):
SELECT 
    YEAR(OrderDate) AS OrderYear,
    MIN(Quantity) AS MinQuantity,
    MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate);
Eslatma: Agar Quantity ustuni boshqa jadvalda (OrderDetails) bo‘lsa, Orders bilan OrderDetails ni JOIN qilish kerak:
SELECT 
    YEAR(o.OrderDate) AS OrderYear,
    MIN(od.Quantity) AS MinQuantity,
    MAX(od.Quantity) AS MaxQuantity
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate);
