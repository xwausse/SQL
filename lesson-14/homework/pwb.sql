
1. Split Name column into Name and Surname
Table: TestMultipleColumns
SELECT 
  LEFT(Name, CHARINDEX(',', Name) - 1) AS Name,
  LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS Surname
FROM TestMultipleColumns;
2. Find strings that contain %
Table: TestPercent
SELECT * 
FROM TestPercent 
WHERE column_name LIKE '%[%]%';
3. Split a string based on .
Table: Splitter
SELECT 
  value AS Part
FROM Splitter
CROSS APPLY STRING_SPLIT(column_name, '.');
4. Replace all digits with 'X'
SELECT 
  column_name,
  TRANSLATE(column_name, '0123456789', 'XXXXXXXXXX') AS Replaced
FROM YourTable;
5. Rows where Vals contains more than two dots
Table: testDots
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;
6. Count spaces in a string
Table: CountSpaces
SELECT 
  column_name,
  LEN(column_name) - LEN(REPLACE(column_name, ' ', '')) AS SpaceCount
FROM CountSpaces;
7. Employees earning more than managers
Table: Employee
SELECT e.Name
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;
8. Employees with 10–15 years of service
Table: Employees
SELECT 
  EmployeeID,
  FirstName,
  LastName,
  HireDate,
  DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HireDate, GETDATE()) BETWEEN 10 AND 14;
 Medium Tasks
1. Separate integers and characters
SELECT 
  column_name,
  LEFT(column_name, PATINDEX('%[^0-9]%', column_name + 'A') - 1) AS Integers,
  STUFF(column_name, 1, PATINDEX('%[^0-9]%', column_name + 'A') - 1, '') AS Characters
FROM YourTable;
2. Dates with higher temperature than yesterday
Table: weather
SELECT w1.Id
FROM weather w1
JOIN weather w2 ON w1.RecordDate = DATEADD(DAY, 1, w2.RecordDate)
WHERE w1.Temperature > w2.Temperature;
3. First login date per player
Table: Activity
SELECT 
  PlayerId,
  MIN(EventDate) AS FirstLogin
FROM Activity
GROUP BY PlayerId;
4. Return the third item from list
Table: fruits
SELECT 
  value AS ThirdItem
FROM fruits
CROSS APPLY STRING_SPLIT(fruit_list, ',')
ORDER BY (SELECT NULL) -- optional
OFFSET 2 ROWS FETCH NEXT 1 ROW ONLY;
5. Turn string into rows
SELECT 
  SUBSTRING(column_name, v.number, 1) AS Char
FROM YourTable
JOIN master.dbo.spt_values v ON v.type = 'P'
WHERE v.number BETWEEN 1 AND LEN(column_name);
6. Join p1 and p2, replace p1.code = 0
SELECT 
  p1.id,
  CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;
7. Determine Employment Stage
Table: Employees
SELECT 
  EmployeeID,
  HIRE_DATE,
  CASE 
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 6 THEN 'Junior'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 11 THEN 'Mid-Level'
    WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 21 THEN 'Senior'
    ELSE 'Veteran'
  END AS EmploymentStage
FROM Employees;
8. Extract starting integer from string
Table: GetIntegers
SELECT 
  LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'X') - 1) AS StartInteger
FROM GetIntegers;
 Difficult Tasks
1. Swap first two letters in comma-separated string
Table: MultipleVals
SELECT 
  STUFF(STUFF(val, 1, 1, SUBSTRING(val, CHARINDEX(',', val) + 1, 1)), 
        CHARINDEX(',', val) + 1, 1, LEFT(val, 1)) AS Swapped
FROM MultipleVals;
2. Device first logged in per player
Table: Activity
SELECT PlayerId, Device
FROM (
  SELECT *, 
         RANK() OVER (PARTITION BY PlayerId ORDER BY EventDate ASC) AS rk
  FROM Activity
) a
WHERE rk = 1;
3. Week-on-week sales percentage
Table: Sales(Area, SaleDate, Amount)
WITH SalesByWeek AS (
  SELECT 
    Area,
    DATEPART(WEEK, SaleDate) AS WeekNo,
    SUM(Amount) AS TotalSales
  FROM Sales
  GROUP BY Area, DATEPART(WEEK, SaleDate)
),
WeeklyTotal AS (
  SELECT 
    DATEPART(WEEK, SaleDate) AS WeekNo,
    SUM(Amount) AS WeekTotal
  FROM Sales
  GROUP BY DATEPART(WEEK, SaleDate)
)
SELECT 
  s.Area,
  s.WeekNo,
  ROUND(100.0 * s.TotalSales / w.WeekTotal, 2) AS Percentage
FROM SalesByWeek s
JOIN WeeklyTotal w ON s.WeekNo = w.WeekNo;
