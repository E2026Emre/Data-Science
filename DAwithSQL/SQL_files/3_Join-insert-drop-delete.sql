-- SQL JOIN

select [product_name], [model_year], [list_price], [category_name]
from [production].[products] as pp
inner join
[production].[categories] as pc
on pp.category_id = pc.category_id

---------------------
select [product_name], [model_year], [list_price], [category_name]
from [production].[products] as pp
left join
[production].[categories] as pc
on pp.category_id = pc.category_id

--------------------
select [product_name], [model_year], [list_price], [category_name]
from [production].[products] as pp
right join
[production].[categories] as pc
on pp.category_id = pc.category_id

---------------------------
select [product_name], [model_year], [list_price], [category_name]
from [production].[products] as pp
inner join
[production].[categories] as pc
on pp.category_id = pc.category_id
inner join [production].[brands] as pb
on pp.[brand_id] = pb.[brand_id]
where pp.[brand_id] = 5
order by [product_name] desc

--insert, update, delete
--table creation as promotions
create table sales.promotions
(
promotion_id int primary key identity(1,1) not null,
promotion_name varchar(30) not null,
discount numeric(3,2) default 0, 
[start_date] date not null,
expire_date date not null
)
-------
select*from [sales].[promotions]

--------
insert into [sales].[promotions] ([promotion_name], [discount], [start_date], [expire_date])
values('2020 summer promo', 0.25, '20201025', '20201104')

insert into [sales].[promotions] ([promotion_name], [start_date], [expire_date])
values('2020 winter promo', '20201125', '20201210')

------------
drop table [sales].[promotions]

-----------
update [sales].[promotions]
set discount=0.10
where promotion_name = '2020 summer promo'

update [sales].[promotions]
set discount=0.05
where promotion_name = '2020 winter promo'

--multiple column update
update [sales].[promotions]
set discount=0.45,
[promotion_name] ='2020 summer çýlgýn pro'
where promotion_name = '2020 winter promo'

--delete, truncate table: tablodaki tüm datayý siler ve trans
--log'a kayýt atmaz

delete from [sales].[promotions]
where [promotion_name] ='2020 summer çýlgýn pro'


delete from [sales].[promotions] -- tablodaki tüm veriyi siler