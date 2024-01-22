-- ***********************
-- Name: Parmar Neron Nelson
-- ID: 171690217
-- Date: 16/10/22
-- Purpose: Lab 06 DBS211
-- ***********************1

SET TRANSACTION READ WRITE;
SET AUTOCOMMIT OFF;


---------------------------------------------------------------------------------------------------------------------------------------------------------
--//PART A - Transactions
---------------------------------------------------------------------------------------------------------------------------------------------------------


--//1.)	List the 4 ways that we know that a transaction can be started
--// --> 1.) If the user has started a new connection to the server and has a blank sheet ready to go, starts a new transaction.
--// --> 2.) If the user types the BEGIN statement in Oracle SQL, which will start a new transaction.
--// --> 3.) If the user runs a COMMIT statement and the current transaction is commited, and a new transaction is started.
--// --> 4.) If the user runs ANY DDL statement. Which automatically triggers an auto-commit of the current transaction and starts a new transaction.


--/2.) Using SQL, create an empty table, that is the same as the employees table, and name it newEmployees.
CREATE TABLE newEmployees AS 
(SELECT * FROM dbs211_employees WHERE 1=2);


--//3.)	Execute the following commands.
--//    SET AUTCOMMIT OFF;
--//	SET TRANSACTION READ WRITE;  ---->> Already executed in the first and second line at the starting.


--//4.)	Write an INSERT statement to populate the newEmployees table with the rows of the sample data.
--//Insert the NULL value for the reportsTo column. (Write a single INSERT statement to insert all the rows)
INSERT ALL
INTO newemployees VALUES (0001, 'Parmar', 'Neron', 'x1234', 'nparmar@mail.com',1, Null, 'Manager')
INTO newemployees VALUES (0002, 'Rathod', 'Shruti', 'x4567', 'srathod@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0003, 'Amit', 'Anand', 'x7890', 'aanand@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0004, 'Jasuja', 'Aditya', 'x1112', 'ajasuja@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0005, 'Patel', 'Aayushi', 'x1314', 'apatel@mail.com',1, 0001, 'Crew' )
SELECT * FROM dual;


--//5.)	Create a query that shows all the inserted rows from the newEmployees table. How many rows are selected?
SELECT * FROM newemployees;


--//6.)	Execute the rollback command. Display all rows and columns from the newEmployees table. How many rows are selected?
COMMIT;
SELECT * FROM newemployees;
ROLLBACK;
SELECT * FROM newemployees;


--//7.)	Repeat Task 4. Make the insertion permanent to the table newEmployees. Display all rows and columns from the 
--// newEmployee table. How many rows are selected?
COMMIT;
SELECT * FROM newemployees;
SAVEPOINT A;


--//8.)	Write an update statement to update the value of column jobTitle to ‘unknown’ for all the employees in the newEmployees table.
UPDATE newemployees
SET jobtitle = 'unknown';


--//9.)	Make your changes permanent.
COMMIT;
SELECT * FROM newemployees;
SAVEPOINT B;


--//10.)	Execute the rollback command
--//a.)	Display all employees from the newEmployees table whose job title is ‘unknown’. How many rows are still updated?
COMMIT;
SELECT * FROM newemployees WHERE jobtitle = 'unknown';
ROLLBACK;

--//b.)	Was the rollback command effective?
--//It was not effective as i previously made the data permanent.

--//c.)	What was the difference between the result of the rollback execution from Task 6 and the result of the rollback execution of this task?
--//There is no difference. It can be if I used an insert statement before the rollback, it would then not show the inserted statement if I would not save it


--//11.) Begin a new transaction and then create a statement to delete to employees from the newEmployees table.
BEGIN
DELETE FROM newemployees;
COMMIT;
END;


--//12.	Create a VIEW, called vwNewEmps, that queries all the records in the newEmployees table sorted by last name and then by first name.
CREATE VIEW vwNEWEMPS AS
SELECT * FROM newemployees
ORDER BY lastname, firstname;


--13. Perform a rollback to undo the deletion of the employees

	COMMIT;
	DELETE FROM newEmployees;
	ROLLBACK;

--a.) How many employees are now in the newEmployees table?
-- 0 employees.

--b.) Was the rollback effective and why?
-- No, the rollback was complete but due the use of commit statement, it was not effective. 
	

--//14.) Begin a new transaction and rerun the data insertion from Task 4 (copy the code down to Task 14 and run it).
BEGIN
INSERT ALL
INTO newemployees VALUES (0001, 'Parmar', 'Neron', 'x1234', 'nparmar@mail.com',1, Null, 'Manager')
INTO newemployees VALUES (0002, 'Rathod', 'Shruti', 'x4567', 'srathod@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0003, 'Amit', 'Anand', 'x7890', 'aanand@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0004, 'Jasuja', 'Aditya', 'x1112', 'ajasuja@mail.com',1, 0001, 'Crew')
INTO newemployees VALUES (0005, 'Patel', 'Aayushi', 'x1314', 'apatel@mail.com',1, 0001, 'Crew' )
SELECT * FROM dual;
COMMIT;
END;


--//15.) Set a Savepoint, called insertion, after inserting the data
SELECT * FROM newemployees;
SAVEPOINT insertion;


--//16.)	Rerun the update statement from Task 8 and run a query to view the data (copy the code down and run it again)
UPDATE newemployees
SET jobtitle = 'unknown';
SELECT * FROM newemployees;


--//17.)	Rollback the transaction to the Savepoint created in task 15 above and run a query to view the data.
--//What does the data look like (i.e. describe what happened?
ROLLBACK TO insertion;
--// It jumps back to step 15, where the jobtitle was Sales Rep.


--//18.)	Use the basic for of the rollback statement and again view the data.  Describe what the results look like and what happened.
ROLLBACK;


---------------------------------------------------------------------------------------------------------------------------------------------------------
--//Part B - Permissions
---------------------------------------------------------------------------------------------------------------------------------------------------------


--//19.)	Write a statement that denies all access to the newemployees table for all public users.
REVOKE SELECT, UPDATE, INSERT, DELETE ON newemployees FROM public;


--//20.)	Write a statement that allows a classmate (use their database login) read only access to the newemployees table.
GRANT SELECT ON newemployees TO dbs211_223zdd28;


--//21.)	Write a statement that allows the same classmate to modify (insert, update and delete) the data of the newemployees table.
GRANT INSERT, UPDATE, DELETE ON newemployees TO dbs211_223zdd28;


--//22.)	Write a statement that denies all access to the newemployees table for the same classmate.
REVOKE INSERT, UPDATE, DELETE ON newemployees FROM dbs211_223zdd28;


---------------------------------------------------------------------------------------------------------------------------------------------------------
--//Part C – Clean up
---------------------------------------------------------------------------------------------------------------------------------------------------------


--//23.)	Write statements to permanently remove the view and table created for this lab
DROP VIEW NEWEMPS;
DROP TABLE newEmployees;