#create database

create database project;
use project;

#create tables

create table users(email varchar(20),password varchar(10),role enum('student','admin'));
create table students(reg_no int primary key,name varchar(20),email varchar(20),course_id int,mobile_no int,profile_pic blob); 
create table courses(course_id int,course_name varchar(20),description varchar(40),fees int,start_date date,end_date date ,video_expire_days int);
create table videos(video_id int,course_id int,title varchar(20),description varchar(10),youtube_url varchar(20),added_at date);

insert into courses values(1,'IIT-MERN-2025','MERN',4000,'2025-12-20','2026-01-20',30);
insert into courses values(7,'AI','some course related to AI',10000,'2025-12-24','2026-01-24',5);
insert into courses values(8,'Android','Android related course',9999,'2025-12-24','2026-01-24',7);
insert into courses values(11,'python','py',10000,'2025-12-24','2026-01-24',20);
insert into courses values(3,'IIT-MERN-2025-July','MERN',18000,'2023-12-20','2024-12-20',20);

INSERT INTO users (email, password, role) VALUES
('s1', 'password', 'Student'),
('s2', 'password', 'Student');

INSERT INTO students (reg_no, name, email, course_id, mobile_no, profile_pic) VALUES
(1, 'student1', 's1', 1, 123456, 0x01),
(3, 'student1', 's1', 1, 123456, 0x01),
(6, 'student2', 's2', 3, 123456, 0x01);
insert into students values(10,'student4','s4',7,123456,null); 

INSERT INTO videos (video_id, course_id, title, description, youtube_url, added_at) VALUES
(12, 1, 'MERN video 6', 'MERN', '', '2025-11-26'),
(14, 1, 'MERN 10', 'MERN', '', '2025-11-26');

#Q1. Write a Sql query that will fetch all upcoming courses

select * from courses where start_date >sysdate();

#Q2. Write a Sql query that will fetch all the registered students along with course name

select s.reg_no,s.name,s.email,s.mobile_no,c.course_id,c.course_name from students s
join courses c on s.course_id=c.course_id;

#Q3. Write an SQL query to fetch the complete details of a student (based on their email) along with the details of the course they are enrolled in

select s.reg_no,s.name,s.email,s.mobile_no,c.course_id,c.course_name,c.description,c.fees,c.start_date,c.end_date,c.video_expire_days from students s
join courses c on s.course_id=c.course_id 
where s.email='s1';

#Q4. Write an SQL query to retrieve the course details and the list of non-expired videos for a specific student using their email address. A video is considered active (not expired) if its added_at date plus the course’svideo_expire_days has not yet passed compared to the current date.

select distinct c.course_id,c.course_name,c.start_date,c.end_date,c.video_expire_days,v.video_id,v.title,v.added_at from courses c
join videos v on c.course_id=v.course_id 
join students s on c.course_id=s.course_id 
where s.email='s1'and  date_add(v.added_at , INTERVAL c.video_expire_days DAY) >sysdate();


