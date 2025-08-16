--1. You must provide a report of all distributors and their sales by region. If a distributor did not have any sales for a region, rovide a zero-dollar value for that day. Assume there is at least one sale for each region
DROP TABLE IF EXISTS #RegionSales;
GO
CREATE TABLE #RegionSales (
  Region      VARCHAR(100),
  Distributor VARCHAR(100),
  Sales       INTEGER NOT NULL,
  PRIMARY KEY (Region, Distributor)
);
GO
INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10), ('South','ACE',67), ('East','ACE',54),
('North','ACME',65), ('South','ACME',9), ('East','ACME',1), ('West','ACME',7),
('North','Direct Parts',8), ('South','Direct Parts',7), ('West','Direct Parts',12);


WITH cte as(
SELECT distinct r.Region, r1.Distributor from #RegionSales r cross join #RegionSales r1 )
SELECT cte.Region, cte.Distributor, ISNULL(o.Sales, 0) AS Sales  from cte left join #RegionSales o  on cte.Distributor = o.Distributor and cte.Region = o.Region


--2. Find managers with at least five direct reports
CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101);
SELECT m.name
FROM Employee e
JOIN Employee m ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;


--3. Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
CREATE TABLE Products (product_id INT, product_name VARCHAR(40), product_category VARCHAR(40));
CREATE TABLE Orders (product_id INT, order_date DATE, unit INT);
TRUNCATE TABLE Products;
INSERT INTO Products VALUES
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'), (4, 'Lenovo', 'Laptop'), (5, 'Leetcode Kit', 'T-shirt');
TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES
(1,'2020-02-05',60),(1,'2020-02-10',70),
(2,'2020-01-18',30),(2,'2020-02-11',80),
(3,'2020-02-17',2),(3,'2020-02-24',3),
(4,'2020-03-01',20),(4,'2020-03-04',30),(4,'2020-03-04',60),
(5,'2020-02-25',50),(5,'2020-02-27',50),(5,'2020-03-01',50);

SELECT * from Products
SELECT * from orders
SELECT  Products.ProductName,   SUM(orders.unit) as unit from Products join Orders on Products.ProductID = Orders.ProductID where YEAR(orders.order_date) = 2022 and MONTH(orders.order_date) =2 GROUP BY Products.ProductName HAVING SUM(orders.unit) >= 100



--4. Write an SQL statement that returns the vendor from which each customer has placed the most orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  OrderID    INTEGER PRIMARY KEY,
  CustomerID INTEGER NOT NULL,
  [Count]    MONEY NOT NULL,
  Vendor     VARCHAR(100) NOT NULL
);
INSERT INTO Orders VALUES
(1,1001,12,'Direct Parts'), (2,1001,54,'Direct Parts'), (3,1001,32,'ACME'),
(4,2002,7,'ACME'), (5,2002,16,'ACME'), (6,2002,5,'Direct Parts');

WITH cte as(
SELECT Orders.CustomerID, Orders.Vendor, COUNT(Orders.OrderID) as countid ,
ROW_NUMBER() over(partition by CustomerID order by COUNT(Orders.OrderID) ) as rnk
from Orders GROUP BY Orders.CustomerID, Orders.Vendor )
SELECT cte.CustomerID, cte.Vendor from cte where cte.rnk >=2

--5. You will be given a number as a variable called @Check_Prime check if this number is prime then return 'This number is prime' else eturn 'This number is not prime'
DECLARE @Check_Prime INT = 91;   -- input
DECLARE @i INT = 2;              -- bo'luvchi boshlanishi
DECLARE @isPrime BIT = 1;        -- default: true

-- 1 va manfiy sonlar prime emas
IF @Check_Prime <= 1
    SET @isPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;  -- bo'linadigan son topildi
        END
        SET @i = @i + 1;
    END
END

-- Natija chiqarish
IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';


-- Write an SQL query to return the number of locations,in which location most signals sent, and total number of signal for each device from the given table.
WITH cte AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count,
        ROW_NUMBER() OVER (
            PARTITION BY Device_id ORDER BY COUNT(*) DESC
        ) AS rn
    FROM Device
    GROUP BY Device_id, Locations
),
cte2 AS (
    SELECT 
        Device_id,
        COUNT(DISTINCT Locations) AS no_of_location,
        SUM(signal_count) AS no_of_signals
    FROM cte
    GROUP BY Device_id
)
SELECT 
    c2.Device_id,
    c2.no_of_location,
    c1.Locations AS max_signal_location,
    c2.no_of_signals
FROM cte2 c2
JOIN cte c1 
    ON c1.Device_id = c2.Device_id AND c1.rn = 1;


    CREATE TABLE Employee (
  EmpID INT,
  EmpName VARCHAR(30),
  Salary FLOAT,
  DeptID INT
);
INSERT INTO Employee VALUES
(1001,'Mark',60000,2), (1002,'Antony',40000,2), (1003,'Andrew',15000,1),
(1004,'Peter',35000,1), (1005,'John',55000,1), (1006,'Albert',25000,3), (1007,'Donald',35000,3);
SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);

--8. You are part of an office lottery pool where you keep a table of the winning lottery numbers along with a table of each ticket’s chosen numbers. If a ticket has some but not all the winning numbers, you win $10. If a ticket has all the winning numbers, you win $100. Calculate the total winnings for today’s drawing.
WITH TicketMatch AS (
    SELECT 
        t.TicketID,
        COUNT(*) AS total_ticket_numbers,
        SUM(CASE WHEN n.Number IS NOT NULL THEN 1 ELSE 0 END) AS matched_numbers
    FROM Tickets t
    LEFT JOIN Numbers n
        ON t.Number = n.Number
    GROUP BY t.TicketID
)
SELECT 
    SUM(
        CASE 
            WHEN matched_numbers = (SELECT COUNT(*) FROM Numbers) THEN 100
            WHEN matched_numbers > 0 THEN 10
            ELSE 0
        END
    ) AS total_winnings
FROM TicketMatch;


--. Write an SQL Statement to de-group the following data.
WITH cte AS (
    -- Boshlang'ich qiymat
    SELECT Product, 1 AS Quantity, Quantity AS TotalQty
    FROM Grouped
    UNION ALL
    -- Har bir product uchun qolgan quantitylarni hosil qilish
    SELECT Product, 1, TotalQty - 1
    FROM cte
    WHERE TotalQty > 1
)
SELECT Product, Quantity
FROM cte
ORDER BY Product;
