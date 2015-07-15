
/* Add constraint commands */
/* primary key */
alter table employees 
add constraint emp_id primary key(id);

/* check constraint*/
alter table employees
add constraint chk_salary check(salary >10000);

/*Default constraint*/
alter table employees
alter column active set default 1;

select * from employees;

/*alter table command*/
alter table employees
alter column designation numeric(10);

create table Designation(
desigName char(50),
desigID numeric(3)primary key);

alter table employees
alter column designation numeric(3);

/* Foreign key*/
alter table employees
add foreign key (designation) 
references Designation(desigID);

/* indexes*/
create unique index name
on employees(fName,lName);

/* in command*/
select * from employees 
where salary in(20000 , 25000);

/* Between Command*/
select * from employees 
where salary between 20000 and 30000;

/* Alias */
select fName as FirstName from employees;

create table department(
dName char(20),
dID numeric(10),
dHead char(20)
);

alter table department
alter column dName char(50);

/* Left Join*/
select fName , lName , department 
from employees left join department
on employees.department = department.dName;

truncate table department;

select * from department;

/* Group By*/
select dName ,COUNT(EId)
from department
group by (dName);

/* Outer Join */
select  department.* , employees.*
from employees full outer join department
on employees.department = department.dName;

create table ABC(
empName char(20)
);

create table LMN(
empName char(20)
);

create table XYZ(
empName char(20)
);

/* Union*/
select empName from ABC
union
select empName from LMN
union
select empName from XYZ;

/* sql select INTO*/
SELECT *
INTO employees_ba IN 'Backup'
FROM employees;

/* increment*/
update employees 
set salary=salary+5000;

/* sql datatypes*/
alter table employees
alter column pf decimal(10,2);

update  employees
set pf=salary*0.1275;

/* date*/
select curdate();

select * from employees
where department=ISNULL(department,'NULL');

alter table employees
add DOJ date;

/* create Views */
create view View1 as
select fName , DOJ
from employees
where designation=2;

select * from View1;

/* average*/
select fName , lName 
from employees 
where salary >(select AVG(salary) from employees);



