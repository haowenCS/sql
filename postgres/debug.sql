-- 查询数据库oid
SELECT datname, oid FROM pg_database WHERE datname = 'sampledb';

-- 查询表oid
SELECT relname, oid FROM pg_class WHERE relname = 'sampletbl';

-- 根据oid或名称返回关系对应的文件路径
SELECT pg_relation_filepath('sampletbl');

-- TID扫描
SELECT ctid, data FROM sampletbl WHERE ctid='(0,1)';
