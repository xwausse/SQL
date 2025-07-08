Combine Two Tables (LEFT JOIN)
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;
 Employees Earning More Than Their Managers
SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;
 Duplicate Emails
SELECT 
    email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;
 Delete Duplicate Emails (Keep Smallest ID)
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Person
    GROUP BY email
);
 Parents Who Have Only Girls
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT DISTINCT ParentName FROM boys
);
 Total Sales Over 50 Weight, With Least Weight Per Customer
(TSQL2012 - Sales.Orders table)
SELECT 
    CustomerID,
    SUM(TotalDue) AS TotalSalesOver50,
    MIN(OrderQty) AS LeastWeight
FROM Sales.Orders
WHERE OrderQty > 50
GROUP BY CustomerID;
Agar OrderQty emas, boshqa "weight" maydoni bo‘lsa, uni aniqlashtiring.
 Cart Comparison (FULL OUTER JOIN)
SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2 ON c1.Item = c2.Item;
 Customers Who Never Order
SELECT 
    c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.id IS NULL;
 Students and Examinations Count
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e 
    ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
