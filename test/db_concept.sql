/*
classroom(building, room_number, capacity)
department(dept_name, building, budget)
course(course_id, title, dept_name, credits)
instructor(ID, name, dept_name, salary)
section(course_id, sec_id, semester, year, building, room_number, time_slot_id)
teachers(ID, course_id, sec_id, semester, year)
student(ID, name, dept_name, tot_cred)
takes(ID, course_id, sec_id, semester, year, grade)
advisor(s_ID, i_ID)
time_slot(time_slot_id, day, start_time, end_time)
prereq(course_id, prereq_id)
*/

-- create table classroom(building varchar(100), room_number varchar(10), capacity varchar(100)
--     primary key(building, room_number));

-- create table department(depart_name varchar(100), building varchar(100), budget long);

-- create table course(building varchar(100) primary key);
