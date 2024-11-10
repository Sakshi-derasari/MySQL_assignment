create database q4;
use q4;
create table salesperson(SNo int primary key, SNAME varchar(20), CITY varchar(20), COMM decimal(10,2));
describe salesperson;
drop table salesperson;
insert into salesperson values(1001,"Peel","London",.12),(1002,"Serres","San Jose",.13),(1004,"Motika","London",.11),(1007,"Rafkin","Barcelona",.15),(1003,"Axelrod","New York",.1);
select*from salesperson;

create table customer(CNM int primary key, CNAME varchar(20),CITY varchar(20),RATING int, SNo int, foreign key(SNo) references salesperson(SNo));
insert into customer values(201,"Hoffman","London",100,1001),(202,"Giovanne","Roe",200,1003),(203,"Liu","San Jose",300,1002),(204,"Grass","Barcelona",100,1002),(206,"Clemens","London",300,1007),(207,"Pereira","Roe",100,1004);
select*from customer;

select * from salesperson where CITY="London"and COMM>.12;
select * from salesperson where CITY = "Barcelona" or CITY = "London";
select * from salesperson where COMM>.10 and COMM <.12;
select * from customer where RATING <= 100 and CITY ="Roe";
