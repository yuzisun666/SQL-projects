--Q1
select distinct c.custfirstname,c.custlastname 
from customers c
join orders o
on c.customerid = o.customerid
join order_details od 
on o.ordernumber = od.ordernumber
join products p
on od.productnumber = p.productnumber
where p.productname not ilike '%mountain bike%' and p.productname ilike '%helmet%';

--Q2
select distinct e.empfirstname ||' '|| e.emplastname as employee,
				concat(c.custfirstname,' '  ,c.custlastname) as customer
from customers c
join orders o
on c.customerid = o.customerid
join employees e
on e.employeeid = o.employeeid

--Q3
--order number, product name, and amount owed.

select o.ordernumber, p.productname,
od.quotedprice * od.quantityordered as amount_owed
from orders o
join order_details od
on o.ordernumber = od.ordernumber
join products p
on od.productnumber = p.productnumber
where od.quotedprice * od.quantityordered * 1.0 > 100.0 LIMIT 10;

--Q4
select c.customerid, concat(c.custfirstname, ’ ’, c.custlastname), c.custzipcode from customers c
left join employees e
on c.custzipcode = e.empzipcode
where e.employeeid IS NULL LIMIT 10;

--Q5
select p.productnumber, p.productname, od.ordernumber from products p
left join order_details od
on p.productnumber = od.productnumber
where od.ordernumber is null and p.quantityonhand > 10 LIMIT 10;






