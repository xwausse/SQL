EASY QUESTIONS
1. Compute Running Total Sales per Customer
SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;
2. Count the Number of Orders per Product Category
SELECT product_category, COUNT(*) AS total_orders
FROM sales_data
GROUP BY product_category;
3. Find the Maximum Total Amount per Product Category
SELECT product_category, MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;
4. Find the Minimum Price of Products per Product Category
SELECT product_category, MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;
5. Compute the Moving Average of Sales of 3 days (prev, curr, next)
SELECT order_date, total_amount,
       AVG(total_amount) OVER(
           ORDER BY order_date
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS moving_avg
FROM sales_data;
6. Find the Total Sales per Region
SELECT region, SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;
7. Rank Customers Based on Total Purchase Amount
SELECT customer_name, SUM(total_amount) AS total_spent,
       RANK() OVER(ORDER BY SUM(total_amount) DESC) AS rank_
FROM sales_data
GROUP BY customer_name;
8. Difference Between Current and Previous Sale per Customer
SELECT customer_id, order_date, total_amount,
       total_amount - LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS diff_prev
FROM sales_data;
9. Top 3 Most Expensive Products in Each Category
SELECT product_category, product_name, unit_price
FROM (
    SELECT product_category, product_name, unit_price,
           ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM sales_data
) t
WHERE rn <= 3;
10. Cumulative Sum of Sales Per Region by Order Date
SELECT region, order_date, total_amount,
       SUM(total_amount) OVER(PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;
 MEDIUM QUESTIONS
11. Cumulative Revenue per Product Category
SELECT product_category, order_date, total_amount,
       SUM(total_amount) OVER(PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;
12. Sum of Previous Values (OneColumn puzzle)
SELECT Value,
       SUM(Value) OVER(ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;
13. Customers with Purchases in More than One Category
SELECT customer_name
FROM sales_data
GROUP BY customer_name
HAVING COUNT(DISTINCT product_category) > 1;
14. Customers with Above-Average Spending in Their Region
SELECT customer_name, region, SUM(total_amount) AS total_spent
FROM sales_data s
GROUP BY customer_name, region
HAVING SUM(total_amount) > (
    SELECT AVG(total_amount)
    FROM sales_data x
    WHERE x.region = s.region
);
15. Rank Customers by Spending within Each Region
SELECT region, customer_name, SUM(total_amount) AS total_spent,
       RANK() OVER(PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY region, customer_name;
16. Running Total per Customer by Date
SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM sales_data;
17. Sales Growth Rate per Month
WITH monthly AS (
    SELECT YEAR(order_date) AS yr, MONTH(order_date) AS mn,
           SUM(total_amount) AS monthly_sales
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT yr, mn, monthly_sales,
       (monthly_sales - LAG(monthly_sales) OVER(ORDER BY yr, mn)) * 100.0
       / LAG(monthly_sales) OVER(ORDER BY yr, mn) AS growth_rate
FROM monthly;
18. Customers Whose Current Sale > Last Sale
SELECT customer_id, customer_name, order_date, total_amount
FROM (
    SELECT *,
           LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY order_date) AS last_order
    FROM sales_data
) t
WHERE total_amount > last_order;
 HARD QUESTIONS
19. Products Above Average Price
SELECT DISTINCT product_name, unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);
20. Group Sum Puzzle (MyData)
SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER(PARTITION BY Grp ORDER BY Id) = 1
            THEN SUM(Val1 + Val2) OVER(PARTITION BY Grp)
       END AS Tot
FROM MyData;
21. Cost + Quantity Puzzle (TheSumPuzzle)
SELECT ID, SUM(Cost) AS Cost, SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;
22. Seat Gaps Puzzle
WITH ordered AS (
    SELECT SeatNumber,
           SeatNumber - ROW_NUMBER() OVER(ORDER BY SeatNumber) AS grp
    FROM Seats
)
SELECT MIN(SeatNumber)+1 AS GapStart, MAX(SeatNumber)-1 AS GapEnd
FROM (
    SELECT grp, SeatNumber
    FROM ordered
) t
GROUP BY grp
HAVING MAX(SeatNumber) - MIN(SeatNumber) > 0
ORDER BY GapStart;
