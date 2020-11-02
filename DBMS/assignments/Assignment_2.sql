--Assignment-2(Manufacturer Database)

create database Manufacturer;

create table products
(
product_id int NOT NULL identity(1,1), 
product_name VARCHAR(255) NOT NULL,
quantity int,
PRIMARY KEY(product_id)
);

create table components
(
component_id int NOT NULL identity(1,1),
component_name VARCHAR(255) NOT NULL,
[description] VARCHAR(255),
PRIMARY KEY (component_id)
);

create table suppliers
(
supplier_id int NOT NULL identity(1,1),
supplier_name VARCHAR(255) NOT NULL,
PRIMARY KEY (supplier_id)
);

create table productcomponent
(
product_id int NOT NULL,
component_id int NOT NULL,
FOREIGN KEY (product_id) REFERENCES products(product_id),
FOREIGN KEY (component_id) REFERENCES components(component_id),
PRIMARY KEY (product_id, component_id)
);

create table suppliercomponent
(
component_id int NOT NULL,
supplier_id int NOT NULL,
FOREIGN KEY (component_id) REFERENCES components(component_id),
FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id),
PRIMARY KEY (component_id, supplier_id)
);


select * from products 
select * from components
select * from suppliers 
select * from productcomponent 
select * from suppliercomponent 
