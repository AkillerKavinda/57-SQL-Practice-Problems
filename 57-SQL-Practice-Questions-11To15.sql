/*
11. In the output of the query above, showing the
Employees in order of BirthDate, we see the time
of the BirthDate field, which we don’t want. Show
only the date portion of the BirthDate field.
*/

select * from employees;

select FirstName, LastName, Title, cast(BirthDate as date) as BirthDate
from employees;

/*
12. Show the FirstName and LastName columns from
the Employees table, and then create a new column
called FullName, showing FirstName and
LastName joined together in one column, with a
space in-between.
*/

select* from employees;

select FirstName, LastName, concat(firstName, ' ' , LastName) as FullName
from employees;

/*
13. In the OrderDetails table, we have the fields
UnitPrice and Quantity. Create a new field,
TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID,
UnitPrice, and Quantity. Order by OrderID and
ProductID.
*/

select * from [Order Details];


select *, UnitPrice * Quantity as TotalPrice
from [Order Details];

/*
14. How many customers do we have in the Customers
table? Show one value only, and don’t rely on
getting the recordcount at the end of a resultset.
*/

select * from customers;

select count(distinct customerId) as TotalCustomers
from customers;


/*
15. Show the date of the first order ever made in the
Orders table.
*/

select * from orders;

select min(orderDate)
from orders;

