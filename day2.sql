/* SQl Functions */

/* average*/
select fName , lName 
from employees 
where salary >(select AVG(salary) from employees);

/* count*/
select dName ,COUNT(id)
from department,employees
where EId=id
group by (dName);

/* max*/
select fName , lName
from employees
where salary<(select MAX(salary) from employees);

/* min*/
select fName , lName
from employees
where salary>(select min(salary) from employees);

/* sum*/
select SUM(department) from employees;

/* Group By*/
select dName ,COUNT(id)
from department,employees
where EId=id
group by (dName);

/* UCASE */
select fName , UPPER(lName)
from employees;

/*lcase*/
select fName , lower(lName)
from employees;

/*len*/
select LEN(salary) 
from employees;

/* round*/
select fName ,ROUND(pf,0)
from employees;
/* Getdate */
select *, GETDATE() as currentdate
from employees;

/*Convert */
select *, CONVERT(VARCHAR(10),GETDATE(),103)as currentdate
from employees;

/*cast*/
select * ,cast(id as varchar(10)) from employees;

/* Case Statements */
SELECT fName, CASE
  WHEN salary >= 30000 AND age>20 then 'Yes'
  ELSE 'No'
  END
"Salary Status"
FROM employees;


/* Ranking function */

select * from (SELECT fName,lName,salary,
rank() over(order by salary desc)as rank
from employees) as abc
where abc.rank<4;

select * from (SELECT fName,lName,salary,
row_number() over(order by salary desc)as rank
from employees) as abc
where abc.rank%2=1;


 
-- Query with CTE
with salary_cte(fName, lName , salary)
as
( select fName, lName, salary
from employees
) 
select * from salary_cte;
 
--rollup
select dName ,COUNT(id) as [no of employees],SUM(salary) as[total salay]
from department,employees
where EId=id
group by dName ,id with rollup; 

--cube
select dName ,COUNT(id) as [no of employees],SUM(salary) as[total salay]
from department,employees
where EId=id
group by dName,id with cube; 

--intersect and except
select fName from employees
intersect
select fName from employees 
where designation=2;
--correlated subqueries
SELECT *
FROM employees
WHERE salary IN 
  ( 
		SELECT TOP (3) salary
		FROM employees
		GROUP BY salary
		ORDER BY salary 
  );
--runnung aggregates

  