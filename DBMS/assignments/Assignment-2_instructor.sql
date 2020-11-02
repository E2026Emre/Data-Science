--
-- Create Database: Manufacturer
--

-- CREATE DATABASE Manufacturer;
-- USE Manufacturer;


--
-- Table structure for table 'Product'
--

CREATE TABLE Product (
  ProductID int NOT NULL IDENTITY(1,1),
  ProductName varchar(255) NOT NULL,
  Quantity int NOT NULL,
  PRIMARY KEY (ProductID)
);


--
-- Table structure for table 'Component'
--

CREATE TABLE Component (
  ComponentID int NOT NULL IDENTITY(1,1),
  ComponentName varchar(255) NOT NULL,
  Description varchar(255),
  PRIMARY KEY (ComponentID)
);


--
-- Table structure for table 'Supplier'
--

CREATE TABLE Supplier (
  SupplierID int NOT NULL IDENTITY(1,1),
  SupplierName varchar(255) NOT NULL,
  PRIMARY KEY (SupplierID)
);


--
-- Table structure for table 'ProdComp'
--

CREATE TABLE ProdComp (
  ProductID int NOT NULL,
  ComponentID int NOT NULL,
  CONSTRAINT fk1_product_id FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
  CONSTRAINT fk2_component_id FOREIGN KEY (ComponentID) REFERENCES Component (ComponentID),
  PRIMARY KEY (ProductID, ComponentID)
);


--
-- Table structure for table 'SuppComp'
--

CREATE TABLE SuppComp (
  SupplierID int NOT NULL,
  ComponentID int NOT NULL,
  CONSTRAINT fk1_supplier_id FOREIGN KEY (SupplierID) REFERENCES  Supplier (SupplierID),
  CONSTRAINT fk3_component_id FOREIGN KEY (ComponentID) REFERENCES Component (ComponentID),
  PRIMARY KEY (SupplierID, ComponentID)
);


***

select *
from [dbo].[ProdComp] pc
inner join [dbo].[Product] p
on pc.ProductID = p.ProductID
inner join [dbo].[Component] c
on pc.ComponentID = c.ComponentID

***
