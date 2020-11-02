--String Functions

/*
char(8 bit), nchar(16 bit)
varchar(8 bit), nvarchar(16 bit)
text(8 bit), ntext(16 bit)
*/

select datalength(N'This one is a unicode string')
select datalength('This is not a unicode string')

-- ASCII Function to get the ASCII code of a character

select nchar(0x20Ac) [sign], 'Euro' [currency] --€
select nchar(0xA3) [sign], 'pound' [currency] --£

--CHARINDEX Function

select charindex('/','SQL Server/charindex')

select charindex('SERVER','SQL Server charindex' COLLATE Latin1_General_CS_AS) pos
select charindex('SERVER','SQL Server charindex' COLLATE Latin1_General_CI_AS) pos

select charindex('is','This is a my sister', 5) start_at_fifth,
	   charindex('is','This is a my sister', 10) start_at_tenth
 
--Homework:
-- Write a simple T-SQL routine which splits delimited string into a table
--usage: give your routine a name


--SQL Server CONCAT()
SELECT
    'John' + '' + 'Doe' AS full_name;
	--Using CONCAT() function with NULL
SELECT
    CONCAT(
       -- CHAR(13),
        CONCAT(first_name,' ',last_name),
        --CHAR(13),
        phone,
        --CHAR(13),
        CONCAT(city,' ',state),
        CHAR(13),
        zip_code
    ) customer_address
FROM
    sales.customers
ORDER BY
    first_name,
    last_name;


