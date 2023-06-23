--Q1
select concat(e.firstname, ' ', e.lastname) manager_name, count(distinct e.employeeid) employees, count(distinct r.regionid) regions, count(distinct t.territoryid) territories, count(distinct o.orderid) orders, count(distinct c.customerid) customers
from employees e
join orders o
on e.employeeid = o.employeeid
join employeeterritories et
on et.employeeid = e.employeeid
join territories t
on t.territoryid = et. territoryid
join region r
on r.regionid = t.regionid
join customers c
on c.customerid = o.customerid
where e.title ilike '%Manager%'
group by 1;

SELECT re.firstname || '' || re.lastname 	AS manager_name,
		COUNT(DISTINCT t.regionid) 			AS regions,
		COUNT(DISTINCT e.employeeid) 		AS employees,
		COUNT(DISTINCT t.territoryid) 		AS territories,
		COUNT(DISTINCT o.orderid) 			AS orders,
		COUNT(DISTINCT o.customerid)		AS customers

FROM employees e
		JOIN employees re ON re.employeeid = e.reportsto
		JOIN employeeterritories et ON et.employeeid = e.employeeid 
		JOIN territories t ON t.territoryid = et.territoryid
		JOIN region r ON r.regionid = t.regionid
		JOIN orders o ON o.employeeid = e.employeeid
GROUP BY 1;

--Q2
select orderid, orderdate, od.quantity*od.unitprice*(1-od.discount) order_totals,
sum(od.quantity*od.unitprice*(1-od.discount)) over (order by orderdate) as running_order_total, 
avg(od.quantity*od.unitprice*(1-od.discount)) over (order by orderdate) as avg_order_total
from orders o
join orderdetails od
using (orderid)


with t1 as (
select o.orderid, o.orderdate, sum(od.quantity* od.unitprice*(1-od.discount)) order_total
from orders o
join orderdetails od
using (orderid)
join customers c
using (customerid)
where c.country = 'Germany'
group by 1,2)

select *,
sum(order_total) over (order by orderdate) running_order_total,
avg(order_total) over (order by orderdate) avg_order_total
from (
select o.orderid, o.orderdate, sum(od.quantity* od.unitprice*(1-od.discount)) order_total
from orders o
join orderdetails od
using (orderid)
join customers c
using (customerid)
where c.country = 'Germany'
group by 1,2) as t1
order by 5 desc


select 
		sum(order_total) over (order by )
orderid, orderdate, (quantity*unitprice*(1-discount)) as ordertotals, 
sum(ordertotals) over (order by orderdate) as running_order_total, 
avg(ordertotals) over (order by orderdate) as average_order_total
from orders;
join orderdetails od

select

--Q2
select o.orderid, o.orderdate, sum(od.quantity*od.unitprice*(1-od.discount)) as order_total, avg(od.quantity*od.unitprice*(1-od.discount)) average_order_total
from customers c
join orders o
on o.customerid= c.customerid
join orderdetails od
on od.orderid = o.orderid
where country ilike '%Germany%'
group by 1,2
order by 4,2 desc
limit 10

SELECT *,
SUM(order_total) OVER (ORDER BY orderdate, orderid) AS running_total, 
AVG(order_total) OVER (ORDER BY orderdate, orderid) AS average_order_total
FROM (SELECT o.orderid,o.orderdate,
SUM((1 - od.discount) * (od.unitprice * od.quantity)) AS order_total FROM orders o
JOIN orderdetails od ON od.orderid = o.orderid
JOIN customers c ON c.customerid = o.customerid
WHERE c.country = 'Germany'
GROUP BY 1, 2) as t1
order by 5 desc LIMIT 10


--Q3
select p.productid, p.productname, sum((p.unitprice-od.unitprice)*od.quantity) as total_markdown_order_value
from products p
join orderdetails od
on p.productid = od.productid
join categories c
on c.categoryid = p.categoryid
where c.categoryname <> 'Meat/Poultry'
group by 1,2
having sum((p.unitprice-od.unitprice)*od.quantity) > 3000 
order by 3 desc;

