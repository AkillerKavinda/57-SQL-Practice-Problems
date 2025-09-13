/*
16. Show a list of countries where the Northwind
company has customers.
*/

select * from customers;

select distinct country
from customers;

/*
17. Show a list of all the different values in the
Customers table for ContactTitles. Also include a
count for each ContactTitle.
This is similar in concept to the previous question
“Countries where there are customers”
, except we
now want a count for each ContactTitle
*/

select * from customers;

select ContactTitle, count(*) as TotalContactTitle
from customers 
group by ContactTitle;


/*
18. We’d like to show, for each product, the associated
Supplier. Show the ProductID, ProductName, and
the CompanyName of the Supplier. Sort by
ProductID.
This question will introduce what may be a new
concept, the Join clause in SQL. The Join clause is
used to join two or more relational database tables
together in a logical way.
*/

select * from products;
select * from suppliers;

select p.productId, p.ProductName, s.CompanyName
from products p 
left join suppliers s
on p.SupplierID = s.SupplierID;


/*
19. We’d like to show a list of the Orders that were
made, including the Shipper that was used. Show
the OrderID, OrderDate (date only), and
CompanyName of the Shipper, and sort by
OrderID.
*/

select * from orders;
select * from shippers;

select o.OrderId, cast(OrderDate as date) as OrderDate, s.CompanyName
from orders o
join shippers s
on o.ShipVia = s.ShipperID

where o.OrderID < 10300;
