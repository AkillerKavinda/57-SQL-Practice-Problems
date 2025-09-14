/*
31. One employee (Margaret Peacock, EmployeeID 4)
has placed the most orders. However, there are
some customers who've never placed an order with
her. Show only those customers who have never
placed an order with her.
*/


select * from customers;
select * from orders;


select customerid 
from customers 
where customerid not in (select customerid from orders where employeeid = 4);


select c.customerid 
from customers c
left join orders o 
on c.customerid = o.customerid
and o.employeeid = 4
where o.customerid is null;

/*

select * from customers c
left join orders o 
on c.customerid = o.customerid
and o.employeeid = 4;


select c.customerid 
from customers c
left join orders o 
on c.customerid = o.customerid
and o.employeeid = 4
where o.customerid is null;

*/

select * from customers c
left join orders o 
on c.customerid = o.customerid
and o.employeeid = 4;


-- Wow! This is a beautiful question