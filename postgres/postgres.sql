SELECT version();

SELECT current_date;

-- pg server --> a database cluster --> databases --> tables
----------------------------------- basic
-- create table
CREATE TABLE weather (
    city varchar(80),
    temp_lo int, -- low temperature
    temp_hi int, -- high temperature
    prcp real, -- precipitation
    date date
);

/*
suport data type
1) standard SQL types
int, smallint, real, double precision, char(N), varchar(N), date, time, timestamp, interval
2) types of general utility and a rich of geometric types
    point
3) user-defined data types
*/

CREATE TABLE cities(
    name varchar(80),
    location point
);

SELECT tablename FROM pg_tables WHERE schemaname='public';

-- insert data into table
INSERT INTO weather VALUES ('San Francisco', 46, 50, 0.25, '1994-11-27');
INSERT INTO weather (city, temp_lo, temp_hi, prcp, date)
    VALUES ('San Francisco', 43, 57, 0.0, '1994-11-29');
---- different order
INSERT INTO weather (date, city, temp_hi, temp_lo)
    VALUES ('1994-11-29', 'Hayward', 54, 37);

INSERT INTO cities VALUES ('San Francisco', '(-194.0, 53.0)');

---- copy data from flat-text file
COPY weather FROM '/mnt/d/weather.txt';

---- copy data to flat-text file
COPY (SELECT * FROM weather) TO '/mnt/d/weather.txt';

-- query data of table
SELECT * FROM weather;
SELECT city, temp_lo, temp_hi, prcp, date FROM weather;
SELECT city, (temp_hi+temp_lo)/2 AS temp_avg, date FROM weather;
SELECT * FROM weather WHERE city = 'San Francisco' AND prcp > 0.0;
SELECT * FROM weather ORDER BY city;
SELECT * FROM weather ORDER BY city, temp_lo;
SELECT DISTINCT city FROM weather;
SELECT DISTINCT city FROM weather ORDER BY city;

-- join query
SELECT * FROM weather, cities WHERE city = name;
SELECT city, temp_lo, temp_hi, prcp, date, location
    FROM weather, cities
    WHERE city = name;
SELECT weather.city, weather.temp_lo, weather.temp_hi,
    weather.prcp, weather.date, cities.location
    FROM weather, cities
    WHERE cities.name = weather.city;
---- inner join
SELECT * FROM weather INNER JOIN cities ON (weather.city = cities.name);
---- left outer join
SELECT * FROM weather LEFT OUTER JOIN cities ON (weather.city = cities.name);
---- right outer join
SELECT * FROM weather RIGHT OUTER JOIN cities ON (weather.city = cities.name);
---- self join
SELECT W1.city, W1.temp_lo AS low, W1.temp_hi AS high,
    W2.city, W2.temp_lo AS low, W2.temp_hi AS high
    FROM weather W1, weather W2
    WHERE W1.temp_lo < W2.temp_lo
    AND W1.temp_hi > W2.temp_hi;
---- use alias
SELECT * FROM weather w, cities c WHERE w.city = c.name;

-- aggregate functions
SELECT max(temp_lo) FROM weather;
SELECT city FROM weather WHERE temp_lo = (SELECT max(temp_lo) FROM weather);
SELECT city, max(temp_lo) FROM weather GROUP BY city;
SELECT city, max(temp_lo) FROM weather GROUP BY city HAVING max(temp_lo) < 40;
/*
Differ of aggregate, WHERE, HAVING
        WHERE selects input rows before group and aggregates are computed, it controls which rows go into the
            aggregate computation, thus WHERE clause must not contain aggregate functions
        HAVING selects group rows after groups and aggregates are computed, HAVING clause always contains
            aggregate functions.
 */
SELECT city, max(temp_lo) FROM weather WHERE city LIKE 'S%' GROUP BY city HAVING max(temp_lo) < 40;

-- updates
SELECT * FROM weather;
UPDATE weather SET temp_hi = temp_hi - 2, temp_lo = temp_lo - 2 WHERE date > '1994-11-28';
SELECT * FROM weather;

-- deletions
DELETE FROM weather WHERE city = 'Hayward';
DELETE FROM weather;

-- truncate table
TRUNCATE TABLE weather;

-- drop table
DROP TABLE weather;
DROP TABLE cities;


----------------------------------- advanced features
/*
 view, foreign keys, transaction, window functions, inheritance
 */
-- view
CREATE VIEW myview AS SELECT city, temp_lo, temp_hi, prcp, date, location
    FROM weather, cities
    WHERE city = name;
SELECT * FROM myview;
DROP VIEW myview;

-- foreign keys
CREATE TABLE cities(
    city varchar(80) primary key,
    location point
);

CREATE TABLE weather (
    city varchar(80) references cities(city),
    temp_lo int,
    temp_hi int,
    prcp real,
    date date
);

INSERT INTO weather VALUES ('Berkeley', 45, 53, 0.0, '1994-11-28');

-- transactions
/*
    transaction bundles multiple steps into a single, all-or-nothing operation. the intermediate states between
the steps are not visible to other concurrent transactions, and if some failure occurs that prevents the
transaction from completing, then none of the steps affect the database at all.
    atomicity, consistency, isolation, durability
PostgreSQL actually treats every SQL statement as being executed within a transaction.
    savepoint, allow you to selectively discard parts of the transaction, while committing the rest.
 */
BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
-- etc etc
COMMIT;

BEGIN;
UPDATE accounts SET balance = balance - 100.00
    WHERE name = 'Alice';
SAVEPOINT my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Bob';
-- oops ... forget that and use Wally's account
ROLLBACK TO my_savepoint;
UPDATE accounts SET balance = balance + 100.00
    WHERE name = 'Wally';
COMMIT;

-- window functions
/*
A window function performs a calculation across a set of table rows that are somehow related to the
current row. This is comparable to the type of calculation that can be done with an aggregate function.
However, window functions do not cause rows to become grouped into a single output row like nonwindow
aggregate calls would
 */
SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;
SELECT depname, empno, salary, rank() OVER (PARTITION BY depname ORDER BY salary DESC)
    FROM empsalary;

SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;

-- inheritance
/*
In PostgreSQL, a table can inherit from zero or more other tables
 */
---- old
CREATE TABLE capitals (
    name text,
    population real,
    elevation int, -- (in ft)
    state char(2)
);
CREATE TABLE non_capitals (
    name text,
    population real,
    elevation int -- (in ft)
);
CREATE VIEW cities AS SELECT name, population, elevation FROM capitals
    UNION SELECT name, population, elevation FROM non_capitals;

---- inherit
CREATE TABLE cities (
    name text,
    population real,
    elevation int -- (in ft)
);

CREATE TABLE capitals (
    state char(2)
) INHERITS (cities);

-- parent and child
SELECT name, elevation FROM cities WHERE elevation > 500;
-- only parent
SELECT name, elevation FROM ONLY cities WHERE elevation > 500;

----------------------------------------------
SELECT * FROM weather;
SELECT * FROM cities;

DROP TABLE weather;
DROP TABLE cities;
select * from pg_tables where schemaname = 'public';
