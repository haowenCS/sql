select tablename from pg_tables where schemaname='public';
-- 3.1 create table with foreign key
--- primary key constraint
create table products (
    product_no integer primary key,
    name text,
    price numeric
);
select tablename from pg_tables where schemaname='public';
--- foreign constraint
CREATE TABLE orders (
    order_id integer PRIMARY KEY,
    product_no integer REFERENCES products (product_no),
    quantity integer
);
select tablename from pg_tables where schemaname='public';

--- cannot drop table products because other objects depend on it.
drop table products;
drop table orders;

-- 3.2 alter table add/drop foreign key
create table products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);
select tablename from pg_tables where schemaname='public';
--- foreign constraint
CREATE TABLE orders (
    order_id integer,
    product_no integer,
    quantity integer
);

select tablename from pg_tables where schemaname='public';
--- add foreign key constraint
alter table orders add  CONSTRAINT orders_fk FOREIGN KEY (product_no) references  products;
alter table orders alter column product_no SET NOT NULL;

--- drop foreign key constraint
alter table orders drop constraint orders_fk;

drop table products;
drop table orders;

select * from pg_tables where schemaname = 'public';
