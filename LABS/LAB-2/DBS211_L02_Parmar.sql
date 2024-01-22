-- ***********************
-- Name: Neron Nelson Parmar
-- ID: 171690217
-- Date: 25/9/2022
-- Purpose: Lab 02 DBS211
-- ***********************

--------------------------------------------------------------------------------------------------------------------------------

-- Q1 SOLUTION --
1.)	Display the data for all offices. Display office code, city, state, country, and phone for all offices

SELECT officecode, city, state, country, phone 
FROM
   offices;

---------------------------------------------------------------------------------------------------------------------------------   

-- Q2 SOLUTION --
2.)	Display employee number, first name, last name, and extension for all employees whose office code is 1. Sort the result based
on the employee number.

SELECT employeenumber, firstname, lastname, extension  
FROM dbs211_employees
ORDER by officecode ASC

----------------------------------------------------------------------------------------------------------------------------------


2 (a).)	Display customer number, customer name, contact first name and contact last name, and phone for all customers in Paris. 
(hint: be wary of case sensitivity) Sort the result based on the customer number.

SELECT customernumber, customername, contactfirstname, contactlastname, phone 
FROM
   dbs211_customers 
WHERE
   city = 'Paris' ;

-----------------------------------------------------------------------------------------------------------------------------------

-- Q3 SOLUTION --
3.) Repeat the previous Query with a couple small changes:
    a.)	The contact’s first and last name should be in a single column in the format “lastname, firstname”.
    b.)	Show customers who are in Canada
    c.)	Sort the result based on the customer name.

SELECT customernumber, customername, contactlastname || ' ' || contactfirstname AS "contact name", phone 
FROM
   dbs211_customers
WHERE
   country = 'Canada' 
ORDER BY
   customername;

------------------------------------------------------------------------------------------------------------------------------------

-- Q4 SOLUTION -- 
4.)		Display customer number for customers who have payments.  Do not included any repeated 
values. Sort the result based on the customer number. (Hints: How do you know a customer has made a payment? You will need to access
only one table for this query) . The first 10 rows of the output result. The query returns 98 rows.


SELECT DISTINCT customerNumber 
FROM 
    dbs211_payments
ORDER BY
    customerNumber;

--------------------------------------------------------------------------------------------------------------------------------------

-- Q5 SOLUTION --
5.)	List customer numbers, check number, and amount for customers whose payment amount is not in the range of $1,500 to $120,000.
Sort the output by top payments amount first.

SELECT customernumber, checknumber, amount 
FROM
   dbs211_payments 
WHERE
   amount NOT BETWEEN 1500 AND 120000 
ORDER BY
   amount DESC;

---------------------------------------------------------------------------------------------------------------------------------------

-- Q6 SOLUTION --
6.) Display order number, order date, status, and customer number for all orders that are cancelled. Sort the result according to 
order date.

SELECT ordernumber, orderdate, status, customernumber 
FROM
   dbs211_orders 
WHERE
   status = 'Cancelled' 
ORDER BY
   orderdate;

--------------------------------------------------------------------------------------------------------------------------------------

-- Q7 SOLUTION --
7.) The company needs to know the percentage markup for each product sold.  Produce a query that outputs the ProductCode, ProductName,
BuyPrice, MSRP in addition to
    a.)	The difference between MSRP and BuyPrice (i.e. MSRP-BuyPrice) called markup
    b.)	The percentage markup (100 * calculated by difference / BuyPrice) called percmarkup
    rounded to 1 decimal place.
    c.)	Sort the result according to percmarkup.
    d.)	Show products with percmarkup greater than 140.	

SELECT productcode, productname, buyprice, msrp, msrp - buyprice AS markup, round(100 *((msrp - buyprice) / buyprice), 1) AS percmarkup 
FROM
  dbs211_products
WHERE
   round(100 *((msrp - buyprice) / buyprice), 1) > 140 
ORDER BY
   round(100 *((msrp - buyprice) / buyprice), 1) ;

--------------------------------------------------------------------------------------------------------------------------------------

-- Q8 SOLUTION --
8.)	Display product code, product name, and quantity in stock the information of all products with string ‘co’ in their product name.
(c and o can be lower or upper case). Sort the result according to quantity in stock.

SELECT productcode, productname, quantityinstock 
FROM
   dbs211_products
WHERE
   LOWER(productname) LIKE '%co%' 
ORDER BY
   quantityinstock;
   
---------------------------------------------------------------------------------------------------------------------------------------   

-- Q9 SOLUTION --
9.)	Display customer number, contact first name, contact last name for all customers whose contact first name starts with letters 
(both lowercase and uppercase) and includes letter e (both lowercase and uppercase). Sort the result according to customer number.
SELECT customernumber, contactfirstname, contactlastname 
FROM
dbs211_customers
WHERE
   LOWER(contactfirstname) LIKE 's%' 
   AND LOWER(contactfirstname) LIKE '%e%' 
ORDER BY
   customernumber;
