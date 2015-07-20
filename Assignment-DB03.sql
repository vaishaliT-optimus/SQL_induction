/* Assignment-DB03

creating Database */
create database Employee_Master;

--creating table t_emp

create table t_emp(
Emp_id int identity(1001,2) primary key,
Emp_Code varchar(20),
Emp_f_name char(20) NOT NULL,
Emp_m_nmae char(20),
Emp_l_name char(20),
Emp_DOB date check(year(getdate())-year(Emp_DOB)>=18),
Emp_DOJ date NOT NULL
);

-- creating table t_activity

create table t_activity
(
Activity_id int primary key,
Activity_description char(30)
);

--creating table t_atten_det
create table t_atten_det
(
Atten_id int identity(1001,1),
Emp_id int,
Activity_id int,
Atten_start_datetime datetime,
Atten_end_hrs int
);
--adding foreign key 
alter table t_atten_det
add constraint fk_emp_id
foreign key(Emp_id)
references t_emp(Emp_id);

alter table t_atten_det
add constraint fk_activity_id
foreign key(Activity_id)
references t_activity(Activity_id);

--creating table t_salary
create table t_salary
(
Salary_id int ,
Emp_Id int,
Changed_date date,
New_Salary decimal(10,2)
);

--inserting value in  t_emp
insert into t_emp
values('OPT20110105','Manmohan','','Singh','1983-02-10','2010-05-25');

insert into t_emp
values('OPT20100915','Alfred','joseph','Lawrence','1988-02-28','');

select * from t_emp;

--inserting into table t_activity
insert into t_activity 
values(1,'Code Analysis');

insert into t_activity 
values(2,'Lunch');

insert into t_activity 
values(3,'Coding');

insert into t_activity 
values(4,'Knowledge Transition');

insert into t_activity 
values(5,'Database');

--inserting values in t_atten_det table
insert into t_atten_det
values(1001,5,'2011-2-13 10:00:00',2);

insert into t_atten_det
values(1001,1,'2011-1-14 10:00:00',3);

insert into t_atten_det
values(1001,3,'2011-1-14 13:00:00',5);

insert into t_atten_det
values(1003,5,'2011-2-16 10:00:00',8);



insert into t_atten_det
values(1003,5,'2011-2-17 10:00:00',8);

insert into t_atten_det
values(1003,5,'2011-2-19 10:00:00',7);


select * from t_atten_det;

truncate table t_atten_det

--inserting values in t_salary

insert into t_salary 
values(1001,1003,'2011-2-16',20000.00);

insert into t_salary 
values(1002,1003,'2011-1-05',25000.00);

insert into t_salary 
values(1003,1001,'2011-2-16',26000.00);

select * from t_salary;

/*Display full name and date of birth those employees whose birth date falls in the last day of any
month.*/

SELECT  
ISNULL(Emp_f_name,'') + ' ' + 
ISNULL(Emp_m_nmae,'') + ' ' + 
ISNULL(Emp_l_name,'') as FullName,
t_emp.Emp_DOB 
from t_emp
where datepart(d, dateadd(day, 1, Emp_DOB)) = 1


/*Display employee full name, got increment in salary?, previous salary, current salary, total

worked hours , last worked activity and hours worked in that.*/

SELECT Emp_f_name+' '+Emp_m_nmae+' '+Emp_l_name AS Name,
Increment,PreviousSalary,CurrentSalary, TotalWorkedHours,
Sub2.Activity_id AS LastWorkedId, Sub2.Atten_end_hrs AS LastHourWorked
FROM(
SELECT Emp_Id,
CASE
	WHEN COUNT(Emp_Id)>1 
	THEN 'Yes'
	ELSE 'No'
END AS Increment,
CASE
	WHEN COUNT(Emp_Id)>1 
	THEN MIN(New_Salary)
	ELSE 0
END AS PreviousSalary,
MAX(New_Salary) AS CurrentSalary
FROM T_Salary
GROUP BY Emp_Id) AS Subquery1

JOIN T_Emp
ON T_Emp.Emp_Id=Subquery1.Emp_Id

JOIN
(
SELECT Emp_id, SUM(Atten_end_hrs)AS TotalWorkedHours
FROM t_atten_det
GROUP BY Emp_Id
) AS Subquery2
ON Subquery1.Emp_Id=Subquery2.Emp_Id


JOIN  (SELECT Sub1.Emp_id,Activity_id,Atten_end_hrs
       FROM t_atten_det AS Sub1
	   JOIN (SELECT Emp_id, MAX(Atten_start_datetime)m  
	   FROM t_atten_det GROUP BY Emp_Id)AS Sub
	   ON Sub.Emp_Id=Sub1.Emp_Id 
	   WHERE Sub1.Atten_start_datetime=Sub.m) AS Sub2
ON Sub2.Emp_Id=T_Emp.Emp_Id