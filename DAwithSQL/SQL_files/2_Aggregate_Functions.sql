--SQL Server Aggregate Functions
--COUNT exaple

select count(*)
--select *
from production.products
where list_price > 500;

create table tab(
val int
);

insert into tab(val)
values(1), (2), (2), (3), (null), (null), (4), (5)

select * from tab;

select count(*) from tab;

select count(distinct val) from tab;

select count(val) from tab;

select *
from production.products p
inner join production.categories c
on p.category_id = c.category_id;

select c.category_name, count(product_name) nu_of_product
from production.products p
inner join production.categories c
on p.category_id = c.category_id
group by category_name;

select c.category_name, count(product_name) nu_of_product
from production.products p
inner join production.categories c
on p.category_id = c.category_id
group by category_name
having count(product_name) > 30
order by nu_of_product desc;

select brand_name, count(*) nu_of_product
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
group by brand_name
having count(*) > 20
order by nu_of_product desc;

select brand_name, count(*) nu_of_product
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
where brand_name = 'Electra'
group by brand_name
having count(*) > 20
order by nu_of_product desc;

--MAX/MIN example

select max(list_price) max_price
from production.products

select *
from production.products
where list_price = 11999.99

select *
from production.products
where list_price = (select max(list_price) max_price
from production.products);

select brand_name, max(list_price) as max_price
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
group by brand_name

select brand_name, max(list_price) as max_price
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
group by brand_name
having max(list_price) >1000


select top 1 brand_name, min(list_price) as min_price
from production.products p
inner join production.brands b
on p.brand_id = b.brand_id
group by brand_name
order by min_price asc

select min(list_price) from production.products

select * from production.products p
where p.list_price = (select min(list_price) from production.products)

select category_name, min(list_price) as min_price 
from production.products p
inner join production.categories c
on p.category_id = c.category_id
group by c.category_name

--SUM example

select sum(quantity)
from production.stocks

select sum(quantity) from production.stocks

select product_id, sum(quantity) stock_count
from production.stocks
group by product_id 

select store_id, product_id, sum(quantity) stock_count
from production.stocks
group by store_id, product_id 

select store_name, sum(quantity) store_count
from production.stocks s
inner join sales.stores t
on s.store_id = t.store_id
group by store_name 

select * from production.stocks;

select * from sales.stores;

select order_id, sum(quantity*list_price) total_order_price
from sales.order_items
group by order_id

select order_id, sum(quantity*list_price) total_order_price, sum(discount) total_discount
from sales.order_items
group by order_id

select order_id, sum(quantity*list_price*(1-discount)) total_order_price
from sales.order_items
group by order_id

select * from sales.order_items;

--AVG example

select avg(list_price)
from production.products

select category_name, avg(list_price)
from production.products p
inner join production.categories c
on p.category_id = c.category_id
group by category_name

--ROUND and CAST example

--decimal(20,2) 2virgülden öce 20, sonra 2 rakam

select round(avg(list_price),2) from production.products

select cast(round(avg(list_price),2) as dec(10,2)) from production.products

--STDEV example

select MAX(list_price), MIN(list_price), STDEV(list_price) from production.products;




