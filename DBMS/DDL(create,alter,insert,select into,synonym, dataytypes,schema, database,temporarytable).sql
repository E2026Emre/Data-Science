--SQL Server CREATE DATABASE statement

CREATE DATABASE database_name;

CREATE DATABASE TestDb;

SELECT      --halihazırdaki database'leri görmek için
    name
FROM 
    master.sys.databases
ORDER BY 
    name;

EXEC sp_databases; -- bu da aynı işe yarıyor

Creating a new database using SQL Server Management Studio
(Enter the name of the database e.g., SampleDb and click the OK button.)

C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA

***

--SQL Server DROP DATABASE statement to delete a database

DROP DATABASE  [ IF EXISTS ]
    database_name 
    [,database_name2,...];

DROP DATABASE IF EXISTS TestDb;

Using the SQL Server Management Studio to drop a database

***

--SQL Server CREATE SCHEMA statement

--CREATE SCHEMA schema_name
    --[AUTHORIZATION owner_name]

CREATE SCHEMA customer_services;

--Once you execute the statement, you can find the newly created schema under the Security > Schemas of the database name.

SELECT -- halihazırda mevcut schema'ları görmek için
    s.name AS schema_name, 
    u.name AS schema_owner
FROM 
    sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY 
    s.name;

CREATE TABLE customer_services.jobs(
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    created_at DATETIME2 NOT NULL
);

SQL Server provides us with some pre-defined schemas which have the same names as the built-in database users and roles,
for example: dbo, guest, sys, and INFORMATION_SCHEMA.

Security > Users

The default schema for a newly created database is dbo.

***

--SQL Server ALTER SCHEMA statement

ALTER SCHEMA target_schema_name   
    TRANSFER [ entity_type :: ] securable_name;

CREATE TABLE dbo.offices
(
    office_id      INT
    PRIMARY KEY IDENTITY, 
    office_name    NVARCHAR(40) NOT NULL, 
    office_address NVARCHAR(255) NOT NULL, 
    phone          VARCHAR(20),
);

INSERT INTO 
    dbo.offices(office_name, office_address)
VALUES
    ('Silicon Valley','400 North 1st Street, San Jose, CA 95130'),
    ('Sacramento','1070 River Dr., Sacramento, CA 95820');

select * from dbo.offices


ALTER SCHEMA sales TRANSFER OBJECT::dbo.offices;

create a stored procedure example ?

***

--SQL Server DROP SCHEMA statement

DROP SCHEMA [IF EXISTS] schema_name;

CREATE SCHEMA logistics;

CREATE TABLE logistics.deliveries
(
    order_id        INT
    PRIMARY KEY, 
    delivery_date   DATE NOT NULL, 
    delivery_status TINYINT NOT NULL
);

DROP SCHEMA logistics;

DROP TABLE logistics.deliveries;

DROP SCHEMA IF EXISTS logistics;

DROP TABLE [customer_services].[jobs];

DROP SCHEMA IF EXISTS [customer_services];


***

--SQL Server CREATE TABLE statement

CREATE TABLE [database_name.][schema_name.]table_name (
    pk_column data_type PRIMARY KEY,
    column_1 data_type NOT NULL,
    column_2 data_type,
    ...,
    table_constraints
);

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY (1, 1),
    first_name VARCHAR (50) NOT NULL,
    last_name VARCHAR (50) NOT NULL,
    visited_at DATETIME,
    phone VARCHAR(20),
    store_id INT NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);

***

--SQL Server ALTER TABLE ADD Column

ALTER TABLE table_name
ADD column_name data_type column_constraint;

CREATE TABLE sales.quotations (
    quotation_no INT IDENTITY PRIMARY KEY,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL
);

ALTER TABLE sales.quotations 
ADD description VARCHAR (255) NOT NULL;

DROP table sales.quotations;

drop table [sales].[promotions]

--Modify column’s data type

ALTER TABLE table_name 
ALTER COLUMN column_name new_data_type(size);

CREATE TABLE t1 (c INT);

INSERT INTO t1
VALUES (1),(2),(3);

select * from t1

ALTER TABLE t1 ALTER COLUMN c VARCHAR (2);

INSERT INTO t1
VALUES ('@');

ALTER TABLE t1 ALTER COLUMN c INT;

drop table t1

--Change the size of a column

CREATE TABLE t2 (c VARCHAR(10));

INSERT INTO t2
VALUES ('SQL Server'), ('Modify'), ('Column');

ALTER TABLE t2 ALTER COLUMN c VARCHAR (50);

