CREATE DATABASE osdbadb;

ALTER DATABASE osdbadb RENAME TO new_db;
ALTER DATABASE osdbadb OWNER TO new_owner;
ALTER DATABASE osdbadb SET TABLESPACE new_tablespace;
ALTER DATABASE osdbadb CONNECTION LIMIT 10;

DROP DATABASE osdbadb;

CREATE SCHEMA osdba;
DROP SCHEMA osdba;

ALTER SCHEMA name RENAME TO newname;
ALTER SCHEMA name OWNER TO newowner;

SHOW search_path;

-- public: 模式名
-- PUBLIC: 所有用户
REVOKE CREATE ON SCHEMA public FROM PUBLIC;


CREATE TABLE test01(id int, note varchar(20));
CREATE TABLE test01(id int primary key, note varchar(20));
CREATE TABLE test02(id1 int, id2 int, note varchar(20),
    CONSTRAINT pk_test02 primary key(id1, id2));
CREATE TABLE test03(id1 int, id2 int, id3 int, note varchar(20),
    CONSTRAINT pk_test03 primarykey(id1, id2),
    CONSTRAINT uk_test03_id3 UNIQUE(id3));
CREATE TABLE child(name varchar(20), age int, note text,
    CONSTRAINT ck_child_age CHECK(age < 18));

/*
带constraint
    INCLUDING DEFAULTS
    INCLUDING CONSTRAINTS
    INCLUDING INDEXES
    INCLUDING STORAGE
    INCLUDING COMMENTS 
    INCLUDING ALL
*/
CREATE TABLE baby2(LIKE child INCLUDING ALL);

CREATE TABLE blog(id int, title text, context text);
ALTER TABLE blog ALTER context SET STORAGE EXTERNAL;

CREATE TEMPORARY TABLE tmp_t1(id int primary key, note text);

CREATE UNLOGGED TABLE unlogged01(id int primary key, t text);


---------------------------------------------------------
CREATE TABLE student(no int, name varchar(20), age int default 15);
UPDATE student set age = 16;
UPDATE student set age = DEFAULT where no = 2;
CREATE TABLE blog(id int, title text, created_date timestamp default now());

-------------------------- 约束 --------------------------
-- 检查约束
CREATE TABLE persons(
    name varchar(40),
    age int CHECK(age >= 0 and age <= 150),
    sex boolean
);

CREATE TABLE persons(
    name varchar(40),
    age int CONSTRAINT check_age CHECK(age >= 0 and age <= 150),
    sex boolean
);

CREATE TABLE books(
    book_no integer,
    name text,
    price numeric CHECK(price > 0),
    discounted_price numeric CHECK(discounted_price > 0),
    CHECK(price > discounted_price)
);

CREATE TABLE books(
    book_no integer,
    name text,
    price numeric,
    discounted_price numeric CHECK(price > 0)
    CHECK(discounted_price > 0)
    CHECK(price > discounted_price)
);

CREATE TABLE books(
    book_no integer,
    name text,
    price numeric,
    discounted_price numeric,
    CHECK(price > 0 and discounted_price > 0 and price > discounted_price)
);

CREATE TABLE books(
    book_no integer,
    name text,
    price numeric,
    discounted_price numeric CHECK(price > 0),
    CHECK(discounted_price > 0),
    CONSTRAINT valid_disconunt CHECK(price > discounted_price)
);

-- 非空约束
CREATE TABLE books(
    book_no integer not null,
    name text,
    price numeric
);

CREATE TABLE books(
    book_no integer not null,
    name text,
    price numeric NOT NULL CHECK(price > 0)
);

-- 唯一约束
CREATE TABLE books(
    book_no integer UNIQUE,
    name text,
    price numeric
);

CREATE TABLE books(
    book_no integer,
    name text,
    price numeric,
    UNIQUE(book_no)
);

-- 主键约束
CREATE TABLE books(
    book_no integer primary key,
    name text,
    price numeric,
    UNIQUE(book_no)
);

ALTER TABLE books ADD CONSTRAINT pk_books_book_no primary key (book_no);

-- 外键约束
CREATE TABLE class(
    class_no int primary key,
    class_name varchar(40)
);

CREATE TABLE student(
    student_no int primary key,
    student_name varchar(40),
    age int,
    class_no int REFERENCES class(class_no)
);

-------------------------- 修改表 --------------------------
CREATE TABLE class(
    class_no int primary key,
    class_name varchar(40)
);
-- 增加字段
ALTER TABLE class ADD COLUMN class_teacher varchar(40);
ALTER TABLE class ADD COLUMN class_teacher varchar(40) CHECK(class_teacher <> '');

-- 删除字段
ALTER TABLE class DROP COLUMN class_teacher;

-- 增加约束
ALTER TABLE student ADD CHECK(age < 16);
ALTER TABLE class ADD CONSTRAINT unique_class_teacher UNIQUE(class_teacher);
ALTER TABLE student ALTER COLUMN student_name SET NOT NULL;

-- 删除约束
ALTER TABLE student DROP CONSTRAINT constraint_name;

-- 修改默认值
ALTER TABLE student ALTER COLUMN age SET DEFAULT 15;

-- 删除默认值
ALTER TABLE student ALTER COLUMN age DROP DEFAULT;

-- 修改字段数据类型
ALTER TABLE student ALTER COLUMN student_name TYPE text;

-- 重命名字段
ALTER TABLE books RENAME COLUMN book_no TO book_id;

-- 重命名表
ALTER TABLE class RENAME TO classes;
