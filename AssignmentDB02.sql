CREATE DATABASE Assignment1;

--Table1

CREATE TABLE TProductMaster
(
ProductId VARCHAR(10) PRIMARY KEY,
ProductName VARCHAR(20),
CostPerItem INT
);

INSERT INTO TProductMaster
VALUES('P1','Pen',10);
INSERT INTO TProductMaster
VALUES('P2','Scale',15);
INSERT INTO TProductMaster
VALUES('P3','NoteBook',25);

SELECT * FROM TProductMaster;

--Table2

CREATE TABLE TUserMaster
(
UserId VARCHAR(10) PRIMARY KEY,
UserName VARCHAR(20),
);

INSERT INTO TUserMaster
VALUES('U1','Alfred Lawrence');
INSERT INTO TUserMaster
VALUES('U2','William Paul');
INSERT INTO TUserMaster
VALUES('U3','Edward Fillip');

SELECT * FROM TUserMaster;

--Table3

CREATE TABLE TTransaction
(
UserId VARCHAR(10) FOREIGN KEY REFERENCES TUserMaster(UserId),
ProductId VARCHAR(10) FOREIGN KEY REFERENCES TProductMaster(ProductId),
TransactionDate DATE,
TransactionType VARCHAR(20),
TransactionAmount INT
);

INSERT INTO TTransaction
VALUES('U1','P1','2010-10-25','Order',150);
INSERT INTO TTransaction
VALUES('U1','P1','2010-11-20','Payment',750);
INSERT INTO TTransaction
VALUES('U1','P1','2010-11-20','Order',200);
INSERT INTO TTransaction
VALUES('U1','P3','2010-11-25','Order',50);
INSERT INTO TTransaction
VALUES('U3','P2','2010-11-26','Order',100);
INSERT INTO TTransaction
VALUES('U2','P1','2010-12-15','Order',75);
INSERT INTO TTransaction
VALUES('U3','P2','2011-01-15','Payment',250);


SELECT UserId, ProductId,CONVERT(VARCHAR(20), TransactionDate, 105),
TransactionType, TransactionAmount
FROM TTransaction;

--Assignment Query

SELECT MAX(TUserMaster.UserName) AS UserName,
MAX(TProductMaster.ProductName)AS ProductName,
SUM(
CASE 
WHEN TransactionType='Order'
THEN TransactionAmount
END) AS OrderedQuantity,

SUM(
CASE 
WHEN TransactionType='Payment'
THEN TransactionAmount
ELSE 0
END) AS AmountPaid,

CONVERT(VARCHAR(20),MAX(TransactionDate), 105) AS LastTransactionDate,

SUM(CASE WHEN TransactionType='Order' THEN TransactionAmount*TProductMaster.CostPerItem
	ELSE -TransactionAmount
	END) AS Balance
FROM TTransaction
JOIN TProductMaster
ON TProductMaster.ProductId=TTransaction.ProductId
JOIN TUserMaster
ON TUserMaster.UserId=TTransaction.UserId
GROUP BY TTransaction.UserId,TTransaction.ProductId