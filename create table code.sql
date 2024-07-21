-- Create database
create database if not exists walmart;
use walmart;
-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
select * from sales;
-- -------feature enginerring -------------
select time,
	(
    case
		when time between "00-00-00" and "12-00-00" then "Morning"
        when time between "12-01-00" and "16-00-00" then "Afternoon"
        else "Evening"
    end 
    ) as time_of_date
from sales;

SELECT date,
(
    CASE 
        WHEN DAYOFWEEK(date) = 1 THEN 'Sun'
        WHEN DAYOFWEEK(date) = 2 THEN 'Mon'
        WHEN DAYOFWEEK(date) = 3 THEN 'Tue'
        WHEN DAYOFWEEK(date) = 4 THEN 'Wed'
        WHEN DAYOFWEEK(date) = 5 THEN 'Thu'
        WHEN DAYOFWEEK(date) = 6 THEN 'Fri'
        WHEN DAYOFWEEK(date) = 7 THEN 'Sat'
    END
) AS day_name
FROM sales;

select date,
dayname(date)
from sales;


