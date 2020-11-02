--SQL Server Data Functions

select SYSDATETIME() --2020-10-03 18:03:44.9447129
select GETUTCDATE()  --2020-10-03 15:03:44.943

select getdate()     --2020-10-03 18:04:26.260

select getdate() get_date, sysdatetime() sys_date 

select convert(char(20), sysdatetimeoffset(),113)

select len(convert(char(20), sysdatetimeoffset(),113))

select convert(char(20), getdate(),112)
select convert(char(20), getdate(),113)
select convert(char(20), sysdatetime(),113)     ---Buradaki 112,113 gibi deðerler time için formatý belirliyor.

--is UTC

select convert(date, sysutcdatetime()) utc_date

SELECT DATENAME (YEAR,GETDATE())
SELECT DATENAME (quarter,GETDATE()) --
SELECT DATENAME (MONTH,GETDATE()) --
SELECT DATENAME (dayofyear,GETDATE()) --
SELECT DATENAME (DAY,GETDATE()) --
SELECT DATENAME (week,GETDATE()) --
SELECT DATENAME (weekday,GETDATE()) --
SELECT DATENAME (hour,GETDATE()) --

--dateadd, datediff

--DATEADD
	    SELECT '2007-01-01 00:00:00', DATEADD(YEAR,10,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(quarter,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(MONTH,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(dayofyear,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(DAY,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(week,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(weekday,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(hour,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(minute,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(second ,100,'2007-01-01 00:00:00.000')
     	SELECT '2007-01-01 00:00:00', DATEADD(millisecond,100,'2007-01-01 00:00:00.000')

--datediff

	SELECT DATEDIFF(DAY,'15 jul  2016','1 feb  2020')
    SELECT DATEDIFF(HOUR,'1 feb  2008','1 mar 2008') --29must be a leap year!

--Formatting Dates

SELECT DATENAME(dw,GETDATE()) --To get the full Weekday name
SELECT LEFT(DATENAME(dw,GETDATE()),3) --abbreviated Weekday name (MON, TUE, WED etc)
SELECT DATEPART(dw,GETDATE())+(((@@Datefirst+3)%7)-4) --ISO-8601 Weekday number
SELECT RIGHT('00' + CAST(DAY(GETDATE()) AS VARCHAR),2)--Day of month -- leading zeros
SELECT CAST(DAY(GETDATE()) AS VARCHAR) --Day of the month without leading space
SELECT DATEPART(dy,GETDATE()) --day of the year
SELECT DATEPART(dw,GETDATE())

SELECT DATEADD(hour,2,GETDATE())
SELECT DATEADD(MONTH,1,GETDATE()) --2020-11-03 17:24:50.810
SELECT DATEADD(MONTH,-1,GETDATE())--2020-09-03 17:25:30.740

--homework

--first sunday next month
SELECT DATEADD(DAY,8-DATEPART(WEEKDAY,DATEADD(DAY,1,GETDATE())),EOMONTH(GETDATE())) AS [First Sunday] 


--how you calculate Easter date for a given date