drop table t2

***

--SQL Server ALTER TABLE DROP COLUMN

ALTER TABLE table_name
DROP COLUMN column_name;

CREATE TABLE sales.price_lists(
    product_id int,
    valid_from DATE,
    price DEC(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK(price >= 0),
    discount DEC(10,2) NOT NULL,
    surcharge DEC(10,2) NOT NULL,
    note VARCHAR(255),
    PRIMARY KEY(product_id, valid_from)
);

ALTER TABLE sales.price_lists
DROP COLUMN note;

ALTER TABLE sales.price_lists
DROP COLUMN price;

--To drop the price column, first, delete its CHECK constraint:

ALTER TABLE sales.price_lists
DROP CONSTRAINT ck_positive_price;

ALTER TABLE sales.price_lists
DROP COLUMN price;

drop table sales.price_lists

***

--adding computed columns to a table

ALTER TABLE table_name
ADD column_name AS expression [PERSISTED];

--defining computed columns when creating a new table

CREATE TABLE table_name(
    ...,
    column_name AS expression [PERSISTED],
    ...
)

CREATE TABLE persons
(
    person_id  INT PRIMARY KEY IDENTITY, 
    first_name NVARCHAR(100) NOT NULL, 
    last_name  NVARCHAR(100) NOT NULL, 
    dob        DATE
);

INSERT INTO 
    persons(first_name, last_name, dob)
VALUES
    ('John','Doe','1990-05-01'),
    ('Jane','Doe','1995-03-01');

SELECT
    person_id,
    first_name + ' ' + last_name AS full_name,
    dob
FROM
    persons
ORDER BY
    full_name;

ALTER TABLE persons
ADD full_name AS (first_name + ' ' + last_name);

SELECT 
    person_id, 
    full_name, 
    dob
FROM 
    persons
ORDER BY 
    full_name;

***

--SQL Rename table using Transact SQL

EXEC sp_rename 'old_table_name', 'new_table_name'

CREATE TABLE sales.contr (
    contract_no INT IDENTITY PRIMARY KEY,
    start_date DATE NOT NULL,
    expired_date DATE,
    customer_id INT,
    amount DECIMAL (10, 2)
);

EXEC sp_rename 'sales.contr', 'contracts';

***

--SQL Server DROP TABLE

DROP TABLE [IF EXISTS]  [database_name.][schema_name.]table_name;

DROP TABLE IF EXISTS sales.revenues;

CREATE TABLE sales.delivery (
    delivery_id INT PRIMARY KEY,
    delivery_note VARCHAR (255) NOT NULL,
    delivery_date DATE NOT NULL
);

DROP TABLE sales.delivery;

***

--SQL Server TRUNCATE TABLE statement, "delete" komutuyla aynı işi yapar ancak çok daha hızlı

TRUNCATE TABLE [database_name.][schema_name.]table_name;

CREATE TABLE sales.customer_groups (
    group_id INT PRIMARY KEY IDENTITY,
    group_name VARCHAR (50) NOT NULL
);

INSERT INTO sales.customer_groups (group_name)
VALUES ('Intercompany'), ('Third Party'), ('One time');

TRUNCATE TABLE sales.customer_groups;

(DELETE FROM sales.customer_groups;)

select * from [sales].[customer_groups]

drop table[sales].[customer_groups]
***

--Server IDENTITY column

IDENTITY[(seed,increment)]

IDENTITY(10,10)

CREATE SCHEMA hr;

CREATE TABLE hr.person (
    person_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NOT NULL
);

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('John','Doe', 'M');

SELECT @@IDENTITY --bu komutla en son identitiy değerini görebiliriz.

INSERT INTO hr.person(first_name, last_name, gender)
OUTPUT inserted.person_id
VALUES('Jane','Doe','F');

--Using of identity values (Transaction example) ?

***

--SQL Server PRIMARY KEY

CREATE TABLE table_name (
    pk_column data_type PRIMARY KEY,
    ...
);

CREATE TABLE table_name (
    pk_column_1 data_type,
    pk_column_2 data type,
    ...
    PRIMARY KEY (pk_column_1, pk_column_2)
);

CREATE TABLE sales.activities (
    activity_id INT PRIMARY KEY IDENTITY,
    activity_name VARCHAR (255) NOT NULL,
    activity_date DATE NOT NULL
);

CREATE TABLE sales.participants(
    activity_id int,
    customer_id int,
    PRIMARY KEY(activity_id, customer_id)
);

CREATE TABLE sales.events(
    event_id INT NOT NULL,
    event_name VARCHAR(255),
    start_date DATE NOT NULL,
    duration DEC(5,2)
);

ALTER TABLE sales.events 
ADD PRIMARY KEY(event_id);

***

--SQL Server FOREIGN KEY

CONSTRAINT fk_constraint_name 
FOREIGN KEY (column_1, column2,...)
REFERENCES parent_table_name(column1,column2,..)

CREATE TABLE vendor_groups (
    group_id INT IDENTITY PRIMARY KEY,
    group_name VARCHAR (100) NOT NULL
);

CREATE TABLE vendors (
        vendor_id INT IDENTITY PRIMARY KEY,
        vendor_name VARCHAR(100) NOT NULL,
        group_id INT NOT NULL,
        CONSTRAINT fk_group FOREIGN KEY (group_id) 
        REFERENCES vendor_groups(group_id)
);

INSERT INTO vendor_groups(group_name)
VALUES('Third-Party Vendors'), ('Interco Vendors'), ('One-time Vendors');

select * from vendor_groups
select * from vendors

INSERT INTO vendors(vendor_name, group_id)
VALUES('ABC Corp',1);

INSERT INTO vendors(vendor_name, group_id)
VALUES('XYZ Corp',4);

drop table vendors
drop table vendor_groups


--Referential actions

FOREIGN KEY (foreign_key_columns)
    REFERENCES parent_table(parent_key_columns)
    ON UPDATE action 
    ON DELETE action;

***

--SQL Server NOT NULL Constraint

CREATE SCHEMA hr;
GO

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20)
);

