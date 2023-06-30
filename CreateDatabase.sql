USE master

-- Check if the database exists
IF DB_ID('XMLMaskingDemoDatabase') IS NOT NULL
BEGIN
    -- Set the database to single-user mode to drop all connections
    ALTER DATABASE XMLMaskingDemoDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    -- Drop the database
    DROP DATABASE XMLMaskingDemoDatabase;
END
GO

-- Create the database
CREATE DATABASE XMLMaskingDemoDatabase;
GO

-- Use the database
USE XMLMaskingDemoDatabase;
GO

-- Create the EMPLOYEE table
CREATE TABLE EMPLOYEE (
    ID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Role NVARCHAR(50)
);
GO

-- Insert values into EMPLOYEE table
INSERT INTO EMPLOYEE (ID, FirstName, LastName, Role)
VALUES
    (1, 'Aaron', 'Aaronson', 'Accountant'),
    (2, 'Bill', 'Billson', 'Business Analyst'),
    (3, 'Christina', 'Christinason', 'CEO');
GO

-- Create the EXPENSES table
CREATE TABLE EXPENSES (
    ID INT PRIMARY KEY,
    EXPENSE XML
);
GO

-- Insert values into EXPENSES table
INSERT INTO EXPENSES (ID, EXPENSE)
VALUES
    (1, '<EXPENSE><EMPLOYEE_FIRSTNAME>Aaron</EMPLOYEE_FIRSTNAME><EMPLOYEE_LASTNAME>Aaronson</EMPLOYEE_LASTNAME><DESCRIPTION>Abacus</DESCRIPTION><PRICE>9.99</PRICE></EXPENSE>'),
    (2, '<EXPENSE><EMPLOYEE_FIRSTNAME>Zelda</EMPLOYEE_FIRSTNAME><EMPLOYEE_LASTNAME>Zeldason</EMPLOYEE_LASTNAME><DESCRIPTION>Zebra</DESCRIPTION><PRICE>5000.00</PRICE></EXPENSE>'),
    (3, '<EXPENSE><EMPLOYEE_FIRSTNAME>Christina</EMPLOYEE_FIRSTNAME><EMPLOYEE_LASTNAME>Christinason</EMPLOYEE_LASTNAME><DESCRIPTION>Czinger 21C</DESCRIPTION><PRICE>1700000.00</PRICE></EXPENSE>');
GO