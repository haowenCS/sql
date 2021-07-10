create table grade (
  gno varchar(20) primary key
);

create table class (
    classno varchar(20) primary key ,
    classname varchar(30),
    gno varchar(20),
    foreign key (gno) references grade(gno)
);

create table student (
    sno varchar(20) primary key,
    sname varchar(30),
    sex varchar(5),
    age int,
    nation varchar(20),
    classno varchar(20)
);

create table course (
    cno varchar(20) primary key,
    cname varchar(30),
    credit int,
    priorcourse varchar(20),
    foreign key (priorcourse) references course(cno)
);

create table sc (
    sno varchar(20),
    cno varchar(20),
    score int,
    primary key (sno, cno),
    foreign key (sno) references student(sno),
    foreign key (cno) references course(cno)
);

select classno, classname, AVG(score) as avg_score
from sc, (SELECT * FROM class WHERE class.gno = '2005') as sub
where sc.sno IN (select sno from student where student.classno = sub.classno) and
sc.cno IN(select course.cno from course where course.cname = '高等数据')
group by classno, classname
having avg(score) > 80.0
order by avg_score;