--Q4
select e.employeeid, concat(e.firstname, ' ', e.lastname) fullname, count(*) orders, 
(count(o.orderid)/sum(orderid)) pct_of_order, 
(count(*) - avg(orderid)) order_difference,  (select avg(count)
                                                    from (select count(orderid) from orders
														 	group by employeeid) as t1)  avg_order_per_employee,
													
													
	case 
		when count(*)<50 then 'Associates'
		when count(*)<=100 then 'Senior Associates'
		else 'Principles' end as title
from employees e
join orders o
on o.employeeid = e.employeeid
group by 1,2


SELECT *,
ROUND(orders / (SELECT SUM(orders) FROM (SELECT e.employeeid, e.firstname || ' ' || e.lastname fullname,
COUNT(DISTINCT o.orderid) AS orders
FROM employees e
JOIN orders o
on e.employeeid = o.employeeid
GROUP BY 1, 2) as t2)::NUMERIC, 2) AS pct_of_order, ROUND(orders - (SELECT AVG(orders) FROM (SELECT e.employeeid, e.firstname || ' ' || e.lastname fullname,
COUNT(DISTINCT o.orderid) AS orders
FROM employees e
JOIN orders o
on e.employeeid = o.employeeid
GROUP BY 1, 2) as t3)::NUMERIC, 2) AS order_differential, 
CASE WHEN orders >= 101 THEN 'Principal'
WHEN orders >= 51 THEN 'Senior Associate'
ELSE 'Associate' END AS title
FROM(SELECT e.employeeid, e.firstname || ' ' || e.lastname fullname, COUNT(DISTINCT o.orderid) AS orders
FROM employees e
JOIN orders o
on e.employeeid = o.employeeid GROUP BY 1, 2) as t1
ORDER BY 3 DESC

--Q5
select concat(firstname, ' ', lastname) managername, 
count(distinct employeeid) num_of_employees_managed 
from employees 
group by 1

SELECT e2.firstname || ' ' || e2.lastname AS managername, 
COUNT(*) num_of_employees_managed
FROM employees e1
JOIN employees e2
ON e1.reportsto = e2.employeeid 
GROUP BY 1;

--Q6
select productname, 
(sum(od.quantity * od.unitprice))::int total_value_of_late_orders,
(0.2*sum(od.quantity * od.unitprice))::int total_refunded_value
from products p
join orderdetails od
on p.productid=od.productid
group by 1
order by 2 desc;


SELECT productname,
		(SUM(unitprice * quantity))::INT AS total_value_of_late_orders, 
 		(SUM(unitprice * quantity) * 0.2)::INT AS total_refunded_value
FROM (SELECT od.orderid,
DENSE_RANK() OVER (PARTITION BY customerid ORDER BY orderdate, od.orderid) late_order_number, 
od.*, p.productname
		FROM orders o
		JOIN orderdetails od ON od.orderid = o.orderid 
		JOIN products p ON p.productid = od.productid 
		WHERE requireddate < shippeddate) as t1
WHERE late_order_number > 1 
GROUP BY 1
ORDER BY 2 DESC;
 
    
--Q7
select row_number, orderdate, 
sum(quantity*unitprice) order_total, 
orderid, last_3_avg_order_total
from orders o
join orderdetails od
on o.orderid = od.orderid
order by 2 desc



SELECT
	row_number,
	orderdate,
	order_total,
	orderid,
	(SELECT AVG(order_total)
	FROM (SELECT ROW_NUMBER() OVER (ORDER BY orderdate, orderid), *
	FROM (SELECT o.orderid, o.orderdate, SUM(od.quantity * od.unitprice) AS order_total
					FROM orderdetails od
					JOIN orders o
					on od.orderid = o.orderid 
		  			GROUP BY 1, 2) tbl2) tbl1
WHERE row_number BETWEEN tbl5.row_number - 2 AND tbl5.row_number) AS last_3_avg_order_total 
FROM (SELECT ROW_NUMBER() OVER (ORDER BY orderdate, orderid), *
		FROM (SELECT o.orderid, o.orderdate, SUM(od.quantity * od.unitprice) AS order_total 
			  	FROM orderdetails od
				JOIN orders o
				on od.orderid = o.orderid 
			  	GROUP BY 1, 2)tbl4) tbl5
order by 3 desc 
LIMIT 10;



