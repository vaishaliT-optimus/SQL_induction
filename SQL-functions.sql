-- sql procedures functions and triggers
CREATE TABLE Employee_salary (
EmpId INT Primary key,
Basicc INT NOT NULL,
HR INT NOT NULL,
DA INT NOT NULL,
Gross INT DEFAULT NULL

);

create trigger update_salary
 on Employee_salary
 after insert
as
begin
update Employee_salary set Gross=Basicc+HR+DA;

end;

update Employee_salary
set Gross='';


--cursors
declare 
@cBasicc int,
@cHR int,
@cDA int;

declare 
cemployeesalary cursor 
for select Basicc,HR,DA from Employee_salary where EmpId>2 ;

open cemployeesalary;

fetch next from cemployeesalary
into @cBasicc, @cHR, @cDA;

begin
update Employee_salary
set Gross=(Basicc+HR+DA)*12;
end;

select * from Employee_salary

--functions

DECLARE @Num INT;
CREATE FUNCTION Leap(@Num INT)
 RETURNS NVARCHAR(MAX)
 AS
BEGIN
DECLARE @Temp NVARCHAR(MAX);
IF(@Num%400=0 )
  SET @Temp='LEAP YEAR';
ELSE IF(@Num%100=0)
	SET @Temp= 'NOT A LEAP YEAR';
ELSE IF(@Num%4=0)
	SET @Temp='LEAP YEAR'; 
ELSE
	SET @Temp='NOT A LEAP YEAR';
RETURN @Temp;
END;
GO
SELECT dbo.Leap(2000) as Result;

---stored procedure

create procedure getEmpDetails3

@empID Int
--@fName char(50),@lname char(50) 
 
As 
Begin
select fName ,lName , dName ,gross
from employees , department ,Employee_salary
where id=@empID
and EmpId=id and id=EId

--print fName;
end

declare @fName char(50);
declare @lname char(50); 
execute getEmpDetails3 2  ;
print @fName + @lname;

--exception handling in procedures
CREATE PROCEDURE usp_ExampleProc
AS
    SELECT * FROM NonexistentTable;
GO

BEGIN TRY
    EXECUTE usp_ExampleProc;
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;