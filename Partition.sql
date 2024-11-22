CREATE TABLE EmployeeReports
(
ReportID int IDENTITY (1,1) NOT NULL,
ReportName varchar (100),
ReportNumber varchar (20),
ReportDescription varchar (max)
CONSTRAINT EReport_PK PRIMARY KEY CLUSTERED (ReportID)
)
 
DECLARE @i int
SET @i = 1
 
BEGIN TRAN
WHILE @i<100000 
BEGIN
INSERT INTO EmployeeReports
(
ReportName,
ReportNumber,
ReportDescription
)
VALUES
(
'ReportName',
CONVERT (varchar (20), @i),
REPLICATE ('Report', 1000)
)
SET @i=@i+1
END
COMMIT TRAN
GO

Select * from EmployeeReports;

SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT er.ReportID, er.ReportName, er.ReportNumber
FROM dbo.EmployeeReports er
WHERE er.ReportNumber LIKE '%33%'
SET STATISTICS IO OFF
SET STATISTICS TIME OFF


--Vertual Partition--

CREATE TABLE ReportsDesc 
( ReportID int FOREIGN KEY REFERENCES EmployeeReports (ReportID),
  ReportDescription varchar(max)
  CONSTRAINT PK_ReportDesc PRIMARY KEY CLUSTERED (ReportID)
 )
 
CREATE TABLE ReportsData
(
ReportID int NOT NULL,
ReportName varchar (100),
ReportNumber varchar (20),
 
CONSTRAINT DReport_PK PRIMARY KEY CLUSTERED (ReportID)
)
INSERT INTO dbo.ReportsData
(
    ReportID,
    ReportName,
    ReportNumber
)
SELECT er.ReportID, 
er.ReportName, 
er.ReportNumber 
FROM dbo.EmployeeReports er

SET STATISTICS IO ON
SET STATISTICS TIME ON
SELECT er.ReportID, er.ReportName, er.ReportNumber
FROM dbo.EmployeeReports er
WHERE er.ReportNumber LIKE '%33%'
SET STATISTICS IO OFF
SET STATISTICS TIME OFF


----Horizontal Partition--


ALTER DATABASE Employees
ADD FILEGROUP January
GO
ALTER DATABASE Employees
ADD FILEGROUP February
GO
ALTER DATABASE Employees
ADD FILEGROUP March
GO
ALTER DATABASE Employees
ADD FILEGROUP April
GO
ALTER DATABASE Employees
ADD FILEGROUP May
GO
ALTER DATABASE Employees
ADD FILEGROUP June
GO
ALTER DATABASE Employees
ADD FILEGROUP July
GO
ALTER DATABASE Employees
ADD FILEGROUP August
GO
ALTER DATABASE Employees
ADD FILEGROUP September
GO
ALTER DATABASE Employees
ADD FILEGROUP October
GO
ALTER DATABASE Employees
ADD FILEGROUP November
GO
ALTER DATABASE Employees
ADD FILEGROUP December
GO

SELECT name AS Filegroups
FROM sys.filegroups
WHERE type = 'FG'

Select physical_name
from sys.master_files
Where database_id=DB_ID('Employees')

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartJan,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Jan.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP January

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartFeb,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Feb.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP February

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartMar,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Mar.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP March

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartApr,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Apr.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP April

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartMay,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\May.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP May

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartJun,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Jun.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP June

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartJul,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Jul.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP July

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartAug,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Aug.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP August

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartSept,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Sept.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP September

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartOct,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Oct.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP October

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartNov,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Nov.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP November

ALTER DATABASE Employees
    ADD FILE 
    (
    NAME = PartDec,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Dec.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP December

SELECT 
name as FileName,
physical_name as FilePath
FROM sys.database_files
where type_desc = 'ROWS'
GO

CREATE PARTITION FUNCTION PartByMonth (datetime)
AS RANGE right FOR VALUES ('20141201');

DROP FUNCTION PartitioningByMonth;


CREATE PARTITION SCHEME PartBymonth
AS PARTITION PartBymonth
TO (January, February, March, 
    April, May, June, July, 
    August, September, October, 
    November, December);

CREATE TABLE Reports
(ReportDate datetime ,
MonthlyReport varchar(max))
ON PartBymonth (ReportDate);
GO


 
INSERT INTO Reports (ReportDate,MonthlyReport)
SELECT '20140105', 'ReportJanuary' UNION ALL
SELECT '20140205', 'ReportFebryary' UNION ALL
SELECT '20140308', 'ReportMarch' UNION ALL
SELECT '20140409', 'ReportApril' UNION ALL
SELECT '20140509', 'ReportMay' UNION ALL
SELECT '20140609', 'ReportJune' UNION ALL
SELECT '20140709', 'ReportJuly' UNION ALL
SELECT '20140809', 'ReportAugust' UNION ALL
SELECT '20140909', 'ReportSeptember' UNION ALL
SELECT '20141009', 'ReportOctober' UNION ALL
SELECT '20141109', 'ReportNovember' UNION ALL
SELECT '20141209', 'ReportDecember'

Drop table Reports;
SELECT 
p.partition_number AS PartitionNumber,
f.name AS PartitionFilegroup, 
p.rows AS NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Reports'