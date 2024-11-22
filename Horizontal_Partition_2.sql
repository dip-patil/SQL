

--Create Database DB_Partition;
CREATE TABLE Teachers (
    teacher_id INT IDENTITY(1,1) PRIMARY KEY,
    teacher_name NVARCHAR(100) NOT NULL,     
    subject NVARCHAR(100) NOT NULL,          
    joining_date DATE NOT NULL               
);


INSERT INTO Teachers (teacher_name, subject, joining_date) VALUES
('Anjali Sharma', 'Mathematics', '2024-01-10'),
('Rohan Kumar', 'Physics', '2024-02-15'),
('Neha Verma', 'Chemistry', '2024-03-20'),
('Rajesh Gupta', 'Biology', '2024-04-12'),
('Meera Iyer', 'History', '2024-05-25'),
('Arun Nair', 'Geography', '2024-06-30'),
('Sneha Joshi', 'English', '2024-07-08'),
('Vikram Chandra', 'Computer Science', '2024-08-22'),
('Priya Menon', 'Hindi', '2024-09-14'),
('Amit Singh', 'Economics', '2024-10-19'),
('Rita Das', 'Political Science', '2024-11-27'),
('Manish Rao', 'Environmental Science', '2024-12-05');


SELECT * FROM Teachers;

ALTER DATABASE DB_Partition
ADD FILEGROUP Month_1
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_2
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_3
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_4
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_5
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_6
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_7
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_8
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_9
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_10
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_11
GO
ALTER DATABASE DB_Partition
ADD FILEGROUP Month_12
GO

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_1,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_1.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_1

	ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_2,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_2.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_2

	ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_3,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_3.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_3

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_4,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_4.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_4

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_5,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_5.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_5

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_6,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_6.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_6

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_7,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_7.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_7

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_8,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_8.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_8

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_9,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_9.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_9

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_10,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_10.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_10

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_11,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_11.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_11

ALTER DATABASE DB_Partition
    ADD FILE 
    (
    NAME = M_12,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Month_12.ndf',
        SIZE = 3072 KB, 
        MAXSIZE = UNLIMITED, 
        FILEGROWTH = 1024 KB
    ) TO FILEGROUP Month_12

	SELECT 
p.partition_number AS PartitionNumber,
f.name AS PartitionFilegroup, 
p.rows AS NumberOfRows 
FROM sys.partitions p
JOIN sys.destination_data_spaces dds ON p.partition_number = dds.destination_id
JOIN sys.filegroups f ON dds.data_space_id = f.data_space_id
WHERE OBJECT_NAME(OBJECT_ID) = 'Teachers'