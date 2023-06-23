--Q1
-- step 1: find 10 largest spending accounts
-- step 2 average their total amounts

select sum(total_amt_usd)
from orders
group by account_id
order by 1 desc
limit 10;

select round(avg(sum),2)
from (
	select sum(total_amt_usd)
	from orders
	group by account_id
	order by 1 desc
	limit 10
	) as t1;
		
-- alternatively we can use cte (with statement):
with t1 as (select sum(total_amt_usd)
		from orders
		group by account_id
		order by 1 desc
		limit 10)		
select round(avg(sum),2)
from t1;


--Q2
select avg(average)
from (
	select avg(total_amt_usd) average
	from orders o
	join accounts a
	on o.account_id= a.id
	group by a.name
	having avg(total_amt_usd) > (
								select avg(total_amt_usd) 
								from orders
								)
	 )as t1
	 

--Q2
select avg(total_amt_usd)
from orders;

select round(avg(total_amt_usd),2) lifetime_spend_avg
from orders
group by account_id
having avg(total_amt_usd) > (select avg(total_amt_usd)from orders)

select round(avg(lifetime_spend_avg),2)
from (select round(avg(total_amt_usd),2) lifetime_spend_avg
	from orders
	group by account_id
	having avg(total_amt_usd) > (select avg(total_amt_usd)from orders)) as t1;

--recreate the subquery using with clause:
with t1 as (select avg(total_amt_usd)from orders),
	 t2 as (select round(avg(total_amt_usd),2) lifetime_spend_avg
			from orders
			group by account_id
			having avg(total_amt_usd) > (select * from t1))
select round(avg(lifetime_spend_avg),2)
from t2;

---
select a.name, channel, count(we.id)
from web_events we
join accounts a
on a.id = we.account_id
where a.name = (select a.name
				from accounts a 
				join orders o
				on a.id = o.account_id
				group by 1
				order by sum(total_amt_usd) desc
				limit 1)
group by channel, a.name

having a.name like (select a.name
from accounts a 
join orders o
on a.id = o.account_id
group by 1
order by sum(total_amt_usd) desc
limit 1)


select a.name, sum(total_amt_usd)
from accounts a 
join orders o
on a.id = o.account_id
group by 1
order by 2 desc
limit 1;


--Q3
-- Find the customer that has largest total_amt_usd

select a.name -- , o.account_id, sum(o.total_amt_usd)
from orders o
join accounts a
on a.id = o.account_id
group by a.name, o.account_id
order by sum(o.total_amt_usd) desc
limit 1

select a.name,w.channel, count(*)
from accounts a 
join web_events w
on a.id = w.account_id
group by a.name,w.channel
having a.name = (select a.name -- , o.account_id, sum(o.total_amt_usd)
				from orders o
				join accounts a
				on a.id = o.account_id
				group by a.name, o.account_id
				order by sum(o.total_amt_usd) desc
				limit 1)

select a.name,w.channel, count(*)
from accounts a 
join web_events w
on a.id = w.account_id
where a.name = (select a.name -- , o.account_id, sum(o.total_amt_usd)
				from orders o
				join accounts a
				on a.id = o.account_id
				group by a.name, o.account_id
				order by sum(o.total_amt_usd) desc
				limit 1)
group by a.name,w.channel

-- if two kargest accounts
select a.name,w.channel, count(*)
from accounts a 
join web_events w
on a.id = w.account_id
where a.name in (select a.name -- , o.account_id, sum(o.total_amt_usd)
				from orders o
				join accounts a
				on a.id = o.account_id
				group by a.name, o.account_id
				order by sum(o.total_amt_usd) desc
				limit 2)
group by a.name,w.channel

-- using with clause

with t1 as (select a.name, o.account_id, sum(o.total_amt_usd)
				from orders o
				join accounts a
				on a.id = o.account_id
				group by a.name, o.account_id
				order by sum(o.total_amt_usd) desc
				limit 1)
select a.name,w.channel, count(*)
from accounts a 
join web_events w
on a.id = w.account_id
where a.name = (select name from t1)
group by a.name,w.channel;

