create database HR
use HR
create table jobs
(
job_id int identity(1,1) primary key,
job_title varchar(20),
min_salary decimal,
max_salary decimal,
)
create table regions
(
region_id int identity(1,1) primary key,
region_name varchar(20)
)
create table countries
(
country_id int identity(1,1) primary key,
country_name varchar(20),
region_id int, 
foreign key(region_id) references regions(region_id)
)
create table locations
(
location_id int identity(1,1) primary key,
strett_adress varchar(20),
postal_code varchar(20),
city varchar(20),
state_province varchar(20),
country_id int, 
foreign key(country_id) references countries(country_id)
)
create table departments
(
department_id int identity(1,1) primary key,
dep_name varchar(20),
location_id int, 
foreign key(location_id) references locations(location_id)
)

create table employees
(
employee_id int identity(1,1) primary key,
first_name varchar(20),
last_name varchar(20),
email varchar(30),
phone_number numeric,
hire_date datetime,
job_id int,
foreign key (job_id) references jobs(job_id),
salary decimal,
manager_id int,
foreign key (manager_id) references employees(employee_id),
department_id int
foreign key (department_id) references departments(department_id),
)

create table dependents
(
dependents_id int identity(1,1) primary key,
first_name varchar(20),
last_name varchar(20),
relationship varchar(20),
employee_id int, 
foreign key(employee_id ) references employees(employee_id )
)