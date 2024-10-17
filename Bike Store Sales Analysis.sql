-- Starting Project
--Creating Tables 
create table brands(
	brand_id varchar (10) primary key,
	brand_name varchar (50)
);
create table categories(
	category_id varchar (10) primary key,
	category_name varchar(50)
);
create table customers(
	customer_id varchar (10) primary key,
	first_name varchar (100),
	last_name varchar (100),
	phone varchar (100),
	email varchar (100),
	street varchar (100),
	city varchar (100),
	[state] varchar (100),
	zip_code varchar (50)
);
create table order_items(
	order_id varchar (10) ,
	item_id varchar (10),
	product_id varchar (10),
	quantity int,
	list_price float,
	discount float
);
create table orders(
	order_id varchar (10) primary key,
	customer_id varchar (10),
	order_status varchar (10),
	order_date date,
	required_date date,
	shipped_date date ,
	store_id varchar(10),
	staff_id varchar (10)
);
create table products(
	product_id varchar (10) primary key,
	product_name varchar (100),
	brand_id varchar (10),
	category_id varchar (10),
	model_year varchar (10),
	list_price float
);
create table staffs(
	staff_id varchar (10) primary key,
	first_name varchar (50),
	last_name varchar (50),
	email varchar (100),
	phone varchar (100),
	active varchar (5),
	store_id varchar (5),
	manager_id varchar (10)
);
alter table staffs
alter column store_id varchar(10);
delete from staffs
where manager_id = 'null';
INSERT INTO staffs (staff_id, first_name, last_name, email, phone, active, store_id, manager_id) 
values('1',	'Fabiola',	'Jackson',	'fabiola.jackson@bikes.shop',	'(831) 555-5554',	'1',	'1',null);

create table stocks(
	store_id varchar (10),
	product_id varchar (10),
	quantity int
);
create table stores(
	store_id varchar (10) primary key,
	store_name varchar (100),
	phone varchar (50),
	email varchar (100),
	street varchar (100),
	city varchar (50),
	[state] varchar(5),
	zip_code varchar (10)
);

-- Inserting data into tables
-- barnds
bulk insert brands
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\brands.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
	);
--categories
bulk insert categories
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\categories.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
	);
--customers
bulk insert customers
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\customers.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
	);
--order_items
bulk insert order_items
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\order_items.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2
	);
--orders
bulk insert orders
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\orders.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2,
	keepnulls
	);
--products
bulk insert products
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\products.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2,
	keepnulls
	);
--staffs
bulk insert staffs
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\staffs.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2,
	keepnulls
	);
--stocks
bulk insert stocks
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\stocks.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2,
	keepnulls
	);
--stores
bulk insert stores
from 'E:\Egyptian_Initiatives\graduation project\selected\bikes sales\stores.csv'
with(
	fieldterminator=',',
	rowterminator='\n',
	firstrow=2,
	keepnulls
	);


--adding foregin keys to join tables
-- Products to Brands
ALTER TABLE products
ADD FOREIGN KEY (brand_id) REFERENCES brands(brand_id);

-- Products to Categories
ALTER TABLE products
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id);

-- Order Items to Products
ALTER TABLE order_items
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Order Items to Orders
ALTER TABLE order_items
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Orders to Customers
ALTER TABLE orders
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- Stocks to Products
ALTER TABLE stocks
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Stocks to Stores
ALTER TABLE stocks
ADD FOREIGN KEY (store_id) REFERENCES stores(store_id);

-- Orders to Stores
ALTER TABLE orders
ADD FOREIGN KEY (store_id) REFERENCES stores(store_id);

-- Orders to Staffs
ALTER TABLE orders
ADD FOREIGN KEY (staff_id) REFERENCES staffs(staff_id);

-- Staffs to Stores
ALTER TABLE staffs
ADD FOREIGN KEY (store_id) REFERENCES stores(store_id);

-- Staffs to Managers (Self-referencing)
ALTER TABLE staffs
ADD FOREIGN KEY (manager_id) REFERENCES staffs(staff_id);

--creating indexes
CREATE INDEX idx_products_brand ON products(brand_id);
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_stocks_product ON stocks(product_id);
CREATE INDEX idx_stocks_store ON stocks(store_id);
