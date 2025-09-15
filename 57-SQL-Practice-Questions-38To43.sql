/*
38. Janet Leverling, one of the salespeople, has come
to you with a request. She thinks that she
accidentally double-entered a line item on an order,
with a different ProductID, but the same quantity.
She remembers that the quantity was 60 or more.
Show all the OrderIDs with line items that match
this, in order of OrderID.
*/

select * from orders;
select * from [Order Details];

Select
 OrderID
From [Order Details]
Where Quantity >= 60
Group By
 OrderID
 ,Quantity
Having Count(*) > 1

/*
39. Based on the previous question, we now want to
show details of the order, for orders that match the
above criteria.
*/

select * from [Order Details];

select orderid, productid, unitprice, discount
from [Order Details] 
where orderid in (
		Select
		 OrderID
		From [Order Details]
		Where Quantity >= 60
		Group By
		 OrderID
		 ,Quantity
		Having Count(*) > 1
			)

/*
40. Here's another way of getting the same results as in
the previous problem, using a derived table instead
of a CTE. However, there's a bug in this SQL. It
returns 20 rows instead of 16. Correct the SQL.
*/

Select distinct
 [Order Details].OrderID
 ,ProductID
 ,UnitPrice
 ,Quantity
 ,Discount
From [Order Details]
 Join (
 Select
 OrderID
 From [Order Details]
 Where Quantity >= 60
 Group By OrderID, Quantity
 Having Count(*) > 1
 ) PotentialProblemOrders
 on PotentialProblemOrders.OrderID = [Order Details].OrderID
Order by OrderID, ProductID

/*
41. Some customers are complaining about their orders
arriving late. Which orders are late?
*/

select * from orders;

select orderid, orderdate, requireddate, shippeddate
from orders 
where ShippedDate >= RequiredDate or RequiredDate > getdate();

/*
42. Some salespeople have more orders arriving late
than others. Maybe they're not following up on the
order process, and need more training. Which
salespeople have the most orders arriving late? 
*/

select * from employees;
select * from [Order Details];

select e.employeeid, e.lastname, count(*) as TotalLateOrders 
from employees e 
left join orders o 
on e.employeeid = o.employeeid 
where ShippedDate >= RequiredDate 
group by e.employeeid, e.lastname 
order by TotalLateOrders desc;

/*
43. Andrew, the VP of sales, has been doing some
more thinking some more about the problem of late
orders. He realizes that just looking at the number
of orders arriving late for each salesperson isn't a
good idea. It needs to be compared against the total
number of orders per salesperson. 
*/

select e.employeeid, e.lastname, count(orderId) as allorders, sum(
case
	when shippedDate > requiredDate then 1 else 0 
end ) as LateOrders
from employees e
left join orders o 
on e.employeeid = o.employeeID
group by e.employeeid, lastname;

select e.employeeid, e.lastname, 
       count(o.OrderID) as AllOrders, 
       sum(case when shippedDate > requiredDate then 1 else 0 end) as LateOrders,
       round(cast(sum(case when shippedDate > requiredDate then 1 else 0 end) as float) 
       / count(o.OrderID) * 100, 2) as LatePercentage
from employees e
left join orders o 
  on e.employeeid = o.employeeID
group by e.employeeid, e.lastname;
