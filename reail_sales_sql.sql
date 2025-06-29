create database sql_project_s1;
use sql_project_s1;

create table retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar(15),
age	int,
category varchar(15),	
quantiy	int,
price_per_unit	int,
cogs int,
total_sale int
);


select * from retail_sales;


SELECT * FROM Retail_sales
where transactions_id is null
or
sale_date is null 
or
sale_time is null 
or
customer_id	is null 
or
gender is null 
or
age	is null 
or
category is null 
or
quantiy	is null 
or
price_per_unit	is null 
or
cogs is null 
or
total_sale is null;


delete from retail_sales
where transactions_id is null
or
sale_date is null 
or
sale_time is null 
or
customer_id	is null 
or
gender is null 
or
age	is null 
or
category is null 
or
quantiy	is null 
or
price_per_unit	is null 
or
cogs is null 
or
total_sale is null;



select count(*) as total_sale from retail_sales;

select count(distinct customer_id) from retail_sales;

select distinct category from retail_sales;


-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';


-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is less than 4 in the month of Nov-2022:

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'clothing'
        AND MONTH(sale_date) = 11
        AND YEAR(sale_date) = 2022
        AND quantiy < 4;


-- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category, SUM(total_sale) AS total_sale
FROM
    retail_sales
GROUP BY category;


-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:


SELECT 
    category, ROUND(AVG(age), 2) AS avg_age
FROM
    retail_sales
WHERE
    category = 'beauty';


-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
    
    
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:


SELECT 
    category, gender, COUNT(*) AS total_order
FROM
    retail_sales
GROUP BY 1 , 2
ORDER BY 1;


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select * from (
	select 
	year(sale_date) as year,
	month(sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() over(partition by year(sale_date) order by avg(total_sale) desc) as srank
	from retail_sales
	group by year,month) 
    as t1
where srank = 1;


-- Write a SQL query to find the top 5 customers based on the highest total sales :

SELECT 
    customer_id, SUM(total_sale) AS total_sale
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;


-- Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT DISTINCT
    category, COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail_sales
GROUP BY 1;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with hourly_sale
as
	(select *,
		case
		when hour(sale_time) <12 then 'Morning'
		when hour(sale_time) between 12 and 17 then 'Afternoon'
		when hour(sale_time) >17 then 'Evening'
		end as shift
	from retail_sales)
select shift, count(*) as total_orders from hourly_sale
group by shift;



select 
if(hour(sale_time) <12, 'Morning',
if(hour(sale_time) between 12 and 17, 'Afternoon', 'Evening')) as shift,
count(*) as total_order
from retail_sales
group by shift;
