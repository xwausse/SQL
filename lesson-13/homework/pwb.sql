 Concatenate emp_id + first_name + last_name (format: "100-Steven King")
SELECT 
    CAST(emp_id AS VARCHAR) + '-' + first_name + ' ' + last_name AS EmployeeInfo
FROM Employees;
Agar siz MySQL-dan foydalansangiz:
SELECT 
    CONCAT(emp_id, '-', first_name, ' ', last_name) AS EmployeeInfo
FROM Employees;
 Replace '124' with '999' in phone_number column
UPDATE Employees
SET phone_number = REPLACE(phone_number, '124', '999');
 First names starting with A, J, M with length, sorted
SELECT 
    first_name AS "First Name",
    LEN(first_name) AS "Name Length"     
FROM Employees
WHERE LEFT(first_name, 1) IN ('A', 'J', 'M')
ORDER BY first_name;
MySQL versiyasi:
SELECT 
    first_name AS `First Name`,
    LENGTH(first_name) AS `Name Length`
FROM Employees
WHERE LEFT(first_name, 1) IN ('A', 'J', 'M')
ORDER BY first_name;
 Total salary for each manager_id
SELECT 
    manager_id,
    SUM(salary) AS TotalSalary
FROM Employees
GROUP BY manager_id;
 Max of Max1, Max2, Max3 for each row (TestMax table)
SELECT 
    year,
    GREATEST(Max1, Max2, Max3) AS MaxValue
FROM TestMax;
MySQL uchun GREATEST() ishlaydi, lekin SQL Server’da quyidagicha yoziladi:
SELECT 
    year,
    (SELECT MAX(val) 
     FROM (VALUES (Max1), (Max2), (Max3)) AS ValueList(val)) AS MaxValue
FROM TestMax;
 Odd-numbered movies with non-boring description (Cinema)
SELECT *
FROM Cinema
WHERE id % 2 = 1 
  AND description <> 'boring';
 Sort by ID but show ID = 0 at the end (SingleOrder table)
SELECT *
FROM SingleOrder
ORDER BY 
    CASE WHEN id = 0 THEN 1 ELSE 0 END,  -- puts 0 at the end
    id;
 Select first non-null value from multiple columns (person table)
SELECT 
    COALESCE(column1, column2, column3, column4) AS FirstNonNull
FROM person;

 Split FullName into Firstname, Middlename, Lastname (Students table)
(Agar to‘liq ism 3 so‘zdan iborat bo‘lsa)
📌 SQL Server:
SELECT
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;
📌 MySQL:
SELECT
    SUBSTRING_INDEX(FullName, ' ', 1) AS FirstName,
    SUBSTRING_INDEX(SUBSTRING_INDEX(FullName, ' ', 2), ' ', -1) AS MiddleName,
    SUBSTRING_INDEX(FullName, ' ', -1) AS LastName
FROM Students;
Customers who had delivery to California → Show their orders to Texas (Orders table)
SELECT *
FROM Orders
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE state = 'California'
)
AND state = 'Texas';
 Group Concatenate values (DMLTable)
📌 MySQL:
SELECT 
    GROUP_CONCAT(column_name SEPARATOR ', ') AS ConcatenatedValues
FROM DMLTable;
📌 SQL Server (STRING_AGG - 2017+):
SELECT 
    STRING_AGG(column_name, ', ') AS ConcatenatedValues
FROM DMLTable;
 Employees whose concatenated names have ≥ 3 occurrences of letter 'a'
SELECT *
FROM Employees
WHERE 
    LEN(REPLACE(REPLACE(first_name + last_name, 'A', ''), 'a', '')) <= 
    LEN(first_name + last_name) - 3;
 MySQL:
SELECT *
FROM Employees
WHERE 
    LENGTH(CONCAT(first_name, last_name)) - 
    LENGTH(REPLACE(REPLACE(CONCAT(first_name, last_name), 'a', ''), 'A', '')) >= 3;
 Employee count by department and % who worked > 3 years
