--Q1
select *
from accounts 
inner join orders
on accounts.id = orders.account_id
where accounts.name = 'Walmart';

select *
from accounts 
join orders --inner is default and not needed
on accounts.id = orders.account_id
where accounts.name = 'Walmart';

select *
from accounts as a 
join orders as o
on a.id = o.account_id
where a.name = 'Walmart';

select *
from accounts a  -- word as is not needed
join orders o
on a.id = o.account_id
where a.name = 'Walmart';

select o.id,a.name,o.total
from accounts a  -- word as is not needed
join orders o
on a.id = o.account_id and a.name = 'Walmart'; --criteria could be included in ON clause

--Q2
select r.name as region_name,s.name sales_rep,a.name account_name
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id;

--Q3
select r.name as region_name, a.name account_name, 
	round(o.total_amt_usd / (o.total + 0.01),2) unit_price
	-- round(value/exprerssion, number of decimal digits after a decimal point)
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
join orders o
on a.id = o.account_id;

-- rewrite the query and remove orders with qunatity = 0 instead of dividing by quatntity +0.01

select r.name as region_name, a.name account_name, 
	round(o.total_amt_usd / o.total ,2) unit_price 
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id
join orders o
on a.id = o.account_id
-- where o.total > 0; -- o.total <> 0 where <> means not equal
-- where not o.total = 0
where o.total != 0; -- != means does not equal

--Q4
select count(*)
from accounts;

--Q5
select sum(poster_qty) total_poster_qty
from orders;

--Q6
select sum(standard_amt_usd + gloss_amt_usd) total_amt_usd_stadard_and_gloss
from orders;

--Q7
select min(poster_qty) min_poster_qty, max(poster_qty) max_poster_qty
from orders;

--Q10
select round(avg(standard_amt_usd),2) average_standard_amt_usd,
		round(avg(gloss_amt_usd),2) average_gloss_amt_usd
from orders;

--Q11
-- For each account find total amt usd
select a.name, sum(total_amt_usd)
from accounts a
join orders o
on a.id = o.account_id
group by a.name;

--what company spent largest ammount?
select a.name, sum(total_amt_usd)
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by sum(total_amt_usd) desc;


select a.name, sum(total_amt_usd) total_amount
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by total_amount desc;


select a.name, sum(total_amt_usd) total_amount
from accounts a
join orders o
on a.id = o.account_id
group by 1
order by 2 desc;

--Q12
select channel, count(*) times_used
from web_events
group by channel;

--Q13
select a.name, min(o.total_amt_usd)
from accounts a
join orders o
on a.id = o.account_id
group by a.name
order by 2;


--Q14
select s.name,w.channel,count(*)
from web_events w
join accounts a
on w.account_id = a.id
join sales_reps s
on a.sales_rep_id = s.id
group by 1,2
order by 3 desc;

--Q15
select count(distinct a.name) midwest_accounts
from accounts a
join sales_reps s
on a.sales_rep_id = s.id
join region r
on s.region_id = r.id 
join orders o
on a.id = o.account_id
where r.name = 'Midwest';

--Q16
select account_id, count(*)
from orders
group by account_id
having count(*) >20;

select count(*)
from (
	select account_id, count(*)
	from orders
	group by account_id
	having count(*) >20) as tbl1;

--Q17
select account_id, sum(total_amt_usd)
from orders
group by account_id
having sum(total_amt_usd) > 30000;

select count(*)
from (select account_id, sum(total_amt_usd)
	from orders
	group by account_id
	having sum(total_amt_usd) > 30000) as t1;

--Q18
select account_id
from web_events
where channel = 'facebook'
group by account_id
having count(*)>6;

