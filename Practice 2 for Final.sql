--Q1
select entstagename, entphonenumber, entcity
from entertainers
where entcity in ('Bellevue', 'Redmond', 'Woodinville') and entemailaddress is null

--Q2
select engagementnumber, startdate, enddate
from engagements
where (startdate between '09-01-2017' and '09-30-2017') and (enddate-startdate=3);

--Q3
select concat(a.agtfirstname, ' ', a.agtlastname) name, e.startdate, e.enddate
from agents a
join engagements e
on a.agentid = e.agentid 
order by e.startdate desc
limit 5;

--Q4
select concat(a.agtfirstname, ' ', a.agtlastname) agtfullname, entstagename, agtzipcode
from agents a
join entertainers e
on a.agtzipcode = e.entzipcode
order by 1
limit 5;

--Q5
select distinct entstagename
from entertainers e
join engagements eg
on e.entertainerid = eg.entertainerid
join customers c
on eg.customerid= c.customerid
where custlastname = 'Berg' or custlastname = 'Hallmark'
order by 1
limit 5;

--Q6
select distinct e.entertainerid, e.entstagename
from entertainers e
left join engagements eg
on e.entertainerid = eg.entertainerid
where (entwebpage is null) or entemailaddress is null or engagementnumber is null
order by 1
limit 5;

--Q7
select ms.stylename, m.gender, count(distinct em.memberid) as num_members
from musical_styles ms
join entertainer_styles es
on ms.styleid = es.styleid
join entertainer_members em
using (entertainerid)
join members m
using (memberid)
group by 1,2
having count(distinct em.memberid)>4
order by 3 desc, 1

--Q8
SELECT  c.customerid, c.custfirstname, c.custlastname
from customers c
left join engagements e
on c.customerid = e.customerid
where engagementnumber is null;


--Q9
select avg(contractprice)
from engagements ---global avg price

select avg(contractprice) avg_contract_price, max(startdate) most_recent_start_date, count(engagementnumber) num_engagements
from engagements
where contractprice> (select avg(contractprice)
						from engagements)


--Q10
select customerid, count(engagementnumber) top_quatile_engagements
from customers c
join engagements e
on e.customerid = c.customerid
where contractprice ntile(4) 
group by 1

select t2.customerid, count(*) top_quatile_engagements
from (
	select *
	from(
		select customerid,
			ntile(4) over (order by contractprice) quartile
		from engagements)  t1
	where quartile = 4 )  t2
group by 1
order by 1
limit 5;

--Q11
select engagementnumber, e.entertainerid, contractprice, contractprice*1.1 adjusted_contractprice
from engagements e
join entertainers et
on e.entertainerid = et.entertainerid
where engagementnumber >9
order by 1


select t1.engagementnumber, t1.entertainerid, t1.contractprice, round((t1.contractprice*1.1),1) adjusted_contractprice
from(
	select g.*, t.entstagename,
	rank() over (partition by g.entertainerid order by g.startdate) ent_engagement_number
	from engagements g
	join entertainers t
	on g.entertainerid = t.entertainerid
	)t1
where t1.ent_engagement_number = 10
order by t1.engagementnumber;

--Q12
(select avg(contractprice)
from engagements
where engagementnumber <=5) t1
join
(select avg(contractprice)
from engagements
where engagementnumber>5)t2

select engagement_category, round(avg(contractprice),2) average
from(
		select e.contractprice,
		case when
				rank() over (partition by e.entertainerid order by e.startdate)<6
				then 'first five engagements'
			else 
				'6th and beyond engagements'
			end as engagement_category
		from engagements e) as tb1
group by 1;

-----
select t2.engagement_category, round(avg(t2.contractprice),3) avg
from(
	select 
	case when t1.ent_engagement_number < 6 THEN 'First Five Engagements'
	ELSE '6th and Beyond Engagements' END AS engagement_category,
	contractprice
	from(
		select contractprice,
		rank() over(partition by entertainerid order by engagementnumber) AS ent_engagement_number
		from engagements
	)t1
)t2
group by 1;


--Q13
select c.customerid, sum(e.contractprice) total_paid
from customers c
join engagements e
on c.customerid = e.customerid
where custfirstname != 'Karen' and custlastname != 'Smith'
group by 1
order by 2 desc;

sum(contractprice) over (partition by customerid order by )
select 
	case when engagementnumber<3 then 'normal price'
	case when engagementnumber>=3 then 'discounted price'
where enddate-startdate<=30



with 
--1st subquery
engagements_per_month as (
select c.customerid, e.contractprice, 
	row_number() over (partition by c.customerid, date_trunc('month', e.startdate) order by e.startdate) as engagement_number
from customers c
join engagements e
on c.customerid = e.customerid
where e.agentid != (
		select agentid
		from agents
		where concat(agtfirstname, ' ', agtlastname) = 'Karen Smith'
					)),
--2nd subquery					
adjusted_engagements as(
select *, case when engagement_number >=3 then 0.9
			else 1 end as adjustment
from engagements_per_month)
--main query
select customerid, sum(adjustment*contractprice)::int total_paid
FROM adjusted_engagements
GROUP BY 1
ORDER BY 2 DESC;