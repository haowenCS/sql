CREATE TABLE score(
    student_name varchar(40),
    chinese_score int,
    math_socre int,
    test_date date
    );

CREATE TABLE student(no int primary key, student_name varchar(40), age int);
DROP TABLE student;

INSERT INTO studnet VALUES(1, '张三', 14);
INSERT INTO studnet(no, age, studnet_name) VALUES(2, 13, '李四');
UPDATE student SET age = 15;
DELETE FROM student WHERE no = 3;

SELECT no, student_name, age FROM student;
SELECT age+5 FROM student;
SELECT no, 3+5 FROM student;

SELECT * FROM student where no = 3;
SELECT * FROM student where age >= 3;
SELECT * FROM student ORDER BY age;
SELECT * FROM studnet ORDER BY age, studnet_name;
SELECT * FROM studnet WHERE age >= 15 ORDER BY age;
SELECT * FROM studnet WHERE age >= 15 ORDER BY age DESC;

SELECT age, count(*) FROM student GROUP BY age;


CREATE TABLE class(no int primary key, class_name varchar(40));
INSERT INTO class VALUES(1, '初二(1)班');
INSERT INTO class VALUES(2, '初二(2)班');
INSERT INTO class VALUES(3, '初二(3)班');
INSERT INTO class VALUES(4, '初二(4)班');

CREATE TABLE student(no int primary key, student_name varchar(40), age int, class_no int);
INSERT INTO student VALUES(1, '张三', 14, 1);
INSERT INTO student VALUES(3, '吴二', 15, 1);
INSERT INTO student VALUES(3, '李四', 13, 2);
INSERT INTO student VALUES(4, '吴三', 15, 2);
INSERT INTO student VALUES(5, '王二', 15, 3);
INSERT INTO student VALUES(6, '李三', 14, 3);
INSERT INTO student VALUES(7, '吴二', 15, 4);
INSERT INTO student VALUES(8, '张四', 14, 4);

SELECT student_name, class_name FROM student, class WHERE student.class_no = class.no;

SELECT * FROM student WHERE class_no in(SELECT no FROM class WHERE class_name = '初二(1)班');
SELECT * FROM student s WHERE EXISTS (SELECT 1 FROM class c WHERE s.class_no = c.no AND c.class_name = '初二(1)班');
SELECT * FROM student WHERE class_no = (SELECT no FROM class WHERE class_name = '初二(1)班');
SELECT * FROM student WHERE class_no = any(SELECT no FROM class c WHERE class_name = '初二(1)班');

CREATE TABLE student_bak(no int primary key, student_name varchar(40), age int, class_no int);
INSERT INTO student_bak SELECT * FROM student;

