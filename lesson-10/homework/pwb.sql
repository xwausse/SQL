 Employees with Salary > 50000 and their Department names
SELECT 
    e.EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE e.Salary > 50000;
 Customers who placed orders in 2023
SELECT 
    c.FirstName,
    c.LastName,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;
 All employees and their department names, including those with no department
SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID;
 All suppliers and the products they supply (including suppliers with no products)
SELECT 
    s.SupplierName,
    p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;
 All orders and their corresponding payments (include unmatched on both sides)
SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
FULL OUTER JOIN Payments p ON o.OrderID = p.OrderID;
⚠️ Agar FULL OUTER JOIN sizning serveringizda qo‘llab-quvvatlanmasa, UNION + LEFT/RIGHT JOIN ishlatish mumkin.
Each employee and their manager's name
SELECT 
    e.EmployeeName,
    m.EmployeeName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;
 Students enrolled in 'Math 101'
SELECT 
    s.StudentName,
    c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';
 Customers who placed orders with more than 3 items
SELECT 
    c.FirstName,
    c.LastName,
    o.Quantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.Quantity > 3;
 Employees working in the 'Human Resources' department
SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.DepartmentName = 'Human Resources';



 Bo‘limlar (Departments)da 5 tadan ortiq xodim bo‘lgan holatlar:
SELECT 
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e ON d.DeptID = e.DeptID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;
 Hech qachon sotilmagan mahsulotlar (Products):
SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;
 Kamida bitta buyurtma bergan mijozlar (Customers):
SELECT 
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;
 Faqat mavjud bo‘lim va xodimlar (ya’ni NULL bo‘lmagan JOIN):
SELECT 
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DeptID = d.DeptID;
 Bir xil menejerga bo‘ysunadigan xodim juftliklari:
SELECT 
    e1.EmployeeName AS Employee1,
    e2.EmployeeName AS Employee2,
    e1.ManagerID
FROM Employees e1
JOIN Employees e2 
    ON e1.ManagerID = e2.ManagerID 
   AND e1.EmployeeID < e2.EmployeeID
WHERE e1.ManagerID IS NOT NULL;
EmployeeID < e2.EmployeeID — bu juftliklar takrorlanmasligi uchun qo‘shilgan.
 2022 yilda berilgan buyurtmalar va mijoz ismi:
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;
 Sotuv bo‘limidagi, maoshi 60000 dan yuqori xodimlar:
SELECT 
    e.EmployeeName,
    e.Salary,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;
 To‘lovi mavjud bo‘lgan buyurtmalar:
SELECT 
    o.OrderID,
    o.OrderDate,
    p.PaymentDate,
    p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;
 Hech qachon buyurtma qilinmagan mahsulotlar:
SELECT 
    p.ProductID,
    p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;


 O‘z bo‘limidagi o‘rtacha maoshdan ko‘proq oladigan xodimlar:
SELECT e.EmployeeName, e.Salary
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DeptID = e.DeptID
);
 2020-yildan oldingi to‘lovsiz buyurtmalar:
SELECT o.OrderID, o.OrderDate
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL AND o.OrderDate < '2020-01-01';
 Kategoriya bilan bog‘lanmagan mahsulotlar (Products va Categories):
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL;
 Bir xil menejerga bo‘ysunuvchi va maoshi 60000 dan yuqori bo‘lgan xodimlar juftligi:
SELECT e1.EmployeeName AS Employee1,
       e2.EmployeeName AS Employee2,
       e1.ManagerID,
       e1.Salary
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID AND e1.Salary > 60000 AND e2.Salary > 60000;
 Bo‘lim nomi 'M' harfi bilan boshlanuvchi xodimlar:
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DeptID = d.DeptID
WHERE d.DepartmentName LIKE 'M%';
 500 dan katta sotuvlar va mahsulot nomi bilan birga:
SELECT s.SaleID, p.ProductName, s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE s.SaleAmount > 500;
 ‘Math 101’ kursiga yozilmagan talabalar:
SELECT s.StudentID, s.StudentName
FROM Students s
WHERE s.StudentID NOT IN (
    SELECT e.StudentID
    FROM Enrollments e
    JOIN Courses c ON e.CourseID = c.CourseID
    WHERE c.CourseName = 'Math 101'
);
 To‘lovsiz buyurtmalar (Payments bo‘lmagan Orders):
SELECT o.OrderID, o.OrderDate, p.PaymentID
FROM Orders o
LEFT JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.PaymentID IS NULL;
9 Elektronika yoki mebel kategoriyasidagi mahsulotlar:
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
