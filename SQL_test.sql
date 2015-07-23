--create database
CREATE DATABASE SQLTest;
--creating vendor Table
CREATE TABLE Vendor
(VendorID int Primary Key,
VName char(20)
);

--inserting values in vendor table
INSERT INTO Vendor values(101,'Sai Travels');
INSERT INTO Vendor values(102,'Meru Cabs');
INSERT INTO Vendor values(103,'Miracle Cabs');

--Creating table Cab
CREATE TABLE Cab
(CabID int Primary key,
VendorID int,
Number varchar(4) ,
BrandName char(20)
);
--Addind foreign key
alter table Cab
Add constraint fk_VendorID
 foreign key(VendorID)
references Vendor(VendorID);

insert into Cab Values(201,101,'8529','Mercedes');
insert into Cab Values(202,103,'5764','Jaguar');
insert into Cab Values(203,101,'1967','Lamborghini');
insert into Cab Values(204,102,'7359','Mercedes');
insert into Cab Values(205,103,'1992','Audi');
insert into Cab Values(206,103,'0786','BMW');
insert into Cab Values(207,101,'0007','Audi');
insert into Cab Values(208,102,'8541','Fiat');
select * from Cab;

--Creating User Table
create table User1
(UserID int Primary Key,
Name char(20),
Gender char(1)
);

--inserting values in User Table
insert into User1 values(301,'Ravi','M');
insert into User1 values(302,'Kavi','F');
insert into User1 values(303,'Abhi','M');
insert into User1 values(304,'Savita','F');
insert into User1 values(305,'Gopal','M');
insert into User1 values(306,'Bhopal','M');
insert into User1 values(307,'Dolly','F');
insert into User1 values(308,'Tanu','F');
insert into User1 values(309,'Prince','M');
insert into User1 values(310,'Raj Kishore','M');

select * from User1;

--creating Bookings Table
create table Bookings
(BookingID int primary key,
CabID int,
UserID int,
Fare int,
Distance float,
PickupTime datetime,
DropTime Datetime,
Rating int
);

alter table Bookings
add constraint fk_cabId
foreign key(CabID)
references Cab(CabID);

alter table Bookings
add constraint fk_userId
foreign key(UserID)
references User1(UserID);

--inserting values in Bookings table
insert into Bookings values(401,204,309,101,13.0,'2015-04-07 19:00:00','2015-04-07 19:30:00',5); 
insert into Bookings values(402,205,301,105,15.2,'2015-05-11 9:15:00','2015-05-11 10:00:00',3); 
insert into Bookings values(403,204,309,2000,190,'2015-03-19 20:45:00','2015-03-20 1:00:00',2); 
insert into Bookings values(404,201,302,1995,150,'2015-07-07 11:00:00','2015-07-07 15:00:00',5); 
insert into Bookings values(405,204,303,553,50,'2014-09-12 19:00:00','2014-09-12 22:15:00',2); 
insert into Bookings values(406,202,302,465,45,'2015-01-07 9:00:00','2015-01-07 9:40:00',1); 
insert into Bookings values(407,205,304,258,20,'2015-07-02 3:00:00','2015-07-02 3:15:00',4); 
insert into Bookings values(408,202,309,125,15,'2015-06-23 9:00:00','2015-06-23 10:00:00',5); 
insert into Bookings values(409,204,310,1462,30,'2015-02-05 6:00:00','2015-02-05 8:00:00',4); 
insert into Bookings values(410,207,306,1876,60,'2015-01-29 15:00:00','2015-01-29 18:00:00',1); 

insert into Bookings values(411,203,308,1145,100,'2015-06-04 20:00:00','2015-06-05 6:00:00',0); 
insert into Bookings values(412,206,309,1358,90,'2015-01-19 2:00:00','2015-01-19 8:00:00',1); 
insert into Bookings values(413,208,301,102,5,'2015-03-21 11:00:00','2015-03-21 11:15:00',5); 