-- using joins:
select a.name,w.channel, count(*)
from (select a.name -- , o.account_id, sum(o.total_amt_usd)
				from orders o
				join accounts a
				on a.id = o.account_id
				group by a.name, o.account_id
				order by sum(o.total_amt_usd) desc
				limit 1) as t1
join accounts a
on t1.name = a.name
join web_events w
on a.id = w.account_id 
group by a.name,w.channel



---
select r.name, count(o.id)
from orders o
join accounts a
on o.account_id = a.id
join sales_reps sr
on a.sales_rep_id=sr.id
join region r
on r.id = sr.region_id				
where r.name = (select r.name
				from region r
				join sales_reps sr
				on r.id=sr.region_id
				join accounts a
				on a.sales_rep_id = sr.id
				join orders o
				on o.account_id = a.id
				group by 1 
				order by sum(total_amt_usd) desc
				limit 1)
group by 1;




--Q4
select r.name
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
group by r.name
order by sum(total_amt_usd) desc
limit 1;

select r.name, count(*)
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
group by r.name
having r.name = (select r.name
	from accounts a
	join orders o
	on a.id = o.account_id 
	join sales_reps s
	on a.sales_rep_id = s.id
	join region r
	on r.id = s.region_id
	group by r.name
	order by sum(total_amt_usd) desc
	limit 1);
	
-- without using subquery:
select r.name, count(*)
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
join region r
on r.id = s.region_id
group by r.name
order by sum(total_amt_usd) desc
limit 1


-------
select sum(o.total), count(a.name)
from accounts a
join orders o
on a.id=o.account_id

where sum(o.total)>count(a.name)>

select sum(o.total)
from orders o
where o.account_id = (
					select a.id, sum(o.standard_qty)
					from accounts a 
					join orders o
					on a.id= o.account_id
					group by 1
					order by sum(o.standard_qty) desc
					limit 1
					 )
	
	
group by a.name







--Q5
--1. find the account that had the most standard_qty paper
--2. use this information to pull the accounts  with more sales of all types of paper
--3. get the count of accounts with more in total purchases

--1.
select sum(standard_qty)
from orders 
group by account_id
order by sum(standard_qty) desc
limit 1

--2. 
select count(*)
from (select account_id
		from orders 
		group by account_id
		having sum(total) > (select sum(standard_qty)
									from orders 
									group by account_id
									order by sum(standard_qty) desc
									limit 1)) as t1;


-----
--Q6
select region_name, max(total_spent)
from(
	select s.name sales_rep, r.name region_name, sum(total_amt_usd) total_spent
	from sales_reps s
	join accounts a
	on a.sales_rep_id = s.id
	join orders o
	on a.id = o.account_id
	join region r
	on r.id = s.region_id
	group by s.name, r.name
	order by sum(total_amt_usd) desc) as t1
group by region_name


select s.name sales_rep, r.name region_name, sum(total_amt_usd) total_spent
from sales_reps s
join accounts a
on a.sales_rep_id = s.id
join orders o
on a.id = o.account_id
join region r
on r.id = s.region_id
group by 1,2
	
	
select t1.region_name, t1.sales_rep rep_name, t1.total_spent total_amt	
from(
	select s.name sales_rep, r.name region_name, sum(total_amt_usd) total_spent
	from sales_reps s
	join accounts a
	on a.sales_rep_id = s.id
	join orders o
	on a.id = o.account_id
	join region r
	on r.id = s.region_id
	group by 1,2) as t1
	
join(select region_name, max(total_spent)
	from(select s.name sales_rep, r.name region_name, sum(total_amt_usd) total_spent
		from sales_reps s
		join accounts a
		on a.sales_rep_id = s.id
		join orders o
		on a.id = o.account_id
		join region r
		on r.id = s.region_id
		group by s.name, r.name
		order by sum(total_amt_usd) desc) as t2
		group by region_name) as t3
on t1.region_name = t3.region_name and t1.total_spent = t3.max
order by 3 desc;


--7: example to illustrate correlated query:
-- At what time companies are placing orders that are larger than their average order?
select * from orders;

select o1.occurred_at
from orders o1
where o1.total_amt_usd >(select avg(o2.total_amt_usd)
							from orders o2
						 	where o2.account_id = o1.account_id);





