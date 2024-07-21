SELECT * FROM walmart.sales;

alter table sales
add column time_of_date varchar(10);

update sales
set time_of_date = (
	case
		when time between "00:00:00" and "12:00:00" then "Morning"
        when time between "12:01:00" and "16:00:00" then "Afternoon"
        else "Evening"
	end
);

alter table sales
add column day_name varchar(10);

update sales
set day_name =( case
		WHEN DAYOFWEEK(date) = 1 THEN 'Sun'
        WHEN DAYOFWEEK(date) = 2 THEN 'Mon'
        WHEN DAYOFWEEK(date) = 3 THEN 'Tue'
        WHEN DAYOFWEEK(date) = 4 THEN 'Wed'
        WHEN DAYOFWEEK(date) = 5 THEN 'Thu'
        WHEN DAYOFWEEK(date) = 6 THEN 'Fri'
        WHEN DAYOFWEEK(date) = 7 THEN 'Sat'
    END);
    
select * from sales;

alter table sales
add column month_name varchar(10);

update sales
set month_name = monthname(date);

ALTER TABLE sales
DROP COLUMN day_name;

update sales
set day_name = dayname(date);

-- Generic Question 
-- How many unique cities does the data have?
-- answer : total 3
-- 	-Yangon
--     -Naypyitaw
--     -Mandalay
select count(distinct city)
from sales;

select distinct city
from sales;

-- 2.In which city is each branch?
-- answer: Yangon = 339
-- 		Naypyitaw = 327
--         Mandalay  = 329

               -- Product
-- 1. How many unique product lines does the data have?
select count(distinct product_line) from
sales;
-- answer = 6  
select distinct product_line from
sales;

-- 2. What is the most common payment method?
select payment,count(payment) total_payment
 from sales
 group by payment
 order by total_payment desc;
 
 -- 3.What is the most selling product line?
select product_line,sum(unit_price * quantity) as total_amount
from sales
group by product_line
order by total_amount desc
limit 5;

-- 4.What is the total revenue by month?
select month_name, sum(unit_price * quantity) as revenue
from sales
group by month_name
order by revenue desc;

-- 5.What month had the largest COGS?
select month_name,max(cogs) max_cogs from 
sales
group by month_name
order by max_cogs desc;

select product_line,sum(unit_price * quantity) as revenue, max(cogs) as max_cogs
from sales
group by product_line
order by revenue desc, max_cogs desc;

-- 6. What product line had the largest revenue?
select product_line,sum(unit_price * quantity) as revenue
from sales
group by product_line
order by revenue desc;

-- 7. What is the city with the largest revenue?
select city,sum(unit_price * quantity) as revenue
from sales
group by city
order by revenue desc;

-- 8.What product line had the largest VAT?

select product_line, sum(cogs * 0.05) as largest_VAT
from sales
group by product_line
order by largest_VAT DESC
LIMIT 1;
-- ---------------------------- ****---------------------
SELECT
	product_line,
	AVG(tax_pct) as avg_tax
FROM sales
GROUP BY product_line
ORDER BY avg_tax DESC;
-- 9.Fetch each product line and add a column to those product line showing "Good", "Bad". 
-- Good if its greater than average sales
SELECT * FROM SALES;
select avg(quantity) from
sales;

select product_line,
	case 
		when avg(quantity) > 6 then "Good"
        else "Bad"
	end as remark
from sales
group by product_line;

-- Which branch sold more products than average product sold?

select avg(quantity)
from sales;

select branch,
    sum(quantity) as qnty
from sales  
group by branch
having sum(quantity) > (select avg(quantity) from sales);