insert into Bookings values(414,206,309,503,50,'2015-02-28 8:00:00','2015-02-28 10:00:00',4); 
insert into Bookings values(415,204,304,786,62,'2015-03-09 16:00:00','2015-03-09 19:00:00',3); 
insert into Bookings values(416,208,306,143,3,'2015-04-09 11:30:00','2015-04-09 11:45:00',2); 
insert into Bookings values(417,203,309,658,12,'2015-05-04 01:00:00','2015-05-04 01:45:00',0); 
insert into Bookings values(418,206,308,852,17,'2015-02-18 15:00:00','2015-02-18 16:00:00',1); 
insert into Bookings values(419,208,301,450,22,'2015-03-11 18:00:00','2015-03-12 10:00:00',4); 
insert into Bookings values(420,204,309,420,29,'2015-02-17 11:00:00','2015-02-17 21:00:00',1); 

select * from Bookings

--Question -1
select Name,BrandName,Number,TravelTime
from 
(select BrandName,Number,Cab.CabID,UserID ,DATEDIFF(MI,PickupTime,DropTime)as TravelTime
from Bookings join Cab
on Bookings.CabID=Cab.CabID
where Fare between 500 and 1000)as sub1 join User1
on User1.UserID=sub1.UserID


--Question-2
select BrandName ,Number from Cab join
(select top 1 Count(Bookings.CabID)as ranking ,Bookings.CabID
from Bookings
group by CabID
order by ranking desc)as s1
on Cab.CabID=s1.CabID

--Question-3
select Name from User1
where UserID in(
select UserID from  
(SELECT UserID,Rank() over(order by COUNT(UserID) desc) AS TimesUsed 
 FROM Bookings GROUP BY UserID )as sub 
 where TimesUsed<4);


--Question -4
select Name,VName,numberOfTimes from  Vendor join
		(select Name,VendorID,numberOfTimes,UserID from Cab join
				(select Name,numberOfTimes,CabID ,sub1.UserID from User1 join
						(select UserID , CabID ,COUNT(CabID) as numberOfTimes
						from Bookings 
						group by UserID, CabID)as sub1
				on User1.UserID=sub1.UserID)sub2
		on Cab.CabID=sub2.CabID)as sub3 on Vendor.VendorID=sub3.VendorID

--Question 5
select BrandName,Number,[Number of Males],[Number of Females] from Cab join
(select CabID,
sum(case when Gender='M'
		 then 1
		 else 0
		 end)as [Number of Males],
sum(case when Gender='F'
		 then 1
		 else 0
		 end)as [Number of Females]		 
from Bookings join User1
on Bookings.UserID=User1.UserID
group by CabID)as sub1
on sub1.CabID=Cab.CabID


--Question 6

select VendorId ,sum(avgrating)/count(sub1.CabID)as totalRating 
from Cab join
	(select CabID ,AVG(Rating) as avgrating
	from Bookings
	group by CabID)as sub1
on Cab.CabID=sub1.CabID
group by VendorId

--Question -7
select Vendor.VName ,BrandName  ,totalTravelledDistance, averageSpeed from Vendor join
(select BrandName ,VendorId ,totalTravelledDistance, averageSpeed from Cab join
	(select CabID ,sum(Distance)as totalTravelledDistance,sum(distance)/sum(DATEDIFF(HH,PickupTime,DropTime))as averageSpeed
	from Bookings
	group by CabID)as sub1
on sub1.CabID=Cab.CabID)as sub2 
on sub2.VendorID=Vendor.VendorID

--Question -8
select VendorID ,count(sub1.CabID)as NuberOfBookedCabs from Cab join
(select CabID ,CONVERT(date , pickupTime) as bookDate
from Bookings
where CONVERT(date , pickupTime)= '2015-05-04')as sub1
on sub1.CabID=Cab.CabID
group by VendorID

--Question-9
select top 1 CabID ,(SUM(Fare)/SUM(Distance)) as AverageFare 
from  Bookings
group by CabID
order by AverageFare


