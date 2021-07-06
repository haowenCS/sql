SELECT name FROM heros;

SELECT name, hp_max, mp_max, attack_max, defense_max FROM heros;

SELECT * FROM heros;

SELECT name AS n, hp_max AS hm, mp_max AS mm, attack_max AS am, defense_max AS dm FROM heros;

SELECT '王者荣耀' as platform, name FROM heros;

SELECT 123 as platform, name FROM heros;

-- remove repetition rows
SELECT DISTINCT attack_range FROM heros;
SELECT DISTINCT attack_range, name FROM heros;

SELECT name, hp_max FROM heros WHERE hp_max BETWEEN 5399 AND 6811;

SELECT name, hp_max FROM heros WHERE hp_max IS NULL;

SELECT name, hp_max, mp_max FROM heros WHERE hp_max > 6000 AND mp_max > 1700 ORDER BY (hp_max+mp_max) DESC;

SELECT name, hp_max, mp_max FROM heros WHERE (hp_max+mp_max) > 8000 OR hp_max > 6000 AND mp_max > 1700 ORDER BY (hp_max+mp_max) DESC


SELECT name, role_main, role_assist, hp_max, mp_max, birthdate
FROM heros
WHERE (role_main IN ('法师', '射手') OR role_assist IN ('法师', '射手'))
AND DATE(birthdate) NOT BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY (hp_max + mp_max) DESC;

SELECT name FROM heros WHERE name LIKE '%太%';

SELECT ABS(-2);
SELECT  MOD(101, 3);
SELECT ROUND(37.25, 1);

SELECT CONCAT('abc', 123);

SELECT LENGTH('你好');

SELECT CHAR_LENGTH('你好');

SELECT LOWER('ABC');

SELECT UPPER('abc');

SELECT REPLACE('fabcd', 'abc', 123);

SELECT SUBSTRING('fabcd', 1,3);

SELECT CURRENT_DATE();

SELECT CURRENT_TIME();

SELECT CURRENT_TIMESTAMP();

SELECT EXTRACT(YEAR FROM '2019-04-03');

SELECT DATE('2019-04-01 12:00:05');

-- 会报错
SELECT CAST(123.123 AS INT);

-- 123.12
SELECT CAST(123.123 AS DECIMAL(8,2));

-- 返回第一个非空数值
SELECT COALESCE(null,1,2)

SELECT COUNT(*) FROM heros WHERE hp_max > 6000;

SELECT COUNT(role_assist) FROM heros WHERE hp_max > 6000;

SELECT MAX(hp_max) FROM heros WHERE role_main = '射手' or role_assist = '射手';

SELECT COUNT(*), AVG(hp_max), MAX(mp_max),
    MIN(attack_max), SUM(defense_max) FROM heros WHERE role_main = '射手' or role_assist = '射手';

SELECT MIN(CONVERT(name USING gbk)), MAX(CONVERT(name USING gbk)) FROM heros;

SELECT COUNT(DISTINCT hp_max) FROM heros;

SELECT COUNT(*), role_main FROM heros GROUP BY role_main;

SELECT COUNT(*), role_assist FROM heros GROUP BY role_assist;

SELECT COUNT(*) as num, role_main, role_assist FROM heros GROUP BY role_main, role_assist ORDER BY num DESC;

SELECT COUNT(*) as num, role_main, role_assist FROM heros GROUP BY role_main, role_assist HAVING num > 5 ORDER BY num DESC;

SELECT COUNT(*) as num, role_main, role_assist
    FROM heros WHERE hp_max > 6000 GROUP BY role_main, role_assist HAVING num > 5 ORDER BY num DESC;

-- 非关联子查询
SELECT player_name, height FROM player WHERE height = (SELECT max(height) FROM player);

-- 关联子查询
SELECT player_name, height, team_id FROM player AS a WHERE height >
           (SELECT avg(height) FROM player AS b WHERE a.team_id = b.team_id);

SELECT player_id, team_id, player_name FROM player WHERE EXISTS
        (SELECT player_id FROM player_score WHERE player.player_id = player_score.player_id);

SELECT player_id, team_id, player_name FROM player WHERE player_id in
        (SELECT player_id FROM player_score WHERE player.player_id = player_score.player_id);

SELECT player_id, player_name, height FROM player WHERE
         height > ANY (SELECT height FROM player WHERE team_id = 1002);

SELECT player_id, player_name, height FROM player
        WHERE height > ALL (SELECT height FROM player WHERE team_id = 1002);


SELECT team_name, (SELECT count(*) FROM player WHERE player.team_id = team.team_id) AS player_num FROM team;

-- 笛卡尔积/cross join
-- SQL92
SELECT * FROM player, team;
-- SQL99
SELECT * FROM player CROSS JOIN team;
SELECT * FROM t1 CROSS JOIN t2 CROSS JOIN t3;

-- 等值连接
SELECT player_id, player.team_id, player_name, height, team_name FROM player, team WHERE player.team_id = team.team_id;
SELECT player_id, a.team_id, player_name, height, team_name FROM player AS a, team AS b WHERE a.team_id = b.team_id;
-- SQL 99
SELECT player_id, team_id, player_name, height, team_name FROM player NATURAL JOIN team;

-- 非等值连接
SELECT p.player_name, p.height, h.height_level
    FROM player AS p, height_grades AS h
    WHERE p.height BETWEEN h.height_lowest AND h.height_highest

-- 外连接
-- + 表示哪个是从表
SELECT * FROM player, team where player.team_id = team.team_id(+);
-- SQL99
SELECT * FROM player LEFT JOIN team ON player.team_id = team.team_id

SELECT * FROM player LEFT JOIN team on player.team_id = team.team_id;
-- SQL99
SELECT * FROM player RIGHT JOIN team ON player.team_id = team.team_id;

SELECT * FROM player, team where player.team_id(+) = team.team_id;
SELECT * FROM player RIGHT JOIN team on player.team_id = team.team_id;

-- 全外连接
SELECT * FROM player FULL JOIN team ON player.team_id = team.team_id;

-- 自连接
SELECT b.player_name, b.height FROM player as a , player as b
    WHERE a.player_name = '布雷克-格里芬' and a.height < b.height;
-- SQL99
SELECT * FROM player FULL JOIN team ON player.team_id = team.team_id;

SELECT player_id, player.team_id, player_name, height, team_name
    FROM player JOIN team ON player.team_id = team.team_id;

SELECT p.player_name, p.height, h.height_levelFROM player as p JOIN height_grades as h
    ON height BETWEEN h.height_lowest AND h.height_highest;

-- SQL99 使用team_id进行等值连接
SELECT player_id, team_id, player_name, height, team_name FROM player JOIN team USING(team_id);
