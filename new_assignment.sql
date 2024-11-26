create database school_db;
use school_db;
create table students(student_id int primary key,student_name varchar(50),age int,class int,address varchar(50));
insert into students values(1,"sakshi",15,10,"vapi"),(2,"nisha",16,11,"valsad"),(3,"brijal",16,11,"surat"),(4,"vatsal",17,12,"vadodra"),(5,"hardik",14,09,"surat");
select * from students;
select student_name,age from students;
select * from students where age>10;

create table teachers(teacher_id int,foreign key(teacher_id) references students(student_id), teacher_name varchar(50) not null,subject varchar(50) not null,email varchar(100) unique);

create table courses(course_id int primary key,course_name varchar(50),course_credits int);
create database university_db;
alter table courses add course_duration varchar(50);
alter table courses drop course_credits;
drop table teachers;
drop table students;
show tables;
describe courses;
insert into courses values(123,"electronics","2 hour"),(324,"information technology","1 hour"),(567,"computer","3 hour");
update courses set course_duration="5 hour" WHERE course_name="electronics";
delete from courses where course_id=567;
select*from courses;
select *from courses order by course_duration desc;
select*from courses limit 2;

create user 'user1'@'localhost' 
identified by 'mypassword';

grant create, alter, drop
on school_db.*
to 'user1'@'localhost';

grant select,insert,update,delete
on courses.* to 'user1'@'localhost';

create user 'user2'@'localhost' 
identified by 'mypassword1';

revoke insert on school_db.* from 'user1'@'localhost';
grant insert on courses.* to 'user2'@'localhost';

insert into courses values(890,"english","2 hour"),(478,"science","3 hour"),(246,"mathematics","1 hour");
commit;

insert into courses values (104, 'Web Development', 3),(105, 'Operating Systems', 4),(106, 'Machine Learning', 3);
rollback;

SAVEPOINT before_update;

UPDATE courses
SET course_duration = 4
WHERE course_id = 104;  

UPDATE courses
SET course_duration = 5
WHERE course_id = 105;  
ROLLBACK TO SAVEPOINT before_update;
COMMIT;   

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);


CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name)
VALUES (1, 'accountant'),(2, 'Engineer'),(3, 'doctor'),(4, 'Marketing');

INSERT INTO employees (employee_id, employee_name, department_id)
VALUES (201, 'sakshi', 1),(202, 'nisha', 2),(203, 'brijal', 3),(204, 'hardik', 2),(205, 'vatsal', 4);

    SELECT employees.employee_name, departments.department_name
FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

SELECT departments.department_name, employees.employee_name
FROM departments
LEFT JOIN employees ON departments.department_id = employees.department_id;
insert into departments values(5, 'Legal');

SELECT department, count(employee_id) AS num_employees
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

SELECT column_name(s)
FROM table_name
GROUP BY column_name(s);

DELIMITER //  

CREATE PROCEDURE GetEmployeesByDepartment(IN dept_name VARCHAR(100))
BEGIN
    SELECT employee_id, employee_name, department, salary
    FROM employees
    WHERE department = dept_name;
END//

DELIMITER ;

CALL GetEmployeesByDepartment('accountant');
CALL GetEmployeesByDepartment('accountant');

DELIMITER //

CREATE PROCEDURE GetCourseDetailsById(IN course_id INT)
BEGIN

    SELECT course_id, course_name, department, instructor, duration
    FROM courses
    WHERE course_id = course_id;
END//

DELIMITER ; 

CALL GetCourseDetailsById(201);
CALL GetCourseDetailsById(201);

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM 
    Employees e
JOIN 
    Departments d
    ON e.department_id = d.department_id;

SELECT * FROM EmployeeDepartmentView;

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name
FROM 
    Employees e
LEFT JOIN 
    Departments d
    ON e.department_id = d.department_id;

CREATE VIEW EmployeeDepartmentView AS 
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM 
    Employees e
JOIN 
    Departments d
    ON e.department_id = d.department_id
WHERE 
    e.salary >= 50000;
SELECT * FROM EmployeeDepartmentView;

CREATE TABLE employee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,  
    employee_id INT,                         
    action VARCHAR(50),                      
    name VARCHAR(255),                       
    department VARCHAR(255),                 
    salary DECIMAL(10, 2),                   
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

DELIMITER //
CREATE TRIGGER log_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit VALUES (NEW.employee_id, 'INSERT', NEW.name, NEW.department, NEW.salary, NOW());
end //
DELIMITER ;

ALTER TABLE employees
ADD COLUMN last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DELIMITER //
CREATE TRIGGER update_last_modified
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE employees
    SET last_modified = NOW()
    WHERE employee_id = NEW.employee_id;
END//
DELIMITER ;

DELIMITER //
DECLARE 
    v_employee_count NUMBER;
BEGIN
    -- Query to get the count of employees from the employees table
    SELECT COUNT(*) INTO v_employee_count FROM employees;

    -- Output the result to the console or DBMS output
    DBMS_OUTPUT.PUT_LINE('Total number of employees: ' || v_employee_count);
END//
DELIMITER ;

DELIMITER //
DECLARE
    v_total_sales NUMBER;
BEGIN

    SELECT SUM(order_amount) INTO v_total_sales FROM orders;

    -- Output the total sales result
    DBMS_OUTPUT.PUT_LINE('Total Sales: ' || NVL(v_total_sales, 0));
END//
DELIMITER ;

DELIMITER //
DECLARE
    v_employee_id NUMBER := 101;  -- Employee ID to check
    v_department_id NUMBER;       -- Variable to store the department ID
BEGIN
    -- Retrieve the department ID for the given employee
    SELECT department_id INTO v_department_id
    FROM employees
    WHERE employee_id = v_employee_id;

    -- Check the department ID and output corresponding message
    IF v_department_id = 10 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' works in the HR department.');
    ELSIF v_department_id = 20 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' works in the IT department.');
    ELSIF v_department_id = 30 THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' works in the Finance department.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_employee_id || ' belongs to an unknown department.');
    END IF;
END//
DELIMITER ;

DELIMITER //
DECLARE
BEGIN
    FOR employee_record IN (SELECT employee_id, employee_name FROM employees) LOOP
        DBMS_OUTPUT.PUT_LINE('Employee Name: ' || employee_record.employee_name);
    END LOOP;
END//
DELIMITER ;

DELIMITER //
DECLARE
  v_name VARCHAR2(50);
BEGIN
  SELECT first_name INTO v_name FROM employees WHERE employee_id = 100;
  DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_name);
END//
DELIMITER ;

DELIMITER //
DECLARE
  CURSOR emp_cursor IS
    SELECT first_name, last_name FROM employees;
  v_first_name VARCHAR2(50);
  v_last_name VARCHAR2(50);
BEGIN
  OPEN emp_cursor;  
  LOOP
    FETCH emp_cursor INTO v_first_name, v_last_name;
    EXIT WHEN emp_cursor%NOTFOUND;  
    DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name);
  END LOOP;
  CLOSE emp_cursor; 
END//
DELIMITER ;

BEGIN;
SAVEPOINT savepoint_1;
INSERT INTO employees VALUES (101, 'John', 'Doe'),(102, 'Jane', 'Smith'),(103, 'Alice', 'Johnson');
ROLLBACK TO SAVEPOINT savepoint_1;
COMMIT;
BEGIN;
SAVEPOINT savepoint_1;

INSERT INTO employees VALUES (101, 'John', 'Doe'),(102, 'Jane', 'Smith'),(103, 'Alice', 'Johnson');  
COMMIT;

ROLLBACK TO SAVEPOINT savepoint_1;
COMMIT;