--01 create table
CREATE TABLE my_first_table (
    first_column text,
    second_column integer
);

CREATE TABLE products (
    product_no integer,
    name text,
    price numeric
);

-- 02 drop table
DROP TABLE my_first_table;
DROP TABLE products;

-- 03 default values
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric DEFAULT 9.99,
    time TIMESTAMP default CURRENT_TIMESTAMP
);
DROP TABLE products;

-- 04 generated columns
CREATE TABLE people (
    id        integer,
    height_cm numeric,
    height_in numeric GENERATED ALWAYS AS (height_cm / 2.54) STORED
);
INSERT INTO people VALUES(1, 200);
SELECT * FROM people;
DROP TABLE people;

-- 05 constrain 
--- 05-1 check constraints
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CHECK (price > 0)
);
--- or
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CONSTRAINT positive_price CHECK (price > 0)
);

--- refer to several columns/table constraint
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CHECK (price > 0),
    discounted_price numeric CHECK (discounted_price > 0),
    CHECK (price > discounted_price)
);

CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CHECK (price > 0),
    discounted_price numeric,
    CHECK (discounted_price > 0 AND price > discounted_price)
);

CREATE TABLE products (
    product_no integer,
    name text,
    price numeric,
    CHECK (price > 0),
    discounted_price numeric,
    CHECK (discounted_price > 0),
    CONSTRAINT valid_discount CHECK (price > discounted_price)
);

--- 05-2 not null constraints
CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric
);
-- more than one constraint
CREATE TABLE products (
    product_no integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL CHECK (price > 0)
);

--- 05-3 unique constraints
CREATE TABLE products (
    product_no integer UNIQUE,
    name text,
    price numeric
    );

CREATE TABLE products (
    product_no integer,
    name text,
    price numeric,
    UNIQUE (product_no)
);

CREATE TABLE example (
    a integer,
    b integer,
    c integer,
    UNIQUE (a, c)
);

CREATE TABLE products (
    product_no integer CONSTRAINT must_be_different UNIQUE,
    name text,
    price numeric
);

--- 05-4 primary keys
CREATE TABLE products (
    product_no integer UNIQUE NOT NULL,
    name text,
    price numeric
);
-- equals to
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
-- more than on column
CREATE TABLE example (
    a integer,
    b integer,
    c integer,
    PRIMARY KEY (a, c)
);

--- 05-5 foreign keys
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products (product_no),
    quantity integer
);
-- shorten command
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products,
    quantity integer
);

-- group of column
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric,
    PRIMARY KEY(product_no, name)
);

CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer,
    name text,
    FOREIGN KEY (product_no, name) REFERENCES products (product_no, name)
);

-- more than one foreign key
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    shipping_address text,
);
CREATE TABLE order_items (
    product_no integer REFERENCES products,
    order_id integer REFERENCES orders,
    quantity integer,
    PRIMARY KEY (product_no, order_id)
);

-- when delete
CREATE TABLE products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    shipping_address text,
);
CREATE TABLE order_items (
    product_no integer REFERENCES products ON DELETE RESTRICT,
    order_id integer REFERENCES orders ON DELETE CASCADE,
    quantity integer,
    PRIMARY KEY (product_no, order_id)
);