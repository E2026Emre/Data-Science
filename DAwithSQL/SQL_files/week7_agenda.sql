--1. Find the customers who placed at least two orders per year.

alter view view1 as
select distinct customer_id, year(order_date) as orderdate,
count(order_id) over (partition by customer_id, year(order_date) order by customer_id) as num_of_order
from [sales].[orders]

select customer_id, orderdate, num_of_order
from view1
where num_of_order > 1

SELECT
customer_id, year(order_date), COUNT (order_id) order_count
FROM
sales.orders
GROUP BY
[customer_id], YEAR (order_date)
HAVING
COUNT([order_id]) > = 2
ORDER BY
    customer_id;

select *
from (
	select distinct customer_id, year(order_date) as orderdate,
	count(order_id) over (partition by customer_id, year(order_date) order by customer_id) as num_of_order
	from [sales].[orders]
	) a
where a.num_of_order>1

/*2. Find the total amount of each order which are placed in 2018.
     Then categorize them according to limits stated below.(You can use case when statements here)

    If the total amount of order    
        
        less then 500 then "very low"
        between 500 - 1000 then "low"
        between 1000 - 5000 then "medium"
        between 5000 - 10000 then "high"
        more then 10000 then "very high" 
*/
select s.order_id, sum((s.list_price - s.list_price * s.discount)*quantity) as total_amount,
	case 
		when  sum((s.list_price - s.list_price * s.discount)*quantity) < 500 then 'very low'
		when  sum((s.list_price - s.list_price * s.discount)*quantity) between 500 and 1000 then 'low'
		when  sum((s.list_price - s.list_price * s.discount)*quantity) between 1001 and 5000 then 'medium'
		when  sum((s.list_price - s.list_price * s.discount)*quantity) between 5001 and 10000 then 'high'
		when  sum((s.list_price - s.list_price * s.discount)*quantity) > 10000 then 'very high'
	end as category
from [sales].[order_items] s
join [sales].[orders] o on s.order_id = o.order_id
where year(o.order_date) = '2018' 
group by s.order_id
order by total_amount

select [order_id],
       sum(sales_price) as sales_price ,
       sales_status = case when sum(sales_price) < 500 then ‘very low’
	                       when sum(sales_price) between 500 and 1000  then ‘low’
						   when sum(sales_price) between 1000 and 5000  then ‘medium’
						   when sum(sales_price) between 5000 and 10000  then ‘high’
						   when sum(sales_price) > 10000  then ‘very high’
						else ‘NA’
	   end
from
(
select *, sales_price = [list_price]*(1- [discount])
from[sales].[order_items]
) a
group by [order_id]
select[order_id], sum([list_price]*(1- [discount]) )
from[sales].[order_items]
group by [order_id]

--3. By using Exists Statement find all customers who have placed more than two orders.

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers c
WHERE
    EXISTS (
        SELECT
            COUNT (*)
        FROM
            sales.orders o
        WHERE
            customer_id = c.customer_id
        GROUP BY
            customer_id
        HAVING
            COUNT (*) > 2
    )
ORDER BY
    first_name,
    last_name;

select customer_id, count(order_id) as num_of_orders
from [sales].[orders]
group by customer_id
having count(order_id) > 2

--4. Show all the products and their list price, that were sold with more than two units in a sales order.

select *
from(
	select o.order_id, p.product_id, p.list_price,
	count(o.item_id) over (partition by o.order_id order by o.order_id) as num_of_unit
	from [production].[products] p
	join [sales].[order_items] o on p.product_id = o.product_id) a
where a.num_of_unit > 2


SELECT so.[order_id], [list_price], [product_id]
FROM [sales].[order_items] so
INNER JOIN (
			select [order_id], count([order_id]) as [order_count]
			FROM [sales].[order_items] so
			GROUP BY so.[order_id]
			having count([order_id])>2
			) a
ON a.order_id = so.order_id


--5. Show the total count of orders per product for all times.
--   (Every product will be shown in one line and the total order count will be shown besides it)

select distinct p.product_id,
		count(o.order_id) over (partition by p.product_id order by p.product_id) as num_of_order,
		sum(o.quantity) over (partition by p.product_id order by p.product_id) as num_of_quantity,
		sum(o.list_price - o.list_price * o.discount) over (partition by p.product_id order by p.product_id) as total_price
from [production].[products] p
join [sales].[order_items] o on p.product_id = o.product_id
order by p.product_id

SELECT
    p.product_id,
    count(distinct order_id) aa
	FROM
    production.products p
JOIN sales.order_items o ON o.product_id = p.product_id
group by
p.product_id
ORDER BY
    aa;

--6. Find the products whose list prices are more than the average list price of products of all brands

select * --according to brands 
from(
	select brand_id, product_id, list_price,
	avg(list_price) over (partition by brand_id order by brand_id) as avg_price
	from [production].[products]) a
where list_price > avg_price


select product_id, list_price  -- --according to all products 
from [production].[products]
where list_price > 2500 (
					select avg(list_price) 
					from [production].[products])
