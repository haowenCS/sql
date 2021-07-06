-- 查看有哪些数据库
show databases;

-- 查看db_name 有些哪表
show tables from db_name;

-- 查看当前支持哪些存储引擎
show engines;

-- 查看当前隔离级别
show variables LIKE 'transaction_isolation';

-- 设置隔离级别
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

-- 设置不自动提交
set autocommit = 0;

-- 查看profiling 是否开启，开启可以让MySQL收集SQL执行时所使用的资源情况
select @@profiling;

-- 打开profiling
set profiling=1;

-- 查看当前会话所产生的所有 profiles
show profiles;

-- 获取上一次查询的执行时间
show profile;
show  profile for query 2;

-- 查看 MySQL 的版本情况
select version();

-- 查询各步骤的执行代价
SELECT * FROM mysql.server_cost;
SELECT * FROM mysql.engine_cost;

UPDATE mysql.engine_cost
  SET cost_value = 2.0
  WHERE cost_name = 'io_block_read_cost';
FLUSH OPTIMIZER_COSTS;

-- 给表上锁
LOCK TABLE product_comment READ;
-- 解锁
UNLOCK TABLE;

-- 查看表结构
create table pet (
    name VARCHAR(20),
    owner VARCHAR(20),
    species VARCHAR(20),
    sex CHAR(1),
    birth DATE,
    death DATE
);

desc pet;