CREATE TABLE log_par(
    id serial,
    user_id int4,
    create_time timestamp(0) without time zone
) PARTITION BY RANGE(create_time);

CREATE TABLE log_par_201701 PARTITION OF log_par FOR VALUES FROM ('2017-01-02') TO ('2017-02-01');
CREATE TABLE log_par_201702 PARTITION OF log_par FOR VALUES FROM ('2017-02-01') TO ('2017-03-01');
CREATE INDEX idx_log_par_201701_ctime ON log_par_201701 USING btree(create_time);
CREATE INDEX idx_log_par_201702_ctime ON log_par_201702 USING btree(create_time);

INSERT INTO log_par(id, user_id, create_time)
SELECT round(10000*random()), round(100000000*random()), generate_series('2017-01-02'::date, '2017-02-28'::date, '1 minute');

SELECT COUNT(*) FROM log_par;