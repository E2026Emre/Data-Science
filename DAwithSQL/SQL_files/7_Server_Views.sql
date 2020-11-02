-- SQL Server Views

select *
from [production].[products] p
inner join [production].[brands] b
on p.brand_id = b.brand_id

select product_name, brand_name, list_price
from [production].[products] p
inner join [production].[brands] b
on p.brand_id = b.brand_id

create view sales.product_info
as
select product_name, brand_name, list_price
from [production].[products] p
inner join [production].[brands] b
on p.brand_id = b.brand_id

select * from sales.product_info

select *
from(
select product_name, brand_name, list_price
from [production].[products] p
inner join [production].[brands] b
on p.brand_id = b.brand_id) product_info2;

create view sales.daily_sales
as
select order_date as OrderDate, p.product_id as ProductCode, quantity as Quantity, i.list_price as Price
from sales.orders as o
inner join sales.order_items as i
on o.order_id = i.order_id
inner join production.products as p
on p.product_id = i.product_id

select * from sales.daily_sales

select OrderDate, ProductCode, Price
from sales.daily_sales
where ProductCode = 20
order by 1;

drop view sales.daily_sales;
drop view sales.product_info;

exec sp_rename 'sales.daily_sales', 'sales'


