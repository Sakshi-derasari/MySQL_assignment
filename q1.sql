create database q1;
use q1;

create table student(Rollno int primary key, Name varchar(20), Branch varchar (100));
insert into student values(1,"Jay","Computer Science"),(2,"Suhani","Electronic and Com"),(3,"Kriti","Electronic and Com");

create table exam(Rollno int, Foreign key(Rollno) references student(Rollno), S_code varchar(50), Marks int, P_code varchar(20));
insert into exam values (1,"CS11",50,"CS"),(1,"CS12",60,"CS"),(2,"EC101",66,"EC"),(2,"EC102",70,"EC"),(3,"EC101",45,"EC"),(3,"EC102",50,"EC");

select*from student;
select*from exam;