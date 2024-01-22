-- ***********************
-- Name: Parmar Neron Nelson
-- ID: 171690217
-- Date: 10/10/22
-- Purpose: Lab 04 DBS211
-- ***********************1

SET AUTOCOMMIT ON;


--Q1 SOLUTION--
CREATE TABLE DBS211_EMPLOYEE2 AS SELECT * FROM dbs211_employees;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q2 SOLUTION--
ALTER TABLE DBS211_EMPLOYEE2
ADD username VARCHAR(45);

-----------------------------------------------------------------------------------------------------------------------------------------

--Q3 SOLUTION--
DELETE FROM dbs211_employee2;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q4 SOLUTION--
INSERT INTO dbs211_employee2 (EMPLOYEENUMBER, LASTNAME , FIRSTNAME , EXTENSION , EMAIL , OFFICECODE , REPORTSTO , JOBTITLE)
SELECT EMPLOYEENUMBER, LASTNAME , FIRSTNAME , EXTENSION , EMAIL , OFFICECODE , REPORTSTO , JOBTITLE  FROM dbs211_employees;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q5 SOLUTION--
SELECT MAX (EMPLOYEENUMBER)
FROM dbs211_employees;
INSERT INTO dbs211_employee2 VALUES (1703,'Parmar', 'Neron', 'x2222', 'nparmar22@myseneca.ca', 4, 1088, 'Cashier', null);

-----------------------------------------------------------------------------------------------------------------------------------------

--Q6 SOLUTION--
SELECT * FROM dbs211_employee2
WHERE EMPLOYEENUMBER = 1703;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q7 SOLUTION--
UPDATE dbs211_employee2
SET JOBTITLE = 'Head Cashier'
WHERE EMPLOYEENUMBER = 1703;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q8 SOLUTION--
INSERT INTO dbs211_employee2 VALUES (1730,'Jasuja', 'Aditya', 'x1234', 'jasuja@myseneca.ca', 4, 1703, 'Cashier', null);

-----------------------------------------------------------------------------------------------------------------------------------------

--Q9 SOLUTION--
DELETE dbs211_employee2
WHERE EMPLOYEENUMBER = 1703;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q10 SOLUTION--
DELETE dbs211_employee2
WHERE EMPLOYEENUMBER = 1730;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q11 SOLUTION--
INSERT ALL 
INTO dbs211_employee2 VALUES (1703,'Parmar', 'Neron', 'x2222', 'nparmar22@myseneca.ca', 4, 1088, 'Cashier', null)
INTO dbs211_employee2 VALUES (1730,'Jasuja', 'Aditya', 'x1234', 'jasuja@myseneca.ca', 4, 1703, 'Cashier', null)
SELECT * FROM dual;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q12 SOLUTION--
DELETE dbs211_employee2
WHERE EMPLOYEENUMBER = 1703 OR EMPLOYEENUMBER = 1730;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q13 SOLUTION--
UPDATE dbs211_employee2
SET username = LOWER(CONCAT(CONCAT(SUBSTR(firstname, 1, 1),lastname),'@myseneca.ca'));

-----------------------------------------------------------------------------------------------------------------------------------------

--Q14 SOLUTION--
DELETE dbs211_employee2
WHERE OFFICECODE = 4;

-----------------------------------------------------------------------------------------------------------------------------------------

--Q15 SOLUTION--
DROP TABLE DBS211_EMPLOYEE2

-----------------------------------------------------------------------------------------------------------------------------------------