INSERT Hr.persons
values('ÖMER' , 'SÜMER', 'IS@GMAIL.COM', NULL)

SELECT * FROM hr.persons

--Add NOT NULL constraint to an existing column

UPDATE table_name
SET column_name = <value>
WHERE column_name IS NULL;

ALTER TABLE table_name
ALTER COLUMN column_name data_type NOT NULL;

ALTER TABLE hr.persons
ALTER COLUMN phone VARCHAR(20) NOT NULL;

UPDATE hr.persons
SET phone = '(408) 123 4567'
WHERE phone IS NULL;

SELECT * FROM hr.persons

--Removing NOT NULL constraint

ALTER TABLE table_name
ALTER COLUMN column_name data_type NULL;

ALTER TABLE hr.persons
ALTER COLUMN phone VARCHAR(20) NULL;

***

--SQL Server UNIQUE Constraint

CREATE SCHEMA hr;
GO

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE
);

CREATE TABLE hr.persons(
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE(email)
);

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('John','Doe','j.doe@bike.stores');

INSERT INTO hr.persons(first_name, last_name, email)
VALUES('Jane','Doe','j.doe@bike.stores');

drop table hr.persons

CREATE TABLE hr.persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    CONSTRAINT unique_email UNIQUE(email)
);

--UNIQUE constraint vs. PRIMARY KEY constraint

INSERT INTO hr.persons(first_name, last_name)
VALUES('John','Smith');

INSERT INTO hr.persons(first_name, last_name)
VALUES('Lily','Bush');


--UNIQUE constraints for a group of columns

CREATE TABLE table_name (
    key_column data_type PRIMARY KEY,
    column1 data_type,
    column2 data_type,
    column3 data_type,
    ...,
    UNIQUE (column1,column2)
);

CREATE TABLE hr.person_skills (
    id INT IDENTITY PRIMARY KEY,
    person_id int,
    skill_id int,
    updated_at DATETIME,
    UNIQUE (person_id, skill_id)
);

-Add UNIQUE constraints to existing columns

ALTER TABLE table_name
ADD CONSTRAINT constraint_name 
UNIQUE(column1, column2,...);

drop table hr.persons

CREATE TABLE hr.persons (
    person_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
); 

ALTER TABLE hr.persons
ADD CONSTRAINT unique_email UNIQUE(email);

ALTER TABLE hr.persons
ADD CONSTRAINT unique_phone UNIQUE(phone);

--Delete UNIQUE constraints

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

ALTER TABLE hr.persons
DROP CONSTRAINT unique_phone;

***

--SQL Server CHECK Constraint

CREATE SCHEMA test;
GO

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0)
);

drop table test.products

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CONSTRAINT positive_price CHECK(unit_price > 0)
);

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Free Bike', 0);

INSERT INTO test.products(product_name, unit_price)
VALUES ('Awesome Bike', 599);

--SQL Server CHECK constraint and NULL

