--Provide your student ID below 
--ID = 3748 6382 42                  

--Q1  
--where后面跟完整的subquery
select productname, unitprice, unitsinstock
from products
where unitprice > (select avg(unitprice) from products)
and unitsinstock < (select avg(unitsinstock) from products)
order by 1;


--Q2
--from后面跟完整的subquery
select avg(count)
from (select count(orderid) from orders
		group by employeeid) as t1;

--Q3
select companyname, contactname, count(orderid) as num_of_orders
from customers c
join orders o
on c.customerid = o.customerid
group by 1, 2
order by 3 desc
limit 5;

--Q4
--select后面跟完整的subquery
select c.companyname, c.contactname,(select count(*)
								from orders o
								where o.customerid = c.customerid) num_orders
from customers c
order by 3 desc
limit 5;

--Q5
select country, count(c.customerid) number_of_no_order_customers
from customers c
left join orders o
on c.customerid = o.customerid
where o.orderid is null
group by 1
order by 1;

--Q6
--having后面跟完整的subquery
select avg(count_orderid)
from (select count(o.OrderID) count_orderid
	from Orders o
	group by o.CustomerID) t1;

select c.CustomerID, count(o.OrderID) num_of_orders
from Customers c
join Orders o
on c.Customerid = o.CustomerID
group by c.CustomerID
having count(o.OrderID)> (select avg(num_of_orders)
							from (select count(o.OrderID) num_of_orders
								from Orders o
								group by o.CustomerID) t1)
order by count(o.OrderID) desc
limit 5;
	

--Q7
select p.productid, avg(unitsinstock), sum(p.unitprice * o.quantity) total_order_value
from products p
join orderdetails o
on p.ProductID = o.ProductID
group by 1
order by 3 desc
limit 5;

--Q8
--from和where后面要跟完整的subqueries
select o.employeeid
from OrderDetails od
join Orders o
on o.OrderID = od.OrderID
group by 1
having sum(od.Quantity * od.UnitPrice) > 100000;

select orderid, customerid, freight, orderdate
from (
 select *
 from orders o
 order by o.orderdate desc
 limit 10) as tb1
where employeeid in(
 select o.employeeid
 from orderdetails od
 join orders o
 on od.orderid = o.orderid
 group by 1
 having sum(od.unitprice * od.quantity) > 100000)
order by freight desc
limit 10;


--Q9	
select concat(e.FirstName, ' ',e.LastName) as employee_name,count(*) total_heavy_orders
from Orders o
join Employees e
on o.EmployeeID = e.EmployeeID
where o.Freight > 200
group by employee_name
having count(*)> (select avg(num_orders)
				from (select count(*) num_orders
					 from orders
					 group by CustomerID) order_counts)
order by total_heavy_orders desc, employee_name;
		
--Q10
select concat(firstname,' ', lastname) employee_name, count(orderid) num_orders,
	case
		when count(*)> 75 then 'High Performer'
		when count(*)> 50 then 'Mid Tier'
		else 'Low Performer' end as performance_rating
from employees e
join orders o
on e.employeeid = o.employeeid
group by 1
order by 2 desc;










