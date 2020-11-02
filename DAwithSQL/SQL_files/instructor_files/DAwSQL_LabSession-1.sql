
-- LAB-1 DB 2 Oktober
 --Now the total orders quantity using thes two tables ne kadar siparis alimisim
 select SUM([OrderQuantity]) as [total orders quantity]
 ,cast([OrderDate] as date) [OrderDate]
 ,[EnglishProductName] [Product]
 from [dbo].[FactInternetSales] s
 inner join [dbo].[DimDate] d
 on d.DateKey=s.OrderDateKey
 inner join [dbo].[DimProduct] p
 on p.[ProductKey]=s.ProductKey
 group by cast([OrderDate] as date),[EnglishProductName]
 order by 1 desc --asc
 ----------------------
 -- Now how to find the total sales quantity of each year
 select SUM([OrderQuantity]) as [total orders quantity]
 ,year(s.DueDate) [sales year]
 from [dbo].[FactInternetSales] s
inner join [dbo].[DimDate] d
on d.DateKey=s.DueDateKey
group by year(s.DueDate)
having SUM([OrderQuantity])>2000
order by 1 desc


--Ranking data and partition
--row number
--rank
--dense rank
--ntile
--row number
-- select the sales year, total sales quantity from sales by year
-- sales by year make this as view
create view [sales by year]
as
select YEAR(s.[DueDate]) [sales year],[EnglishProductName]as[ProductName]
,[Color],[Size],[Style],[EnglishProductSubcategoryName] [CategoryName]
,SUM(s.[OrderQuantity]) as [Number of Sales]
from [dbo].[FactInternetSales] s
inner join [dbo].[DimProduct] p
on p.ProductKey= s.ProductKey
inner join [dbo].[DimProductSubcategory] pc
on pc.[ProductSubcategoryKey]=p.[ProductSubcategoryKey]
group by YEAR(s.[DueDate]),[EnglishProductName]
,[Color],[Size],[Style],[EnglishProductSubcategoryName]
select [sales year],[Number of Sales]
,row_number() over(order by [Number of Sales]) [row number]
from dbo.[sales by year]
order by 3,1