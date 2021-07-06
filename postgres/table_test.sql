-- table with partition
CREATE TABLE measurement(
  city_id int not null,
  logdate date primary key,
  peaktemp int,
  unitsales int
) PARTITION BY RANGE(logdate);

select tablename from pg_tables where schemaname='public';
DROP TABLE measurement;

CREATE TABLE measurement_y2006m02 PARTITION OF measurement
    FOR VALUES FROM ('2006-02-01') TO ('2006-03-01');

CREATE TABLE measurement_y2006m03 PARTITION OF measurement
    FOR VALUES FROM ('2006-03-01') TO ('2006-04-01');