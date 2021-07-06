-- 01 add a column
CREATE TABLE products (
    product_no integer,
    name text,
    price numeric
);

ALTER TABLE products ADD COLUMN description text;

ALTER TABLE products ADD COLUMN description text CHECK(description <> '');

-- 02 removing a column
ALTER TABLE products DROP COLUMN description;

ALTER TABLE products DROP COLUMN description CASCADE;

-- 03 adding a constraint
ALTER TABLE products ADD CHECK (name <> '');
ALTER TABLE products ADD CONSTRAINT some_name UNIQUE (product_no);
ALTER TABLE products ADD FOREIGN KEY (product_group_id) REFERENCES product_groups;
ALTER TABLE products ALTER COLUMN product_no SET NOT NULL;

-- 04 removing a constraint
ALTER TABLE products DROP CONSTRAINT some_name;

ALTER TABLE products ALTER COLUMN product_no DROP NOT NULL;

-- 05 change default value
ALTER TABLE products ALTER COLUMN price SET DEFAULT 7.77;

ALTER TABLE products ALTER COLUMN price DROP DEFAULT;

-- 06 change column's data type
ALTER TABLE products ALTER COLUMN price TYPE numeric(10,2);

-- 07 rename a column
ALTER TABLE products RENAME COLUMN product_no TO product_number;

-- 08 rename a table
ALTER TABLE products RENAME TO items;
