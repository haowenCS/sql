CREATE TABLE products (
    product_no integer,
    name text,
    price numeric CHECK(price >0)
);

drop table products;

select tablename from pg_tables where schemaname='public';

-- check constraint
create table products (
    product_no integer NOT NULL,
    name text,
    price numeric CHECK ( price > 0)
);

insert into products values(1, 'text', 2);
select * from products;
insert into products values (1, 'computer', 3000);
insert into products values (2, 'water', -0.1);

drop table products;