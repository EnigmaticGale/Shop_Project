DROP TABLE products;
DROP TABLE suppliers;

CREATE TABLE suppliers (
  id SERIAL8 primary key,
  company_name VARCHAR(255),
  company_description VARCHAR(255),
  contact_number VARCHAR(255)
);

CREATE TABLE products (
  id SERIAL8 primary key,
  name VARCHAR(255),
  description VARCHAR(255),
  stock INT4,
  price NUMERIC(7 , 2),
  sell_price NUMERIC(7 , 2),
  supplier_id INT4 REFERENCES suppliers(id)
);
