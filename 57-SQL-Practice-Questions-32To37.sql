/*
32. We want to send all of our high-value customers a
special VIP gift. We're defining high-value
customers as those who've made at least 1 order
with a total value (not including the discount) equal
to $10,000 or more. We only want to consider
orders made in the year 1998.
*/

select * from customers; -- CustomerId, CompanyName
select * from orders; -- OrderID
select * from [Order Details]; -- TotalOrderAmount

-- CustomerId, CompanyName, OrderID, TotalOrderAmount

select c.customerid, c.companyname, o.orderId, od.unitprice * od.quantity as TotalOrderAmount
from customers c
join orders o 
on c.customerid = o.customerid 
join [Order Details] od 
on o.OrderID = od.OrderID
where year(orderDate) = 1998 and od.unitprice * od.quantity >= 10000


select c.customerid, c.companyname, o.orderId, sum(od.unitprice * od.quantity) as TotalOrderAmount
from customers c
join orders o 
on c.customerid = o.customerid 
join [Order Details] od 
on o.OrderID = od.OrderID
where year(orderDate) = 1998
group by c.customerid, c.companyname, o.orderid
having sum(od.unitprice * od.quantity) >= 10000;

/*
32. The manager has changed his mind. Instead of
requiring that customers have at least one
individual orders totaling $10,000 or more, he
wants to define high-value customers as those who
have orders totaling $15,000 or more in 2016. How
would you change the answer to the problem
above?
*/


select c.customerid, c.companyname, sum(od.unitprice * od.quantity) as TotalOrderAmount
from customers c
join orders o 
on c.customerid = o.customerid 
join [Order Details] od 
on o.OrderID = od.OrderID
where year(orderDate) = 1998
group by c.customerid, c.companyname
having sum(od.unitprice * od.quantity) >= 15000;


/*
34. Change the above query to use the discount when
calculating high-value customers. Order by the
total amount which includes the discount.
*/


select c.customerid, c.companyname, sum(od.unitprice * od.quantity - od.unitprice * od.quantity * od.discount) as TotalOrderAmount
									--  sum(od.unitprice * od.quantity * (1 - od.discount)) as TotalOrderAmount
from customers c
join orders o 
on c.customerid = o.customerid 
join [Order Details] od 
on o.OrderID = od.OrderID
where year(orderDate) = 1998
group by c.customerid, c.companyname
having sum(od.unitprice * od.quantity - od.unitprice * od.quantity * od.discount) >= 15000
order by sum(od.unitprice * od.quantity - od.unitprice * od.quantity * od.discount) desc;


/*
35. At the end of the month, salespeople are likely to
try much harder to get orders, to meet their monthend quotas. Show all orders made on the last day of
the month. Order by EmployeeID and OrderID
*/

-- EmployeeId, OrderId, OrderDate

select e.employeeid, o.orderid, o.orderdate
from employees e
left join orders o 
on e.employeeid = o.employeeid
where orderDate = eomonth(orderdate)
order by employeeid, orderid;


-- Another way to use dense rank to get the orders on the max last date
select employeeid, orderid, orderdate from 
(
	select *,
	dense_rank() over (
		partition by year(orderdate), month(orderdate) 
		order by orderdate desc)
	 as rn
	from orders
) t
where rn = 1;

/*
36. The Northwind mobile app developers are testing
an app that customers will use to show orders. In
order to make sure that even the largest orders will
show up correctly on the app, they'd like some
samples of orders that have lots of individual line
items. Show the 10 orders with the most line items,
in order of total line items.
*/


select * from orders;
select * from [Order Details];

select top 10 o.orderid, count(*)
from orders o 
left join [Order Details] od 
on o.OrderID = od.OrderID
group by o.orderid
order by count(*) desc;

/*
37. The Northwind mobile app developers would now
like to just get a random assortment of orders for
beta testing on their app. Show a random set of 2%
of all orders.
*/

select top 2 percent orderid 
from orders 
order by newid()


select orderid, randomvalue = rand()
from orders;

