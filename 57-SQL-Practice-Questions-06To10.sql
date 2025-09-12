/*
6. In the Suppliers table, show the SupplierID,
ContactName, and ContactTitle for those Suppliers
whose ContactTitle is not Marketing Manager.
*/

select * from suppliers;

select supplierID, ContactName, ContactTitle
from suppliers
where contactTitle != 'Marketing Manager';


/*
7. Products with “queso” in ProductName
*/

select * from products;

select * 
from products
where productName like '%queso%';

/*
8. Looking at the Orders table, there’s a field called
ShipCountry. Write a query that shows the
OrderID, CustomerID, and ShipCountry for the
orders where the ShipCountry is either France or
Belgium.
*/

select * from orders;

select OrderId, CustomerId, ShipCountry 
from orders
where ShipCountry = 'France' or ShipCountry = 'Belgium';

/*
9. Now, instead of just wanting to return all the orders
from France of Belgium, we want to show all the
orders from any Latin American country. But we
don’t have a list of Latin American countries in a
table in the Northwind database. So, we’re going to
just use this list of Latin American countries that
happen to be in the Orders table:
Brazil
Mexico
Argentina
Venezuela
It doesn’t make sense to use multiple Or statements
anymore, it would get too convoluted. Use the In
statement.
*/

select OrderId, CustomerId, ShipCountry 
from orders
where ShipCountry in ('Brazil', 'Mexico', 'Argentina', 'Venezuela');


/*
10. For all the employees in the Employees table, show
the FirstName, LastName, Title, and BirthDate.
Order the results by BirthDate, so we have the
oldest employees first.
*/

select * from employees;

select FirstName, LastName, Title, BirthDate
from employees
order by BirthDate;