INSERT INTO test.products(product_name, unit_price)
VALUES ('Another Awesome Bike', NULL);

--CHECK constraint referring to multiple columns

drop table test.products;

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) CHECK(unit_price > 0),
    discounted_price DEC(10,2) CHECK(discounted_price > 0),
    CHECK(discounted_price < unit_price)
);

drop table test.products;

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CHECK(discounted_price > unit_price)
);

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2),
    discounted_price DEC(10,2),
    CHECK(unit_price > 0),
    CHECK(discounted_price > 0),
    CONSTRAINT valid_prices CHECK(discounted_price > unit_price)
);

--Add CHECK constraints to an existing table

CREATE TABLE test.products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    unit_price DEC(10,2) NOT NULL
);

ALTER TABLE test.products
ADD CONSTRAINT positive_price CHECK(unit_price > 0);

ALTER TABLE test.products
ADD discounted_price DEC(10,2)
CHECK(discounted_price > 0);

ALTER TABLE test.products
ADD CONSTRAINT valid_price 
CHECK(unit_price > discounted_price);

--Remove CHECK constraints

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

ALTER TABLE test.products
DROP CONSTRAINT positive_price;

EXEC sp_help 'table_name';
EXEC sp_help 'test.products';

--Disable CHECK constraints for insert or update

ALTER TABLE table_name
NOCHECK CONSTRAINT constraint_name;

ALTER TABLE test.products
NOCHECK CONSTRAINT valid_price;

***

--SQL Server Data Types

--SQL Server BIT

CREATE TABLE sql_server_bit (
    bit_col BIT
);

INSERT INTO sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES (1);

INSERT INTO sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES(0);

INSERT INTO sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES('True');

INSERT INTO sql_server_bit (bit_col)
OUTPUT inserted.bit_col
VALUES ('False');

select * from sql_server_bit

--SQL Server INT

CREATE TABLE sql_server_integers (
	bigint_col bigint,
	int_col INT,
	smallint_col SMALLINT,
	tinyint_col tinyint
);

INSERT INTO sql_server_integers (
	bigint_col,
	int_col,
	smallint_col,
	tinyint_col
)
VALUES
	(
		9223372036854775807,
		2147483647,
		32767,
		255
	);

SELECT
	bigint_col,
	int_col,
	smallint_col,
	tinyint_col
FROM
	sql_server_integers;

***

--SQL Server Decimal

CREATE TABLE sql_server_decimal (
    dec_col DECIMAL (4,2),
    num_col NUMERIC (4,2)
);

INSERT INTO sql_server_decimal (dec_col, num_col)
VALUES (10.05, 20.05);

SELECT
    dec_col,
    num_col
FROM
    sql_server_decimal;

INSERT INTO sql_server_decimal (dec_col, num_col)
VALUES (99.999, 12.345);

***

--SQL Server CHAR Data Type

CREATE SCHEMA test; 
GO

CREATE TABLE test.sql_server_char (
    val CHAR(3)
);

INSERT INTO test.sql_server_char (val)
VALUES ('ABC');

INSERT INTO test.sql_server_char (val)
VALUES ('XYZ1');

INSERT INTO test.sql_server_char (val)
VALUES ('A');

SELECT
    val,
    LEN(val) len,
    DATALENGTH(val) data_length
FROM
    test.sql_server_char;

***

--SQL Server NCHAR

CREATE TABLE test.sql_server_nchar (
    val NCHAR(1) NOT NULL
);

INSERT INTO test.sql_server_nchar (val)
VALUES (N'あ');

INSERT INTO test.sql_server_nchar (val)
VALUES (N'いえ');

SELECT
    val,
    len(val) length,
    DATALENGTH(val) data_length
FROM
    test.sql_server_nchar;

***

CREATE TABLE test.sql_server_varchar (
    val VARCHAR NOT NULL
);

ALTER TABLE test.sql_server_varchar 
ALTER COLUMN val VARCHAR (10) NOT NULL;

INSERT INTO test.sql_server_varchar (val)
VALUES ('SQL Server');

INSERT INTO test.sql_server_varchar (val)
VALUES ('SQL Server VARCHAR');

SELECT
    val,
    LEN(val) len,
    DATALENGTH(val) data_length
FROM
    test.sql_server_varchar;

***

--SQL Server DATETIME2

CREATE TABLE table_name (
    ...
    column_name DATETIME2(3),
    ...
);

--The default string literal format of the DATETIME2 is YYYY-MM-DD hh:mm:ss[.fractional seconds]

