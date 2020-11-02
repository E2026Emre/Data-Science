--subquarry, union, synonom, cas

use BikeStores

--select all customers in NY who made at least one order (firstname, lastname, orderdate)

select c.first_name, c.last_name, o.order_date
from sales.customers c
inner join sales.orders o
on c.customer_id = o.customer_id
where c.customer_id in
		(select customer_id
		from sales.customers
		where city='New York')
order by o.order_date

select c.first_name, c.last_name, o.order_date --- ikisi de ayný sonucu verir.
from sales.customers c
inner join sales.orders o
on c.customer_id = o.customer_id
where c.city='New York'


select c.first_name, c.last_name, o.order_date, count(o.order_date) as number_of_orders
from sales.customers c
inner join sales.orders o
on c.customer_id = o.customer_id
where c.customer_id in
		(select customer_id
		from sales.customers
		where city='New York')
group by c.first_name, c.last_name, o.order_date
order by 4;

select [first_name], [last_name],count(c.[customer_id]) numberOforders
from [sales].[customers] c
join [sales].[orders] o
on c.customer_id = o.customer_id
where c.customer_id in
(select [customer_id]
from [sales].[customers]
where city = 'New York')
group by [first_name], [last_name]
order by 3 desc

--select al products where list price is greater than avg list price of Strider and Trek

select [product_name], [list_price] from [production].[products]
where [list_price] > (
		select avg([list_price]) from [production].[products]
		where [brand_id] in (
				select [brand_id]
				from [production].[brands]
				where [brand_name] in ('Strider', 'Trek')))
order by [list_price] desc;

--Show the difference between the product price and the avg product price

select [product_name],
		[list_price] - (select avg([list_price]) from [production].[products]) as [price diff]
from [production].[products]

--homework
--Show the list price compared to the average for that category.

select [product_name],
		[list_price] - (
						select avg(p.[list_price])
						from [production].[products] p
						inner join [production].[categories] c
						on p.category_id = c.category_id
						group by c.[category_name]) as [price diff]
from [production].[products]



select
	[product_name],
	[list_price]-(select Avg([list_price]) from [production].[products])
from [production].[products] p
inner join [production].[categories] c
on p.category_id=c.category_id

--exists in subquery
--select [order_date] from [sales].[orders]
select [customer_id],[first_name], [last_name], [email], [city]
from [sales].[customers]
where exists (
		select c.[customer_id]
		from [sales].[customers] c
		inner join [sales].[orders] o
		on c.customer_id = o.customer_id
		where year([order_date]) = 2016
		)

select [customer_id],[first_name], [last_name], [email], [city]
from [sales].[customers] c
where exists (
		select *
		from [sales].[orders] o
		where year([order_date]) = 2016 and
		c.customer_id = o.customer_id
		)

--en fazla ortalama  order yapan personel listesi
select t.[full_name], max(t.order_count) [max order by person]
from
		(
		SELECT [first_name]+' ' + [last_name] [full_name],
		COUNT(order_id) [order_count]
		FROM [sales].[orders] o
		inner join [sales].[staffs] s
		on s.staff_id = o.staff_id
		GROUP BY [first_name]+' ' + [last_name]
		) t
group by t.[full_name]
order by 2 desc;

--union

select [first_name], [last_name], 'staff' [type]
from [sales].[staffs]
union all												-- all dersek hepsini, demezsek distinct olarak getirir.
select [first_name], [last_name], 'customer' [type]
from [sales].[customers]
order by [first_name], [last_name]

select [first_name]+' '+[last_name], 'staff' [type]
from [sales].[staffs]
union all												-- all dersek hepsini, demezsek distinct olarak getirir.
select [first_name]+' '+[last_name], 'customer' [type]
from [sales].[customers]
order by 1;

--Synonym
-- Baþka database ulaþmak için isim yazýp ona ulaþmaya çalýþýyorum
CREATE SYNONYM orders for [sales].[orders]
-- Bunu çalýþtýrdýðýmda bir daha [sales].[orders] yazmama gerek yok
-- Bundan sonra orders diyerek çaðýrabiliriz.
-- Database kýsmýnda Synonyms dosyasýnýn içinden görebilirsin
-- Bunlarý genelde baþka database deki order a ulaþmak için kullanýyoruz


create SYNONYM orders for [sales].[orders]

select * from orders

--create database
create database food
on
(
Name=FoodData1,
FileName='E:\IT KURS\DATA SCÝENCE\DA with SQL\FoodData1.mdf',
size=10MB, --KB, MB,GB,TB
maxsize=unlimited,
filegrowth= 1GB
)
log on
(
Name=FoodLog,
FileName='E:\IT KURS\DATA SCÝENCE\DA with SQL\FoodLog1.ldf',
size=10MB, --KB, MB, GB,TB
maxsize=unlimited,
filegrowth= 1024MB
)

create table snack
( [snack name] varchar(50),
   [amount] int,
   [calories] int
)
select * from snack

insert [snack]
select 'Cholote Raisins',10,100
insert [snack]
select 'Honeycomb',10,15

create database food2

use food2

create synonym snack for food.dbo.snack		-- food database'indeki bir tabloya food2 database'inde snonym yaptýk

select * from snack

---CASE

select 
case [order_status]
	when 1 then 'Pending'
	when 2 then 'Processing'
	when 3 then 'Rejected'
	when 4 then 'Completed'
End [order_status],
count([order_id]) [order count]
from [sales].[orders]
--where year([order_date])=2017
group by [order_status]
order by 2 desc;
