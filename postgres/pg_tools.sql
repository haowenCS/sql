-- 查询表 tbname 的索引
select * from pg_statio_all_indexes where relname='products';

create table products (
    product_no integer,
    name text,
    price numeric
);

insert into products values(111, 'water', 1.2);
insert into products values(112, 'oil', 1.3);
insert into products values(113, 'coke', 1.4);

create unique index concurrently on products(product_no);

-- 查询用户创建了哪些表
select tablename from pg_tables where schemaname='public';

drop table products;

--- transaction
BEGIN;
select * from products;
END;

truncate table products;

--- transaction save point
BEGIN;
insert into products values(114, 'apple', 1.5);
SAVEPOINT P1;
insert into products values(115, 'banana', 1.6);
SAVEPOINT P2;
insert into products values(116, 'orange', 1.7);
rollback  to SAVEPOINT P1;
COMMIT;

-- show schema search path
SHOW search_path;

-- 查看索引类型
SELECT * FROM pg_index;

------------------------------------------------------------------------
-- 查看当前数据库
SELECT current_database();

-- 查看当前用户
SELECT user;
SELECT current_user;

SELECT pid, usename, client_addr, client_port FROM pg_stat_activity;

SELECT oid, datname FROM pg_database;

select relnamespace, relname, relfilenode from pg_class where relname='test01';

select enumvals from pg_settings where name = 'client_min_messages';

select unit from pg_settings where name = 'autovacuum_vacuum_cost_delay';

select short_desc,extra_desc from pg_settings where name = 'autovacuum_vacuum_cost_delay';

select name,context from pg_settings where name like 'wal_buffers';

select name,context from pg_settings where name like 'local_preload_libraries';


---- 常用管理命令 ----------------------------------------------------------------------------

-- 查看数据库实例的版本信息
select version();

-- 查看数据库的启动时间
select pg_postmaster_start_time();

-- 查看最后load配置文件的时间
select pg_conf_load_time();

show timezone;

select now();

select user;

select current_user;

select session_user;

select current_catalog, current_database();

select inet_server_addr(), inet_server_port();

select pg_backend_pid();

show shared_buffers;

select current_setting('shared_buffers');

set maintenance_work_mem to '128MB';

select set_config('maintenance_work_mem', '128MB', false);

select pg_xlogfile_name(pg_current_xlog_location());

