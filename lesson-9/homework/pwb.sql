Barcha mahsulot va yetkazib beruvchi kombinatsiyalari (Products, Suppliers):
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;
 Barcha bo‘lim va xodim kombinatsiyalari (Departments, Employees):
SELECT d.DeptName, e.EmployeeName
FROM Departments d
CROSS JOIN Employees e;
 Faqat yetkazib beruvchi haqiqatan ham mahsulot yetkazgan holatlar (Products, Suppliers):
SELECT s.SupplierName, p.ProductName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID;
 Mijoz nomi va ularning buyurtma IDlari (Orders, Customers):
SELECT c.CustomerName, o.OrderID
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;
 Har bir talabani har bir kurs bilan kombinatsiyasi (Courses, Students):
SELECT s.StudentName, c.CourseName
FROM Students s
CROSS JOIN Courses c;
 Mahsulot nomlari va buyurtmalar (ProductID mos tushgan) (Products, Orders):
SELECT p.ProductName, o.OrderID
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID;
 Bo‘lim ID mos bo‘lgan xodimlar (Departments, Employees):
SELECT e.EmployeeName, d.DeptName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID;
 Talaba ismlari va ularning kurs IDlari (Students, Enrollments):
SELECT s.StudentName, e.CourseID
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID;
Matching payments va orders (Payments, Orders):
SELECT o.OrderID, p.PaymentID
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;
 Narxi 100 dan katta bo‘lgan mahsulotlar bo‘yicha buyurtmalar (Orders, Products):
SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;



 Boshqa bo‘limdagi barcha juftliklar (Employees jadvalidan):
SELECT e1.EmployeeName AS Employee1,
       e2.EmployeeName AS Employee2,
       e1.DeptID AS Dept1,
       e2.DeptID AS Dept2
FROM Employees e1
JOIN Employees e2 ON e1.EmployeeID <> e2.EmployeeID
WHERE e1.DeptID <> e2.DeptID;
Bu barcha farqli bo‘limdagi xodimlar juftligini beradi.
 To‘lov summasi Quantity * Price ga teng bo‘lmagan holatlar (Payments, Orders, Products):
SELECT p.PaymentID, o.OrderID, pr.ProductName,
       o.Quantity, pr.Price,
       o.Quantity * pr.Price AS ExpectedAmount,
       p.PaymentAmount AS ActualAmount
FROM Payments p
JOIN Orders o ON p.OrderID = o.OrderID
JOIN Products pr ON o.ProductID = pr.ProductID
WHERE p.PaymentAmount <> o.Quantity * pr.Price;
 Kursga ro‘yxatdan o‘tmagan talabalar (Students, Enrollments):
SELECT s.StudentID, s.StudentName
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;
LEFT JOIN orqali kursga ro‘yxatdan o‘tmagan talabalar aniqlanadi.
 Boshqa xodimga boshliq bo‘lgan, lekin o‘zidan kam maosh olgan boshliqlar (Employees):
SELECT m.EmployeeID AS ManagerID, m.EmployeeName AS ManagerName,
       e.EmployeeID AS EmployeeID, e.EmployeeName AS EmployeeName,
       m.Salary AS ManagerSalary, e.Salary AS EmployeeSalary
FROM Employees m
JOIN Employees e ON m.EmployeeID = e.ManagerID
WHERE m.Salary <= e.Salary;
Bu ManagerID va EmployeeID o‘rtasida bog‘liqlikni tekshiradi va boshliqqa nisbatan ko‘proq maosh oladigan xodimlarni ko‘rsatadi.
 Buyurtma bergan, lekin to‘lov qilmagan mijozlar (Orders, Payments, Customers):
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;




 Employees va Departments – IDlari mos kelmaydigan kombinatsiyalar (mismatch):
SELECT e.EmployeeName, d.DeptName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DeptID <> d.DeptID;
CROSS JOIN + WHERE orqali barcha noto‘g‘ri mosliklar (mismatches) olinadi.
 Buyurtma miqdori ombordagi zaxiradan katta bo‘lgan holatlar (Orders, Products):
SELECT o.OrderID, o.Quantity, p.ProductName, p.Quantity AS Stock
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.Quantity;
 Sotuv summasi 500 yoki undan katta bo‘lgan mijoz va mahsulotlar (Customers, Sales):
SELECT c.CustomerName, s.ProductID
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE s.SaleAmount >= 500;
 Talabalar va ular ro‘yxatdan o‘tgan kurslar (Courses, Enrollments, Students):
SELECT s.StudentName, c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID;
 Yetkazib beruvchi nomida "Tech" bo‘lgan mahsulotlar (Products, Suppliers):
SELECT p.ProductName, s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';
 To‘lov summasi buyurtma summasidan kam bo‘lgan holatlar (Orders, Payments):
SELECT o.OrderID, o.TotalAmount, p.PaymentAmount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentAmount < o.TotalAmount;
 Xodimlar va ularning bo‘lim nomlari (Employees, Departments):
SELECT e.EmployeeName, d.DeptName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID;
 Electronics yoki Furniture toifasiga tegishli mahsulotlar (Products, Categories):
SELECT p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');
 USA dagi mijozlar tomonidan amalga oshirilgan barcha sotuvlar (Sales, Customers):
SELECT s.*
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';
 Buyurtma summasi > 100 va Germany dan bo‘lgan mijozlar (Orders, Customers):
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;
