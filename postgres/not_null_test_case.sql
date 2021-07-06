CREATE TABLE products(
    product_no integer NOT NULL,
    name text primary key ,
    price numeric
);

DROP TABLE products;

select tablename from pg_tables where schemaname='public';

CREATE TABLE products(
    product_no integer,
    name text,
    price numeric,
    CONSTRAINT gtp_pk_con PRIMARY KEY(name)
);