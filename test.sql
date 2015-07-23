CREATE DATABASE Test;

USE Test;

GO
--Create table TUser

CREATE TABLE TUser
(UserID INT PRIMARY KEY IDENTITY(101,1),
Name VARCHAR(25),
Country VARCHAR(25),
Gender VARCHAR(2));

INSERT INTO TUser VALUES('Harsh','India','M');

INSERT INTO TUser VALUES('Richa','Sri Lanka','F');

INSERT INTO TUser VALUES('Richard','US','M');

INSERT INTO TUser VALUES('Gopal','India','M');

INSERT INTO TUser VALUES('Jennifer','US','F');

INSERT INTO TUser VALUES('Karishma','India','F');

INSERT INTO TUser VALUES('Clinton','US','M');

INSERT INTO TUser VALUES('Sadhna','India','F');

SELECT * FROM TUser;

--Create table TPost

CREATE TABLE TPost(
PostID INT PRIMARY KEY IDENTITY(201,1),
UserID INT CONSTRAINT FKUser FOREIGN KEY REFERENCES TUser(UserID),
Post VARCHAR(30));

INSERT INTO TPost VALUES(104,'My name is Gopal');

INSERT INTO TPost VALUES(101,'Hello Friends');

INSERT INTO TPost VALUES(105,'Bon Voyage');

INSERT INTO TPost VALUES(104,'Cherishing life');

INSERT INTO TPost VALUES(108,'Switching lanes');

INSERT INTO TPost VALUES(105,'Feeling Nostalgic');

INSERT INTO TPost VALUES(102,'Sangakkara Rocks');

INSERT INTO TPost VALUES(104,'Bleeding Blue');

--Create table FriendRequest

CREATE TABLE FriendRequest(
RequestID INT PRIMARY KEY IDENTITY(301,1),
SenderID INT CONSTRAINT FKSend FOREIGN KEY REFERENCES TUser(UserID),
ReceiverID INT CONSTRAINT FKReceive FOREIGN KEY REFERENCES TUser(UserID),
Status VARCHAR(25));

INSERT INTO FriendRequest VALUES(101,102,'Approved');

INSERT INTO FriendRequest VALUES(107,105,'Rejected');

INSERT INTO FriendRequest VALUES(101,106,'Approved');

INSERT INTO FriendRequest VALUES(108,101,'Approved');

INSERT INTO FriendRequest VALUES(106,103,'Approved');

INSERT INTO FriendRequest VALUES(104,108,'Pending');

INSERT INTO FriendRequest VALUES(104,101,'Approved');

INSERT INTO FriendRequest VALUES(105,102,'Pending');

INSERT INTO FriendRequest VALUES(107,103,'Approved');

INSERT INTO FriendRequest VALUES(106,102,'Rejected');

--Create table PostLike	

CREATE TABLE PostLike(
LikeID INT PRIMARY KEY IDENTITY(401,1),
PostID INT CONSTRAINT FKPost FOREIGN KEY REFERENCES TPost(PostID),
UserID INT CONSTRAINT FKUserPost FOREIGN KEY REFERENCES TUser(UserID)
);

INSERT INTO PostLike VALUES(203,102);

INSERT INTO PostLike VALUES(208,108);

INSERT INTO PostLike VALUES(204,106);

INSERT INTO PostLike VALUES(203,108);

INSERT INTO PostLike VALUES(207,102);

INSERT INTO PostLike VALUES(202,102);

INSERT INTO PostLike VALUES(203,106);

INSERT INTO PostLike VALUES(205,102);

INSERT INTO PostLike VALUES(204,107);

INSERT INTO PostLike VALUES(203,101);

SELECT * FROM PostLike;

--Question-1
--select TOP 2 Country from 
--(
--select Country,  from TUser
--      join ( 
--			select UserID, count(PostID)as no_of_post
--			from TPost 
--			group by UserID
			
--			) as s1
--	on s1.UserID = TUser.UserID 
--	group by Country
--)as sub

--Question 1

	SELECT  COUNTRY,MAX(NumOfPosts)as counting FROM
	(SELECT UserID,COUNT(UserID)AS NumOfPosts 
	FROM TPost GROUP BY UserID) AS Temp1 JOIN TUser ON Temp1.UserID=TUser.UserID
	GROUP BY Country 
	order by counting desc
	
--Question -2

	with CTE_User(c1,c2)
	as
	(SELECT UserID,COUNT(UserID)AS NumOfPosts 
	FROM TPost GROUP BY UserID)
	
select country ,UserID ,max(c2) from  CTE_User,TUser join
(SELECT  c1 ,max(c2)as abc  
FROM CTE_User
group by c1,c2
having c2=MAX(c2)
	)as s1 on TUser.UserID=s1.c1
	order by 
	
	(SELECT UserID,COUNT(UserID)AS NumOfPosts 
	FROM TPost GROUP BY UserID)as s1 	
	GROUP BY Country 
	order by counting desc

SELECT  COUNTRY,MAX(NumOfPosts)as counting  FROM  TUser 


--Question -3
select PostID from  
(SELECT PostID,Rank() over(order by COUNT(PostID) desc) AS NumOfLikes 
 FROM PostLike GROUP BY PostID )as sub 
 where NumOfLikes=3;


--Question 4

SELECT TOP 1 MaxLikes,Temp.UserID,Name FROM
(SELECT UserID,COUNT(UserID) AS MaxLikes
 FROM PostLike GROUP BY UserID )AS Temp 
JOIN TUser ON TUser.UserID=Temp.UserID
 Order by MaxLikes Desc;

--Question -5
--select UserID 
--from TUser
--where UserID in (select SenderID 
--					from FriendRequest
--					where Status='Rejected' or Status='pending'and SenderID not in (select SenderID 
--																				from FriendRequest
--																				where Status ='Approved'  ) )

select SenderID 
		from FriendRequest
			where
			 SenderID  not in (select SenderID from FriendRequest
								where Status ='Approved'  )
	
--Question-6
select UserID ,COUNT(UserID)as maxLikes
from PostLike
group by UserID
where 


--Question 7
select Country,sum(NumOfPosts)from TUser join 
(SELECT UserID,COUNT(UserID)AS NumOfPosts 
	FROM TPost GROUP BY UserID)as s1
	on s1.UserID=TUser.UserID
	group by Country
	
--Question-8
select Country,Gender, sum(NumOfPosts)from TUser join 
(SELECT UserID,COUNT(UserID)AS NumOfPosts 
	FROM TPost GROUP BY UserID)as s1
	on s1.UserID=TUser.UserID
	group by Country,Gender
--Question -9
select SenderID,ReceiverID
from FriendRequest
where Status='Approved' 	
group by SenderID,ReceiverID	

union 

select ReceiverID, SenderID
from FriendRequest
where Status='Approved' 	
group by ReceiverID,SenderID	

--Question 10

(select ReceiverID
from FriendRequest
where SenderID =106	and Status='Approved' 
union
select SenderID
from FriendRequest
where  ReceiverID=106	and Status='Approved' )
intersect
(select ReceiverID
from FriendRequest
where SenderID =103	and Status='Approved' 
union 
select SenderID
from FriendRequest
where ReceiverID=103	and Status='Approved' 	)											