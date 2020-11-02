CREATE DATABASE stock_market;
ALTER DATABASE stock_market SET RECOVERY SIMPLE WITH NO_WAIT;
GO
USE stock_market
GO
--create stock market data
CREATE TABLE stocks(tickersymbol VARCHAR(4));
INSERT INTO stocks (tickersymbol)
SELECT TOP(999) 'X' + CAST(ROW_NUMBER() OVER(ORDER BY A.name) AS VARCHAR)
FROM sys.objects AS A
CROSS JOIN sys.objects AS B;
select * from stocks
CREATE TABLE dates(tradedate DATE);
WITH
AllDates AS (
	SELECT TOP(1000) DATEADD(d,ROW_NUMBER() OVER(ORDER BY A.name),'2013-01-01') AS TradeDate
	FROM sys.objects AS A
	CROSS JOIN sys.objects AS B),
 FilterOutWeekends AS (
	SELECT TradeDate
	FROM AllDates
	WHERE DATENAME( WEEKDAY,TradeDate) NOT IN ('Saturday','Sunday')
	),
FilterOutHolidays AS (
	SELECT TradeDate
	FROM FilterOutWeekends
	WHERE FORMAT(TradeDate,'mm/dd') NOT IN('01/01','12/25','07/04')
		AND TradeDate NOT IN (
			'2013-01-21','2013-02-18','2013-03-29','2013-05-27','2013-09-02','2013-11-28',
			'2014-01-20','2014-02-17','2014-04-18','2014-05-26','2014-09-01','2014-11-27',
			'2015-01-19','2015-02-16','2015-04-03','2015-05-25','2015-07-03','2015-09-07','2015-11-26')
	)
INSERT INTO dates( tradedate )
SELECT TradeDate
FROM FilterOutHolidays;
select * from 	dates
CREATE TABLE StockHistory(TickerSymbol VARCHAR(4), TradeDate DATE, ClosePrice DECIMAL(5,2));
INSERT INTO StockHistory
        ( TickerSymbol ,
          TradeDate ,
          ClosePrice
        )
SELECT TickerSymbol, '2013-01-02', CAST(RAND(CAST(NEWID() AS VARBINARY)) * 100 AS DECIMAL(5,2))
FROM Stocks;
DECLARE @CurrentDate AS DATE
DECLARE @PrevDate AS DATE
DECLARE DATES CURSOR FAST_FORWARD FOR SELECT TradeDate FROM Dates ORDER BY TradeDate;
OPEN DATES;
FETCH NEXT FROM DATES INTO @PrevDate;
FETCH NEXT FROM DATES INTO @CurrentDate
WHILE @@FETCH_STATUS = 0 BEGIN
	INSERT INTO StockHistory
	        ( TickerSymbol ,
	          TradeDate ,
	          ClosePrice
	        )
	SELECT TickerSymbol, @CurrentDate,
		ClosePrice + CASE WHEN CAST(RAND(CAST(NEWID() AS VARBINARY)) * 10 AS TINYINT)%2 = 0 THEN -1 ELSE 1 END *   CAST(RAND(CAST(NEWID() AS VARBINARY)) AS DECIMAL(5,2))
	FROM StockHistory
	WHERE TradeDate = @PrevDate;
	SET @PrevDate = @CurrentDate;
	FETCH NEXT FROM DATES INTO @CurrentDate;
END;
CLOSE DATES;
DEALLOCATE dates;
CREATE NONCLUSTERED INDEX ix_StockHistory ON dbo.StockHistory (TickerSymbol,TradeDate) INCLUDE(ClosePrice);
GO
IF OBJECT_ID('Islands') IS NOT NULL DROP TABLE Islands;
CREATE TABLE Islands(ID INT NOT NULL IDENTITY PRIMARY KEY, OrderDate DATE);
INSERT INTO Islands(OrderDate)
SELECT TOP(30) DATEADD(d,ROW_NUMBER() OVER(ORDER BY name),'2015-01-01')
FROM sys.objects A;
INSERT INTO Islands(OrderDate)
VALUES('2015-01-01'),('2015-01-01'),
	('2015-01-06'),('2015-01-07');
DELETE Islands
WHERE ID IN (4,5,12,13,24,25,26);
--Duplicates
IF OBJECT_ID('usp_CreateDuplicates') IS NOT NULL
	DROP PROC usp_CreateDuplicates;
GO
CREATE PROC usp_CreateDuplicates AS
	IF OBJECT_ID('Duplicates') IS NOT NULL
		DROP TABLE Duplicates;
	CREATE TABLE Duplicates(
		ID INT, Val1 VARCHAR(50), Val2 VARCHAR(50));
	
	INSERT INTO Duplicates
		(ID, Val1, Val2)
	SELECT TOP(30) ROW_NUMBER() OVER(ORDER BY name),
		name, [type]
	FROM sys.objects
	UNION ALL
	SELECT TOP(5) 1, 'ABC','ABC'
	FROM sys.objects
	UNION ALL
	SELECT TOP(3) 2, 'DEF','ABC'
	FROM sys.objects
	UNION ALL
	SELECT TOP(5) 4, 'DEF','ABC'
	FROM sys.objects;
GO