CREATE TABLE production.product_colors (
    color_id INT PRIMARY KEY IDENTITY,
    color_name VARCHAR (50) NOT NULL,
    created_at DATETIME2
);

INSERT INTO production.product_colors (color_name, created_at)
VALUES ('Red', GETDATE());

ALTER TABLE production.product_colors 
ADD CONSTRAINT df_current_time 
DEFAULT CURRENT_TIMESTAMP FOR created_at;

INSERT INTO production.product_colors (color_name, created_at)
VALUES ('Green', '2018-06-23 07:30:20');

INSERT INTO production.product_colors (color_name)
VALUES ('Blue');

SELECT * FROM production.product_colors

--SQL Server DATE

USE BikeStores
go

SELECT    
	order_id, 
	customer_id, 
	order_status, 
	order_date
FROM    
	sales.orders
WHERE order_date < '2016-01-05'
ORDER BY 
	order_date DESC;

CREATE TABLE sales.list_prices (
    product_id INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    amount DEC (10, 2) NOT NULL,
    PRIMARY KEY (
        product_id,
        valid_from,
        valid_to
    ),
    FOREIGN KEY (product_id) 
      REFERENCES production.products (product_id)
);

INSERT INTO sales.list_prices (
    product_id,
    valid_from,
    valid_to,
    amount
)
VALUES
    (
        1,
        '2019-01-01',
        '2019-12-31',
        400
    );

select * from sales.list_prices

***

--SQL Server TIME

CREATE TABLE table_name(
    ...,
    start_at TIME(0),
    ...
);

--The default literal format for a TIME value is hh:mm:ss[.nnnnnnn]

drop table sales.visits

CREATE TABLE sales.visits (
    visit_id INT PRIMARY KEY IDENTITY,
    customer_name VARCHAR (50) NOT NULL,
    phone VARCHAR (25),
    store_id INT NOT NULL,
    visit_on DATE NOT NULL,
    start_at TIME (0) NOT NULL,
    end_at TIME (0) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES sales.stores (store_id)
);

INSERT INTO sales.visits (
    customer_name,
    phone,
    store_id,
    visit_on,
    start_at,
    end_at
)
VALUES
    (
        'John Doe',
        '(408)-993-3853',
        1,
        '2018-06-23',
        '09:10:00',
        '09:30:00'
    );

select * from sales.visits
***

--SQL Server DATETIMEOFFSET

DECLARE @dt DATETIMEOFFSET(7)

CREATE TABLE table_name (
    ...,
    column_name DATETIMEOFFSET(7)
    ...
);

--The literal formats of DATETIMEOFFSET is YYYY-MM-DDThh:mm:ss[.nnnnnnn][{+|-}hh:mm]

CREATE TABLE messages(
    id         INT PRIMARY KEY IDENTITY, 
    message    VARCHAR(255) NOT NULL, 
    created_at DATETIMEOFFSET NOT NULL
);

INSERT INTO messages(message,created_at)
VALUES('DATETIMEOFFSET demo',
        CAST('2019-02-28 01:45:00.0000000 -08:00' AS DATETIMEOFFSET));

SELECT 
    id, 
    message, 
	created_at 
        AS 'Pacific Standard Time',
    created_at AT TIME ZONE 'SE Asia Standard Time' 
        AS 'SE Asia Standard Time'
FROM 
    messages;

***

--SQL Server GUID

SELECT NEWID() AS GUID;

DECLARE @id UNIQUEIDENTIFIER;

SET @id = NEWID();

SELECT @id AS GUID;

CREATE SCHEMA market;
GO

CREATE TABLE market.customers(
    customer_id UNIQUEIDENTIFIER DEFAULT NEWID(),
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL
);
GO

INSERT INTO 
    market.customers(first_name, last_name, email)
VALUES
    ('John','Doe','john.doe@example.com'),
    ('Jane','Doe','jane.doe@example.com');

SELECT 
    customer_id, 
    first_name, 
    last_name, 
    email
FROM 
   market.customers;

***

***

--SQL Server SELECT INTO statement

SELECT 
    select_list
INTO 
    destination
FROM 
    source
[WHERE condition]

CREATE SCHEMA marketing;

SELECT 
    *
INTO 
    marketing.customers
FROM 
    sales.customers;

SELECT 
    *
FROM 
    marketing.customers;

--Using SQL Server SELECT INTO statement to copy table across databases

CREATE DATABASE TestDb;

SELECT    
    customer_id, 
    first_name, 
    last_name, 
    email
