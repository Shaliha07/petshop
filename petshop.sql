-- Table: users
CREATE TABLE users (
    userid SERIAL PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(255),
    email VARCHAR(150) UNIQUE,
    role VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL
);

-- Table: services
CREATE TABLE services (
    serviceid SERIAL PRIMARY KEY,
    servicename VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    sellingprice DOUBLE PRECISION NOT NULL,
    status VARCHAR(50) NOT NULL
);

-- Table: appointments
CREATE TABLE appointments (
    appointmentid SERIAL PRIMARY KEY,
    userid INT NOT NULL,
    serviceid INT NOT NULL,
    appointmentdate DATE NOT NULL,
    appointmenttime TIME NOT NULL,
    reason VARCHAR(255),
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users (userid),
    FOREIGN KEY (serviceid) REFERENCES services (serviceid)
);

-- Table: category
CREATE TABLE category (
    categoryid SERIAL PRIMARY KEY,
    categoryname VARCHAR(100) NOT NULL,
    status VARCHAR(50) NOT NULL
);

-- Table: goods
CREATE TABLE goods (
    goodid SERIAL PRIMARY KEY,
    categoryid INT NOT NULL,
    goodname VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    stockqty INT NOT NULL,
    sellingprice DOUBLE PRECISION NOT NULL,
    purchasingprice DOUBLE PRECISION NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (categoryid) REFERENCES category (categoryid)
);

-- Table: salesorder
CREATE TABLE salesorder (
    salesorderid SERIAL PRIMARY KEY,
    userid INT NOT NULL, -- Linking salesorder to the user who created the order
    orderdate DATE NOT NULL,
    tax DOUBLE PRECISION DEFAULT 0, -- Default tax is 0
    discount DOUBLE PRECISION DEFAULT 0, -- Default discount is 0
    total DOUBLE PRECISION NOT NULL, -- Total after tax and discount
    amountpaid DOUBLE PRECISION DEFAULT 0,
    balance DOUBLE PRECISION AS (total - amountpaid) STORED, -- Auto-calculating balance
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES users (userid)
);

-- Table: salesorderdetails
CREATE TABLE salesorderdetails (
    orderdetailsid SERIAL PRIMARY KEY,
    salesorderid INT NOT NULL,
    goodid INT NOT NULL,
    qty INT NOT NULL,
    total DOUBLE PRECISION NOT NULL, -- Subtotal for the good (qty * unit price)
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (salesorderid) REFERENCES salesorder (salesorderid),
    FOREIGN KEY (goodid) REFERENCES goods (goodid)
);
