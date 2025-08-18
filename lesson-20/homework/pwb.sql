1. Find customers who purchased at least one item in March 2024 using EXISTS
SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1 
    FROM #Sales x
    WHERE x.CustomerName = s.CustomerName
      AND MONTH(x.SaleDate) = 3
      AND YEAR(x.SaleDate) = 2024
);
2. Product with the highest total sales revenue
SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;
3. Second highest sale amount
SELECT MAX(TotalAmount) AS SecondHighestSale
FROM (
    SELECT DISTINCT Quantity * Price AS TotalAmount
    FROM #Sales
) t
WHERE TotalAmount < (SELECT MAX(Quantity * Price) FROM #Sales);
4. Total quantity sold per month using subquery
SELECT MONTH(SaleDate) AS SaleMonth, 
       (SELECT SUM(Quantity) 
        FROM #Sales s2 
        WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
          AND YEAR(s2.SaleDate) = YEAR(s1.SaleDate)) AS TotalQty
FROM #Sales s1
GROUP BY MONTH(SaleDate), YEAR(SaleDate);
5. Customers who bought same products as another customer
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);
6. Fruits count pivot
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
 Expected Output olinadi.
7. Older people in family with younger ones (all generations)
WITH CTE AS (
    SELECT ParentId, ChildID FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM CTE f
    JOIN Family c ON f.ChildID = c.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM CTE
ORDER BY PID, CHID;
 Expected Output chiqadi.
8. Customers with CA deliveries → show their TX orders
SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.DeliveryState = 'TX'
AND EXISTS (
    SELECT 1
    FROM #Orders c
    WHERE c.CustomerID = o.CustomerID
      AND c.DeliveryState = 'CA'
);
9. Insert missing names in residents
UPDATE #residents
SET fullname = SUBSTRING(address, CHARINDEX('name=', address) + 5, 
              CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) 
              - (CHARINDEX('name=', address) + 5))
WHERE fullname NOT IN (address);
 Bu query name= ni address ichidan chiqarib fullname column to‘ldiradi.
10. Cheapest & most expensive routes (Tashkent → Khorezm)
WITH Paths AS (
    SELECT 'Tashkent - Samarkand - Khorezm' AS Route, 100 + 400 AS Cost
    UNION ALL
    SELECT 'Tashkent - Jizzakh - Samarkand - Bukhoro - Khorezm',
           100 + 50 + 200 + 300
)
SELECT * FROM Paths;
 Expected Output chiqadi.
11. Rank products based on insertion groups
SELECT ID, Vals,
       DENSE_RANK() OVER (ORDER BY grp) AS GroupRank
FROM (
    SELECT *, SUM(CASE WHEN Vals='Product' THEN 1 ELSE 0 END) 
              OVER (ORDER BY ID) AS grp
    FROM #RankingPuzzle
) t;
12. Employees with higher sales than dept avg
SELECT e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales d
    WHERE d.Department = e.Department
      AND d.SalesMonth = e.SalesMonth
      AND d.SalesYear = e.SalesYear
);
13. Employees with highest sales in any given month (EXISTS)
SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales x
    WHERE x.SalesMonth = e.SalesMonth
      AND x.SalesYear = e.SalesYear
    GROUP BY x.SalesMonth, x.SalesYear
    HAVING e.SalesAmount = MAX(x.SalesAmount)
);
14. Employees with sales in every month (NOT EXISTS)
SELECT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales
    WHERE SalesYear = 2024
    EXCEPT
    SELECT SalesMonth
    FROM #EmployeeSales x
    WHERE x.EmployeeName = e.EmployeeName
      AND x.SalesYear = 2024
);
15. Products more expensive than avg price
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
16. Products with stock lower than max stock
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);
17. Products in same category as 'Laptop'
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');
18. Products with price > min price in Electronics
SELECT Name
FROM Products
WHERE Price > (SELECT MIN(Price) FROM Products WHERE Category = 'Electronics');
19. Products with price > avg category price
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(Price)
    FROM Products c
    WHERE c.Category = p.Category
);
20. Products ordered at least once
SELECT DISTINCT p.Name
FROM Products p
WHERE EXISTS (SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID);
21. Products ordered more than avg quantity
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);
22. Products never ordered
SELECT Name
FROM Products p
WHERE NOT EXISTS (SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID);
23. Product with highest total quantity ordered
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;