INTO 
    TestDb.dbo.customers
FROM    
    sales.customers
WHERE 
    state = 'CA';

SELECT 
    * 
FROM 
    TestDb.dbo.customers;

***

--SQL Server Temporary Tables

--Create temporary tables using SELECT INTO statement

SELECT 
    select_list
INTO 
    temporary_table
FROM 
    table_name

SELECT
    product_name,
    list_price
INTO #trek_products --- temporary table
FROM
    production.products
WHERE
    brand_id = 9;

--Create temporary tables using CREATE TABLE statement

-SSMS
System Databases > tempdb > Temporary Tables

CREATE TABLE #haro_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO #haro_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 2;

SELECT
    *
FROM
    #haro_products;

--Global temporary tables

CREATE TABLE ##heller_products (
    product_name VARCHAR(MAX),
    list_price DEC(10,2)
);

INSERT INTO ##heller_products
SELECT
    product_name,
    list_price
FROM 
    production.products
WHERE
    brand_id = 3;

DROP TABLE ##table_name;

***

--SQL Server CREATE SEQUENCE statement

CREATE SEQUENCE [schema_name.] sequence_name  
    [ AS integer_type ]  
    [ START WITH start_value ]  
    [ INCREMENT BY increment_value ]  
    [ { MINVALUE [ min_value ] } | { NO MINVALUE } ]  
    [ { MAXVALUE [ max_value ] } | { NO MAXVALUE } ]  
    [ CYCLE | { NO CYCLE } ]  
    [ { CACHE [ cache_size ] } | { NO CACHE } ];

CREATE SEQUENCE item_counter
    AS INT
    START WITH 10
    INCREMENT BY 10;

SELECT NEXT VALUE FOR item_counter;

SELECT NEXT VALUE FOR item_counter;

--Using a sequence object in a single table example

CREATE SCHEMA procurement;

CREATE TABLE procurement.purchase_orders(
    order_id INT PRIMARY KEY,
    vendor_id int NOT NULL,
    order_date date NOT NULL
);

CREATE SEQUENCE procurement.order_number 
AS INT
START WITH 1
INCREMENT BY 1;

INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,1,'2019-04-30');

INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,2,'2019-05-01');

INSERT INTO procurement.purchase_orders
    (order_id,
    vendor_id,
    order_date)
VALUES
    (NEXT VALUE FOR procurement.order_number,3,'2019-05-02');

SELECT 
    order_id, 
    vendor_id, 
    order_date
FROM 
    procurement.purchase_orders;

SELECT 
    * 
FROM 
    sys.sequences;

CREATE SEQUENCE procurement.receipt_no
START WITH 1
INCREMENT BY 1;

CREATE TABLE procurement.goods_receipts
(
    receipt_id   INT	PRIMARY KEY 
        DEFAULT (NEXT VALUE FOR procurement.receipt_no), 
    order_id     INT NOT NULL, 
    full_receipt BIT NOT NULL,
    receipt_date DATE NOT NULL,
    note NVARCHAR(100),
);

INSERT INTO procurement.goods_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    1,
    '2019-05-12',
    'Goods receipt completed at warehouse'
);

INSERT INTO procurement.goods_receipts(
    order_id, 
    full_receipt,
    receipt_date,
    note
)
VALUES(
    1,
    0,
    '2019-05-12',
    'Goods receipt has not completed at warehouse'
);

Sequence vs. Identity columns

Sequences, different from the identity columns, are not associated with a table.
The relationship between the sequence and the table is controlled by applications.
In addition, a sequence can be shared across multiple tables.

***

--SQL Server Synonym

CREATE SYNONYM [ schema_name_1. ] synonym_name 
FOR object;

--Creating a synonym within the same database example

CREATE SYNONYM orders FOR sales.orders;

SELECT * FROM orders;

--Creating a synonym for a table in another database

CREATE DATABASE test;
GO

USE test;
GO

CREATE SCHEMA purchasing;
GO

CREATE TABLE purchasing.suppliers
(
    supplier_id   INT
    PRIMARY KEY IDENTITY, 
    supplier_name NVARCHAR(100) NOT NULL
);

CREATE SYNONYM suppliers 
FOR test.purchasing.suppliers;

SELECT 
    name, 
    base_object_name, 
    type
FROM 
    sys.synonyms
ORDER BY 
    name;

--Removing a synonym

DROP SYNONYM [ IF EXISTS ] [schema.] synonym_name  

DROP SYNONYM IF EXISTS orders;

***




























































































































