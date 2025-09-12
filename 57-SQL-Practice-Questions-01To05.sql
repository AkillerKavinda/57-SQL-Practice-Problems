-- 1. We have a table called Shippers. Return all the fields from all the shippers

select * from shippers;

/*
2. In the Categories table, selecting all the fields using this SQL:
Select * from Categories …will return 4 columns. We only want to see two columns, CategoryName and Description.
*/

select categoryName, description
from categories;

/*
3. We’d like to see just the FirstName, LastName, and
HireDate of all the employees with the Title of
Sales Representative. Write a SQL statement that
returns only those employees. */

select FirstName, LastName, HireDate 
from employees
where Title = 'Sales Representative';


/*
4. Now we’d like to see the same columns as above,
but only for those employees that both have the
title of Sales Representative, and also are in the
United States.
*/

select * from employees; 

select FirstName, LastName, HireDate
from employees 
where Title = 'Sales Representative' and country = 'USA';


/*
5.  EmployeeID for this Employee (Steven
Buchanan) is 5.
*/

select * from orders;

select * from orders 
where employeeId = 5;