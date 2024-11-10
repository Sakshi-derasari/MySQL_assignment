create database q3;
use q3;

create table employee(Employee_id int primary key,First_name varchar(50),Last_name varchar(50),Salary int,Joning_date varchar(100),Department varchar(50));
insert into employee values(1,"John","Abraham",1000000,"01-JAN-13 12.00.00 AM","Banking"),(2,"Michael","Clarke",800000,"01-JAN-13 12.00.00 AM","Insurance"),(3,"Roy","Thomas",700000,"01-FEB-13 12.00.00 AM","Banking"),(4,"Tom","Jose",600000,"01-FEB-13 12.00.00 AM","Insuarnce"),(5,"Jerry","Pinto",650000,"01-FEB-13 12.00.00 AM","Insurance"),(6,"Philip","Mathew",750000,"01-JAN-13 12.00.00 AM","Services"),(7,"TestName1","123",650000,"01-JAN-13 12.00.00 AM","Services"),(8,"TestName2","Lname%",6000000,"01-FEB-13 12.00.00 AM","Insurance");
select*from employee;

create table incentive(Employee_ref_id int ,foreign key(Employee_ref_id) references employee(Employee_id),Incentive_date varchar(100) ,Incentive_amount int);
insert into incentive values(1,"01-FEB-13",5000),(2,"01-FEB-13",3000),(3,"01-FEB-13",4000),(1,"01-JAN-13",4500),(2,"01-JAN-13",3500);
select*from incentive;

select First_name as Employee_name from Employee where First_name="Tom";
select First_name,Joning_date,Salary from employee;
select*from employee order by First_name asc, Salary desc;
select*from employee where First_name="John";
select department,Salary from employee order by Salary asc;

SELECT employee.First_name, incentive.incentive_amount
FROM employee
INNER JOIN incentive
ON employee.employee_id = incentive.Employee_ref_id
where Incentive_amount>3000;

CREATE TABLE view_table (
    view_id INT PRIMARY KEY AUTO_INCREMENT,
    Employee_id INT NOT NULL,
    First_name VARCHAR(50),
    Last_name VARCHAR(50),
    Salary DECIMAL(10, 2),
    Joning_date VARCHAR(100),
    Department VARCHAR(50)
);

drop table view_table;


DELIMITER //

CREATE TRIGGER after_employee_insert
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO view_table (Employee_id, First_name, Last_name, Salary, Joning_date, Department)
    VALUES (NEW.Employee_id, NEW.First_name, NEW.Last_name, NEW.Salary, NEW.Joning_date, NEW.Department);
END //
DELIMITER ;

drop trigger after_employee_insert;

insert into employee values(11,"John","Abraham",1000000,"01-JAN-13 12.00.00 AM","Banking");
select*from employee;