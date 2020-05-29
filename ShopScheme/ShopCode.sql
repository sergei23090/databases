CREATE TABLE food (
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL
)
CREATE TABLE client(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
surname varchar(255) NOT NULL,
middle_name varchar(255),
mail varchar(255) NOT NULL UNIQUE,
phone varchar(12) NOT NULL UNIQUE
)
CREATE TABLE stock(
id serial PRIMARY KEY UNIQUE,
common_stock varchar(1000) NOT NULL,
individual_stock varchar(1000) NOT NULL,
product_id integer,
client_id integer REFERENCES client (id),
purchase_amount numeric(10,2) NOT NULL
)
CREATE TABLE product_name(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
food_id integer REFERENCES food(id),
stock_id integer REFERENCES stock (id)
)
CREATE TABLE price_history (
id serial PRIMARY KEY UNIQUE,
date_changes timestamp(0) NOT NULL,
product_id integer NOT NULL,
old_price numeric(10,2) NOT NULL,
new_price numeric(10,2) NOT NULL,
product_name_id integer REFERENCES product_name(id)
)
CREATE TABLE product_attribute(
id serial PRIMARY KEY UNIQUE,
attribute varchar(255) NOT NULL,
value varchar(255) NOT NULL,
product_name_id integer REFERENCES product_name (id)
)
CREATE TABLE shop (
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
city varchar(255) NOT NULL,
street varchar(255) NOT NULL,
house varchar(20) NOT NULL,
coordinates varchar(1000) NOT NULL,
date_creation timestamp(0) NOT NULL,
date_close timestamp(0)
)
CREATE TABLE accounting(
id serial PRIMARY KEY UNIQUE,
amount integer NOT NULL,
date_buy timestamp(0) NOT NULL,
price integer NOT NULL,
shop_id integer REFERENCES shop (id)
)
CREATE TABLE warehouse(
id serial PRIMARY KEY UNIQUE,
price_product integer NOT NULL,
count integer NOT NULL,
shop_id integer REFERENCES shop (id)
)
CREATE TABLE product_accounting(
id serial PRIMARY KEY UNIQUE,
accounting_id integer REFERENCES accounting (id),
client_id integer REFERENCES client (id),
product_name_id integer REFERENCES product_name (id)
)
CREATE TABLE product_shop(
id serial PRIMARY KEY UNIQUE,
product_id integer NOT NULL,
shop_id integer REFERENCES shop (id),
date_purchase timestamp(0) NOT Null,
id_client integer NOT NULL,
product_name_id integer REFERENCES product_name (id)
)
CREATE TABLE schedule_works(
id serial PRIMARY KEY UNIQUE,
employee_id integer,
start timestamp(0) NOT NULL,
finish timestamp(0)
)
CREATE TABLE employee(
id serial PRIMARY KEY UNIQUE,
department varchar(255) NOT NULL,
office_department varchar(255) NOT NULL,
schedule_works_id integer REFERENCES schedule_works (id),
name varchar(255) NOT NULL,
surname varchar(255) NOT NULL,
middle_name varchar(255) ,
mail varchar(255) NOT NULL UNIQUE,
phone varchar(12) NOT NULL UNIQUE,
start_work timestamp(0) NOT NULL,
finish_work timestamp(0)
)
CREATE TABLE supplier(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
city varchar(255) NOT NULL,
street varchar(255) NOT NULL,
house varchar(20) NOT NULL,
coordinates varchar(1000) NOT NULL,
phone varchar(12) NOT NULL UNIQUE,
mail varchar(255) NOT NULL UNIQUE,
shop_id integer REFERENCES shop (id),
employee_id integer REFERENCES employee (id)
)
CREATE TABLE shop_supplier(
id serial PRIMARY KEY UNIQUE,
price numeric(10,2) NOT NULL,
count_product integer NOT NULL,
shop_id integer REFERENCES shop (id) NOT NULL,
supplier_id integer REFERENCES suplier (id),
product_name_id integer REFERENCES product_name (id)
)
CREATE TABLE office_departament(
id serial PRIMARY KEY UNIQUE,
description varchar(10000) NOT NULL,
name varchar(255) NOT NULL,
date_creation timestamp(0) NOT NULL,
date_close timestamp(0)
)
CREATE TABLE employee_office_department(
id serial PRIMARY KEY UNIQUE,
office_departament_id integer REFERENCES office_departament (id),
employee_id integer REFERENCES employee (id)
)
CREATE TABLE departament(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
description varchar(10000) NOT NULL,
date_creation timestamp(0) NOT NULL,
date_close timestamp(0),
office_departament_id integer REFERENCES office_departament (id)
)
CREATE TABLE company_employee(
id serial PRIMARY KEY UNIQUE,
name varchar(255) NOT NULL,
surname varchar(255) NOT NULL,
middle_name varchar(255) NOT NULL,
registration varchar(1000) NOT NULL,
mail varchar(255) NOT NULL UNIQUE,
phone varchar(12) NOT NULL UNIQUE,
birth_date varchar(255) NOT NULL,
work_start timestamp(0) NOT NULL,
work_finish timestamp(0),
employee_id integer REFERENCES employee (id)
)
CREATE TABLE employee_shop(
id serial PRIMARY KEY UNIQUE,
employee_employee_id integer,
shop_id integer REFERENCES shop(id),
employee_id integer REFERENCES employee(id)
)

INSERT INTO food(name) VALUES


INSERT INTO client(name, surname, middle_name, mail, phone) VALUES


INSERT INTO stock(common_stock, individual_stock,purchase_amount) VALUES


INSERT INTO product_name(name) VALUES


INSERT INTO price_history (date_changes old_price, new_price) VALUES


INSERT INTO product_attribute(attribute, value) VALUES


INSERT INTO shop(name, city, street, house, date_creation, date_close) VALUES


INSERT INTO accounting(amount, date_buy, price) VALUES


INSERT INTO warehouse(price_product, count) VALUES


INSERT INTO product_accounting() VALUES


INSERT INTO product_shop(date_purchase) VALUES


INSERT INTO schedule_works(start, finish) VALUES


INSERT INTO employee(department, office_departament, name, surname, middle_name, mail, phone, start_work, finish_work) VALUES


INSERT INTO supplier(name, city, street, house, phone, mail) VALUES


INSERT INTO shop_supplier(price, count_product) VALUES


INSERT INTO office_department(description, name, date_creation, date_close) VALUES


INSERT INTO employee_office_department() VALUES


INSERT INTO depatment(name, description, date_creation, date_close) VALUES


INSERT INTO company_employee(name, surname, middle_name, registration, mail, phone, birth_date, work_start, work_finish) VALUES


INSERT INTO employee_shop() VALUES
