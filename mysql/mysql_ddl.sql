-- database
CREATE DATABASE nba;
DROP DATABASE nba;

-- table
CREATE TABLE player  (
  player_id int(11) PRIMARY KEY AUTO_INCREMENT ,
  player_name varchar(255) NOT NULL
);

-- modify table
-- add column
ALTER TABLE player ADD (age int(11));
-- rename
ALTER TABLE player RENAME COLUMN age to player_age;
-- modify data type of column
ALTER TABLE player MODIFY player_age float(3,1);
-- delete column
ALTER TABLE player DROP COLUMN player_age;

-- view
CREATE VIEW player_above_avg_height AS
    SELECT player_id, height
    FROM player
    WHERE height > (SELECT AVG(height) from player);

SELECT * FROM player_above_avg_height;