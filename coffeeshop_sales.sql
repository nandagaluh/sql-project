# sql-project

SELECT * FROM coffe_shop_sales

select SUM(unit_price * transaction_qty) As Total_Sales
from coffe_shop_sales
where
month(transaction_date) = 5 -- may month

SELECT STR_TO_DATE(transaction_date, '%d/%m/%Y') AS formatted_date
FROM coffe_shop_sales;

SELECT * FROM `coffee sales`


UPDATE coffe_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%d/%m/%Y');

ALTER TABLE coffe_shop_sales
MODIFY COLUMN transaction_date DATE;

DESCRIBE `coffee sales`

SELECT COUNT(transaction_id) AS Total_Orders 
FROM `coffee sales`
WHERE
MONTH(transaction_date) = 5 -- May Month

SELECT
	MONTH(transaction_date) AS month, -- Number of month
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales, -- Total sales column
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1)
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM
	`coffee sales`
WHERE 
	MONTH(transaction_date) IN (4, 5) -- for months of april and may
GROUP BY
	MONTH(transaction_date)
ORDER BY
	MONTH(transaction_date);

SELECT
	MONTH(transaction_date) AS month, -- 
    ROUND(COUNT(transaction_id)) AS total_order, -- 
    (COUNT(transaction_id) - LAG(COUNT(transaction_id), 1)
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id), 1)
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage
FROM
	`coffee sales`
WHERE 
	MONTH(transaction_date) IN (4, 5) -- for months of april and may
GROUP BY
	MONTH(transaction_date)
ORDER BY
	MONTH(transaction_date);
    
SELECT SUM(transaction_qty) AS Total_Quantity_Sold
FROM `coffee sales`
WHERE
MONTH(transaction_date) = 6 -- June Month

SELECT
	SUM(unit_price * transaction_qty) AS Total_sales,
    SUM(transaction_qty) AS Total_Qty_Sold,
    COUNT(transaction_id) AS Total_orders
FROM `coffee sales`
WHERE
	transaction_date = '2023-05-18'
    
SELECT
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000, 1), 'K') AS Total_sales,
    CONCAT(ROUND(SUM(transaction_qty)/1000, 1), 'K') AS Total_Qty_Sold,
    CONCAT(ROUND(COUNT(transaction_id)/1000, 1), 'K') AS Total_orders
FROM `coffee sales`
WHERE
	transaction_date = '2023-05-18'

-- weekends - Sat and Sun
-- weekdays - Mon to Fri

Sun = 1
Mon = 2
.
.
Sat = 7

SELECT
	CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) Then 'Weekends'
    ELSE 'Weekdays'
    END AS day_type,
    SUM(unit_price * transaction_qty) As Total_Sales
From `coffee sales`
WHERE MONTH(transaction_date) = 5 -- May Month
GrOUP BY
    CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) Then 'Weekends'
    ELSE 'Weekdays'
    END\
    
  
 -- EMPLOYEES
Describe Employees

Select * From Employees
Where first_name Not Like ('%Mar%');

select * from employees
where first_name IS NULL;

SELECT
	store_location,
    CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2), 'K') AS Total_Sales
From `coffee sales`
WHERE MONTH(transaction_date) = 5 -- May
GROUP BY store_location
ORDER BY(unit_price * transaction_qty) DESC

SELECT AVG(unit_price * transaction_qty) as Avg_Sales
From `coffee sales`
Where MONTH(transaction_date) = 5

SELECT
	AVG(total_sales) AS Avg_Sales
From
	(
    SELECT SUM(unit_price * transaction_qty) AS total_sales
    From `coffee sales`
    WHERE MONTH (transaction_date) = 5
    GROUP BY transaction_date
    ) AS Internal_query

SELECT
	DAY(transaction_date) AS day_of_monnth,
    SUM(unit_price * transaction_qty) As Total_sales
From `coffee sales`
WHERE MONTH (transaction_date) = 5
GROUP BY DAY (transaction_date)
ORDER BY DAY (transaction_date)

SELECT
	day_of_month,
    CASE
		WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
	END AS sales_status,
    total_sales
FROM (
	SELECT 
		DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
		FROM
			`coffee sales`
		WHERE
			MONTH(transaction_date) = 5 
		GROUP BY 
			DAY(transaction_date)
	) AS sales_data
    Order BY
		Day_of_month;


