--Q1
select *
from facilities
where name like '%Tennis%' and name not like '%Tennis';

--Q2
select facid, name, membercost, monthlymaintenance
from facilities
where membercost !=0 and membercost < monthlymaintenance/50;

--Q3
select firstname, surname
from members
order by joindate desc
limit 1;

--Q4
select b.starttime 
from bookings as b
join members as m
on b.memid = m.memid
where m.firstname = 'David' and m.surname = 'Farrell';

--Q5
select count(*)
from (select *
	  from facilities
	  where monthlymaintenance > 1000) as tbl1;
	 

--Q6
select distinct concat (m.firstname, ' ',m.surname) as member, 
b.starttime, f.name as facility

from members as m
join bookings as b 
on m.memid= b.memid
join facilities as f
on b.facid = f.facid
where b.facid in (0,1) and b.starttime between '2012-09-21' and '2012-09-22'
order by member;


--Q7
select facid, sum(slots) as "Total Slots"
from bookings
group by facid
having sum(slots) > 1000
order by facid


--Q8
select f.name as facility, sum(b.slots*guestcost) as "TotalRevenue"
from members m 
join bookings b on m.memid = b.memid
join facilities f on b.facid = f.facid
where m.memid = 0
group by 1
order by 2 desc;


--Q9
select *
from members m
left join bookings b
on b.memid = m.memid
where b.bookid is null


--Q10
select m2.memid, concat(m2.firstname, ' ',m2.surname) name, count(*) 
from members m1
join members m2
on m1.recommendedby = m2.memid
group by 1, 2
order by 1;


--Q6
select 
from 


































