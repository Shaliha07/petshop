create table users(
	userid SERIAL PRIMARY KEY,
	username varchar(50),
	password varchar(255),
	email varchar(150),
	DOB date,
	status varchar(50)
);

create table employees(
	empid SERIAL PRIMARY KEY,
	empname varchar(150),
	username varchar(50),
	password varchar(255),
	role varchar(100),
	status varchar(50)
);

create table services(
	serviceid SERIAL PRIMARY KEY,
	servicename varchar(100),
	description varchar(255),
	sellingprice double precision,
	status varchar(50)
);

create table appointments(
	appointmentid SERIAL PRIMARY KEY,
	userid int,
	serviceid int,
	appointmentdate date,
	appointmenttime time,
	reason varchar(255),
	status varchar(50),
	FOREIGN KEY (userid) REFERENCES users (userid),
	FOREIGN KEY (serviceid) REFERENCES services (serviceid)
);

create table category(
	categoryid SERIAL PRIMARY KEY,
	categoryname varchar(100),
	status varchar(50)
);

create table goods(
	goodid SERIAL PRIMARY KEY,
	categoryid int,
	goodname varchar(100),
	description varchar(255),
	stockqty int,
	sellingprice double precision,
	purchasingprice double precision,
	status varchar(50),
	FOREIGN KEY (categoryid) REFERENCES category (categoryid)
);

create table salesorder(
	salesorderid SERIAL PRIMARY KEY,
	orderdate date,
	tax double precision,
	discount double precision,
	total double precision,
	amountpaid double precision,
	balance double precision,
	status varchar(50)
);

create table salesorderdetails(
	orderdetailsid SERIAL PRIMARY KEY,
	salesorderid int,
	goodid int,
	qty int,
	total double precision,
	status varchar(50),
	FOREIGN KEY (salesorderid) REFERENCES salesorder (salesorderid),
	FOREIGN KEY (goodid) REFERENCES goods (goodid)
);
