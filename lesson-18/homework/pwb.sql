-- Drop if exists
IF OBJECT_ID('tempdb..#MonthlySales') IS NOT NULL
    DROP TABLE #MonthlySales;

SELECT 
    s.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE MONTH(SaleDate) = MONTH(GETDATE())
  AND YEAR(SaleDate) = YEAR(GETDATE())
GROUP BY s.ProductID;

SELECT * FROM #MonthlySales;
2. Create view vw_ProductSalesSummary
CREATE VIEW vw_ProductSalesSummary
AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity),0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;
3. Function fn_GetTotalRevenueForProduct
CREATE FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Revenue DECIMAL(18,2);

    SELECT @Revenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE s.ProductID = @ProductID;

    RETURN ISNULL(@Revenue,0);
END;
Test:
SELECT dbo.fn_GetTotalRevenueForProduct(1);
4. Function fn_GetSalesByCategory
CREATE FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
Test:
SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');
5. Function fn_IsPrime
CREATE FUNCTION fn_IsPrime(@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number <= 1 RETURN 'No';
    DECLARE @i INT = 2;
    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i += 1;
    END
    RETURN 'Yes';
END;
Test:
SELECT dbo.fn_IsPrime(29); -- Yes
SELECT dbo.fn_IsPrime(91); -- No
6. Function fn_GetNumbersBetween
CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i += 1;
    END
    RETURN;
END;
Test:
SELECT * FROM dbo.fn_GetNumbersBetween(5,10);
7. Nth Highest Distinct Salary
CREATE FUNCTION getNthHighestSalary(@N INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            OFFSET (@N-1) ROWS FETCH NEXT 1 ROWS ONLY
        ) AS HighestNSalary
);
Test:
SELECT * FROM getNthHighestSalary(2);
8. Most Friends
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC;
9. View: vw_CustomerOrderSummary
CREATE VIEW vw_CustomerOrderSummary
AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount),0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
10. Fill Missing Gaps
👉 Use LAST_VALUE window function:
SELECT 
    RowNumber,
    LAST_VALUE(TestCase) OVER (
        ORDER BY RowNumber 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Workflow
FROM Gaps
ORDER BY RowNumber
