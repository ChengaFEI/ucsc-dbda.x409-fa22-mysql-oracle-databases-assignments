# UCSC Extension
# DBDA.X409.(10) MySQL and Oracle Database for Developers and Designers
# Assignment 1
# Cheng Fei
# 10/15/2022
#
# Customer information database project with three tables:
# address -- address line, city, and state code.
# orders -- product code, product description, and transaction data.
# customer -- name, email, phone, purchase date, address, and order information.

# @_CREATE_DATABASE_
CREATE DATABASE mysqldev;
USE mysqldev;
# Pre-configure the database.
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customer;

DROP TABLE IF EXISTS address;
# @_CREATE_TABLE_
CREATE TABLE address (
	address_id INT NOT NULL AUTO_INCREMENT,
	address_line1 VARCHAR(100) NOT NULL,
	address_line2 VARCHAR(100) NOT NULL,
	city VARCHAR(100) NOT NULL,
	state_cd VARCHAR(2) NOT NULL,
	PRIMARY KEY (address_id)
);

DROP TABLE IF EXISTS orders;
# @_CREATE_TABLE_
CREATE TABLE orders (
	order_id INT NOT NULL AUTO_INCREMENT,
	product_code VARCHAR(100) NOT NULL,
	product_description VARCHAR(100) NOT NULL,
	transaction_date DATE NOT NULL,
	PRIMARY KEY (order_id)
);

DROP TABLE IF EXISTS customer;
# @_CREATE_TABLE_
CREATE TABLE customer (
	customer_id INT NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	phone VARCHAR(100) NOT NULL,
	date_purchased DATE NOT NULL,
	address_id INT NOT NULL,
	order_id INT NOT NULL,
	PRIMARY KEY (customer_id),
	FOREIGN KEY (address_id) REFERENCES address (address_id),
	FOREIGN KEY (order_id) REFERENCES orders (order_id),
	UNIQUE (email)
);

# @_ALTER_TABLE_
ALTER TABLE address ADD zip VARCHAR(10) NOT NULL;
ALTER TABLE address ADD latitude INT NOT NULL;
ALTER TABLE address ADD longitude INT NOT NULL;

# @_CREATE_TABLE_
INSERT INTO address (address_line1, address_line2, city, state_cd, zip, latitude, longitude) 
VALUES ("309 W Woods St", "East Village", "New York", "NY", 18321, 13.3123123, 31.3131312312);
INSERT INTO address (address_line1, address_line2, city, state_cd, zip, latitude, longitude) 
VALUES ("402 Queens Rd", "N/A", "Irvine", "CA", 12381, 21.13141412, 31.1241212124);
INSERT INTO orders (product_code, product_description, transaction_date) VALUES ("131245315", "Lenovo PC", "2022-08-01");
INSERT INTO orders (product_code, product_description, transaction_date) VALUES ("386161269", "USB-Serial Adapter", "2022-07-29");
INSERT INTO orders (product_code, product_description, transaction_date) VALUES ("132078068", "Sanitizer", "2022-07-29");
INSERT INTO orders (product_code, product_description, transaction_date) VALUES ("425346436", "Book", "2022-10-10");
INSERT INTO customer (first_name, last_name, email, phone, date_purchased, address_id, order_id) 
VALUES ("Tom", "Hanks", "th@outlook.com", "901327636", "2022-08-01", 1, 1);
INSERT INTO customer (first_name, last_name, email, phone, date_purchased, address_id, order_id) 
VALUES ("Jamie", "Hanks", "jh@outlook.com", "2132037822", "2022-07-29", 1, 2);
INSERT INTO customer (first_name, last_name, email, phone, date_purchased, address_id, order_id) 
VALUES ("Taylor", "Swift", "ts@outlook.com", "3123231313", "2022-07-29", 2, 3);
INSERT INTO customer (first_name, last_name, email, phone, date_purchased, address_id, order_id) 
VALUES ("Zach", "Yang", "zy@outlook.com", "9013271332", "2022-10-10", 2, 4);

COMMIT;










