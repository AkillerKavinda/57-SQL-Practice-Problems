/*
20. For this problem, we’d like to see the total number
of products in each category. Sort the results by the
total number of products, in descending order.
*/

select * from products;
select * from categories;

select c.CategoryName, count(*) as TotalProducts
from 
categories c
left join products p
on c.CategoryID = p.CategoryID
group by c.CategoryName
order by TotalProducts desc;


/*
21. In the Customers table, show the total number of
customers per Country and City.
*/

select * from customers;

select country, city, count(*)
from customers 
group by country, city;

/*
22. What products do we have in our inventory that
should be reordered? For now, just use the fields
UnitsInStock and ReorderLevel, where
UnitsInStock is less than the ReorderLevel,
ignoring the fields UnitsOnOrder and
Discontinued.
Order the results by ProductID.
*/

select * from products;

select * from products 
where unitsinstock < reorderlevel 
order by productId;

/*
23. Now we need to incorporate these fields—
UnitsInStock, UnitsOnOrder, ReorderLevel,
Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less
than or equal to ReorderLevel
The Discontinued flag is false (0).
*/

select * 
from products 
where UnitsInStock + UnitsOnOrder <= ReorderLevel 
and Discontinued = 0;

/*
24. A salesperson for Northwind is going on a business
trip to visit customers, and would like to see a list
of all customers, sorted by region, alphabetically.
However, he wants the customers with no region
(null in the Region field) to be at the end, instead of
at the top, where you’d normally find the null
values. Within the same region, companies should
be sorted by CustomerID.
*/

select * from customers;

select CustomerID, CompanyName, Region
from customers 
order by 
	case
		when region is null then 1
		else 0
	end, 
	region,
	customerId;

/*
25. Some of the countries we ship to have very high
freight charges. We'd like to investigate some more
shipping options for our customers, to be able to
offer them lower freight charges. Return the three
ship countries with the highest average freight
overall, in descending order by average freight.
*/

select * from orders;

select top 3 
shipcountry, avg(freight) AverageFreight
from orders 
group by shipcountry
order by AverageFreight desc;

/*
26. We're continuing on the question above on high
freight charges. Now, instead of using all the orders
we have, we only want to see orders from the year
1997.
*/

select * from orders;

select top 3 shipcountry, avg(freight)
from orders
where year(orderDate) = 1997
group by shipcountry
order by avg(freight) desc;

EXEC sp_help 'Orders'; -- To check the datatypes of columns

/*
27. An incorrect answer to the above question
*/

Select Top 3
 ShipCountry
 ,avg(freight) as AverageFreight
From Orders
Where
 OrderDate between '1/1/1997' and '12/31/1997'  -- Between doesn't include the orders after 00.00:00 the final day. 
												--  Ex : 00.01 to 23.59 on 12/31/1997 will not be included
Group By ShipCountry
Order By AverageFreight desc;

/*
28. We're continuing to work on high freight charges.
We now want to get the three ship countries with
the highest average freight charges. But instead of
filtering for a particular year, we want to use the
last 12 months of order data, using as the end date
the last OrderDate in Orders.
*/

select distinct year(orderdate)
from orders;

select distinct month(orderdate)
from orders;

select top 3 
shipcountry, avg(freight)
from orders
where orderdate >= dateadd(month, -12, (select max (orderDate) from orders))
group by shipcountry
order by avg(freight) desc;

/*
29. We're doing inventory, and need to show
information like the below, for all orders. Sort by
OrderID and Product ID.
*/

select * from employees; -- EmployeeID, LastName
select * from [Order Details]; -- OrderID, quantity
select * from products; -- ProductName
select * from orders;

select e.employeeID, e.LastName, o.OrderID, p.productName, od.Quantity
from Employees e
left join orders o
on e.employeeId = o.employeeId
left join [Order Details] od
on o.orderId = od.orderID
left join products p 
on od.ProductID = p.ProductID
order by o.orderId, p.productId;

/*
30. There are some customers who have never actually
placed an order. Show these customers.
*/

select * from customers;

select * from orders;

-- Method 1 
select * from customers 
where CustomerID not in (select distinct CustomerID from orders);

-- Method 2 
select c.CustomerID, count(o.OrderID) as Orders
from customers c
left join orders o
on c.CustomerID = o.CustomerID
group by c.customerID
having count(o.orderid) = 0;

-- Method 3

select c.customerID, o.OrderID
from customers c
left join orders o 
on c.customerID  = o.customerid 
where o.orderId is null;
