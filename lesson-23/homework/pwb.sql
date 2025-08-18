Puzzle 1: Extract Month with Zero Prefix
SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;
Puzzle 2: Distinct Ids + SUM of Max Vals
SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT 
        Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;
Puzzle 3: Records with Length Between 6 and 10
SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;
Puzzle 4: Item with Max Value Per ID
SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
WHERE Vals = (
    SELECT MAX(Vals)
    FROM TestMaximum
    WHERE ID = t.ID
);
Puzzle 5: Sum of Max Values by Id
SELECT Id, SUM(MaxVal) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;
Puzzle 6: Replace 0 with Blank
SELECT 
    Id, a, b,
    CASE 
        WHEN a - b = 0 THEN '' 
        ELSE CAST(a - b AS VARCHAR(20)) 
    END AS OUTPUT
FROM TheZeroPuzzle;
Sales Table Queries
1. Total revenue
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;
2. Average unit price
SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;
3. Number of transactions
SELECT COUNT(*) AS TotalTransactions
FROM Sales;
4. Highest units sold
SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;
5. Products sold per category
SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category;
6. Revenue by region
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;
7. Highest revenue product
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;
8. Running total of revenue
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningRevenue
FROM Sales;
9. Category contribution
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    SUM(QuantitySold * UnitPrice) * 100.0 / 
        (SELECT SUM(QuantitySold * UnitPrice) FROM Sales) AS ContributionPercent
FROM Sales
GROUP BY Category;
 Customers + Sales Queries
1. Sales with customer names
SELECT s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, s.SaleDate, 
       c.CustomerName, c.Region
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;
2. Customers with no purchases
SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;
3. Revenue per customer
SELECT c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;
4. Top contributing customer
SELECT TOP 1 c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;
5. Total sales per customer
SELECT c.CustomerName, COUNT(s.SaleID) AS TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;
 Products Queries
1. Products sold at least once
SELECT DISTINCT s.Product
FROM Sales s
JOIN Products p ON s.Product = p.ProductName;
2. Most expensive product
SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;
3. Products priced above category average
SELECT p.ProductName, p.Category, p.SellingPrice
FROM Products p
WHERE p.SellingPrice > (
    SELECT AVG(SellingPrice) 
    FROM Products p2
    WHERE p2.Category = p.Category
);
