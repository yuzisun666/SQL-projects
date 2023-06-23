--First name: Yuzi
--Last name: Sun
--ID = 3748 6382 42       

--Q1
select customer_id 
from orders 
where movie_id in ('P1','P5')
group by customer_id
having count(distinct movie_id) = 2;


--Q2
select movie_id, sum(minutesstreamed)
from orders
group by 1
order by 2 desc
limit 1;

--Q3
select customer_id 
from orders 
WHERE movie_id in ('P1','P2','P3''P4','P5','P6')
GROUP BY customer_id
HAVING COUNT(DISTINCT movie_id) = 1;

SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*)=1

--Q4
select customer_id 
from orders 
where minutesstreamed < minutesstreamed(n-1)
order by purchasedate


--Q5
WITH t1 AS(
SELECT EngagementNumber,
 StartDate,
 CASE WHEN EntertainerID IN (SELECT EntertainerID
FROM Engagements
GROUP BY 1
HAVING COUNT(*)>=10) THEN ContractPrice*0.08
 ELSE ContractPrice*0.1 END AS agency_revenue
FROM Engagements
ORDER BY 2,1)

SELECT *, SUM(agency_revenue) OVER(ORDER BY StartDate,EngagementNumber) AS running_total
FROM t1
limit 5;


--Q6
select *
from
	(select concat(agtfirstname, ' ', agtlastname) name, count(engagementnumber) num_engagements, 'musical_style' as type
	from agents a
	join engagements e
	on a.agentid = e.agentid 
	group by 1
	order by 2 desc
	limit 5) t1
	
UNION ALL

select *
from 
	(select stylename, count(engagementnumber) num_engagements, 'agent' AS type
	 from entertainer_styles es 
	 join musical_styles ms
	 on ms.styleid = es.styleid
	 join engagements e
	 on e.entertainerid = es.entertainerid
	group by 1
	order by 2 desc
	limit 5) t2

join t1 and t2 on type
group by rollup (type)




--Q7
select num_phone_numbers, COUNT(*) AS count,
	case
		when SUBSTR(number, 5, 2) > '25' then 'landline'
		else 'mobile' end as phone_types
from		
	(select custphonenumber, agtphonenumber
	from customers c
	join engagements e
	on e.customerid = c.customerid
	join agents a
	on a.agentid = e.agentid
	GROUP BY 1,2) t1 


--Q8

select a.agentid, a.salary, sum(commissionrate*contractprice) commission, (a.salary+commissionrate*contractprice)final_compensation,
	case
		when engagementnumber > 15 then '0.1'
		else '0' end as high_performer_bonus
from agents a
join engagements e
on a.agentid = e.agentid
group by 1,2,4,5
order by final_compensation desc;