SELECT 
    department_id,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) AS MoreThan3Years,
    ROUND(
        100.0 * SUM(CASE WHEN DATEDIFF(YEAR, hire_date, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS PercentageMoreThan3Years
FROM Employees
GROUP BY department_id;
MySQL versiyasi:
SELECT 
    department_id,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 3 THEN 1 ELSE 0 END) AS MoreThan3Years,
    ROUND(
        100 * SUM(CASE WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS PercentageMoreThan3Years
FROM Employees
GROUP BY department_id;
 Most and least experienced Spaceman ID by job description (Personal table)
SELECT 
    job_description,
    MAX_BY(spaceman_id, experience_years) AS MostExperienced,
    MIN_BY(spaceman_id, experience_years) AS LeastExperienced
FROM Personal
GROUP BY job_description;
 Agar MIN_BY / MAX_BY funksiyasi mavjud bo‘lmasa (masalan, SQL Server yoki MySQL):

SELECT job_description, spaceman_id AS MostExperienced
FROM Personal p1
WHERE experience_years = (
    SELECT MAX(experience_years)
    FROM Personal p2
    WHERE p1.job_description = p2.job_description
);


SELECT job_description, spaceman_id AS LeastExperienced
FROM Personal p1
WHERE experience_years = (
    SELECT MIN(experience_years)
    FROM Personal p2
    WHERE p1.job_description = p2.job_description
);


 Separate uppercase, lowercase, digits, and special characters from a string ('tf56sd#%OqH')
📌 SQL Server (Using XML Split Trick + Filtering):
WITH SplitChars AS (
    SELECT value AS ch
    FROM STRING_SPLIT('tf56sd#%OqH', '')
)
SELECT
    STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch ELSE '' END, '') AS Uppercase,
    STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch ELSE '' END, '') AS Lowercase,
    STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch ELSE '' END, '') AS Digits,
    STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch ELSE '' END, '') AS SpecialChars
FROM SplitChars;
 MySQL 8.0+ (via recursive CTE):
WITH RECURSIVE chars AS (
  SELECT 1 AS pos, SUBSTRING('tf56sd#%OqH', 1, 1) AS ch
  UNION ALL
  SELECT pos + 1, SUBSTRING('tf56sd#%OqH', pos + 1, 1)
  FROM chars
  WHERE pos < CHAR_LENGTH('tf56sd#%OqH')
)
SELECT 
  GROUP_CONCAT(IF(ch REGEXP '[A-Z]', ch, '') SEPARATOR '') AS Uppercase,
  GROUP_CONCAT(IF(ch REGEXP '[a-z]', ch, '') SEPARATOR '') AS Lowercase,
  GROUP_CONCAT(IF(ch REGEXP '[0-9]', ch, '') SEPARATOR '') AS Digits,
  GROUP_CONCAT(IF(ch REGEXP '[^A-Za-z0-9]', ch, '') SEPARATOR '') AS SpecialChars
FROM chars;
Cumulative Sum (Running Total) in Students Table
SELECT 
    student_id,
    student_name,
    value,
    SUM(value) OVER (ORDER BY student_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS CumulativeValue
FROM Students;
 value bu yerda summalanadigan ustun, student_id orqali tartiblanadi.
 Evaluate math expressions in VARCHAR column (Equations table)
 SQL Server (only works with EXEC/sp_executesql via dynamic SQL):

SELECT equation,
       CAST(PARSENAME(REPLACE(equation, '+', '.'), 2) AS INT) + 
       CAST(PARSENAME(REPLACE(equation, '+', '.'), 1) AS INT) AS Answer
FROM Equations
WHERE equation LIKE '%+%';
 MySQL 8.0+ (if string is like '3+2', '5*2'), no native support — requires UDF or client-side logic. You can parse basic math:
SELECT 
  equation,
  SUBSTRING_INDEX(equation, '+', 1) + SUBSTRING_INDEX(equation, '+', -1) AS answer
FROM Equations
WHERE equation LIKE '%+%';
 Find students with same birthday (Student Table)
SELECT *
FROM Students
WHERE birth_date IN (
    SELECT birth_date
    FROM Students
    GROUP BY birth_date
    HAVING COUNT(*) > 1
)
ORDER BY birth_date;
 Aggregate scores for each unique pair of players (PlayerScores table)
 Normalize A-B vs B-A → always store as (min, max):
SELECT 
    LEAST(player_a, player_b) AS player1,
    GREATEST(player_a, player_b) AS player2,
    SUM(score_a + score_b) AS total_score
FROM PlayerScores
GROUP BY 
    LEAST(player_a, player_b),
    GREATEST(player_a, player_b);
Agar LEAST() va GREATEST() mavjud bo‘lmasa (SQL Server), foydalaning:
SELECT 
    CASE WHEN player_a < player_b THEN player_a ELSE player_b END AS player1,
    CASE WHEN player_a < player_b THEN player_b ELSE player_a END AS player2,
    SUM(score_a + score_b) AS total_score
FROM PlayerScores
GROUP BY 
    CASE WHEN player_a < player_b THEN player_a ELSE player_b END,
    CASE WHEN player_a < player_b THEN player_b ELSE player_a END;
