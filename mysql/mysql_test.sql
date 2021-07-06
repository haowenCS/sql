create table test_table(
    tb_id int);

LOCK TABLE test_table READ;

insert into test_table values(1);

unlock table;