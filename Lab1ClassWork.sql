--Q1
select id,name
from sales_reps;

--Q2
select * 
from accounts;

--Q3
select *
from sales_reps
limit 10;

--Q4
select * 
from orders
order by occurred_at desc
limit 10;

--Q5
select id, occurred_at, total_amt_usd 
from orders
order by occurred_at 
limit 10;

--Q6
select * 
from orders
order by account_id, total_amt_usd desc;

--Q7
select *
from orders
where account_id=4251;

--Q8
select name,website,primary_poc
from accounts
where name = 'Exxon Mobil';

--Q9
select *,poster_qty + gloss_qty as total_qty_nonstandard
from orders;

--Q10
select name,website
from accounts
where name like '%Whole Foods%';

select website
from accounts
where website like '%wholefoods%';

--Q11
select id
from accounts
where name in ('Apple','Walmart');

--Q12
select name, primary_poc, sales_rep_id
from accounts
where name not in ('Walmart', 'Target', 'Nordstrom');

--Q13
select *
from orders
where occurred_at >= '2016-04-01' and occurred_at <= '2016-09-01'
order by occurred_at desc;

--Q14
select *
from orders
where occurred_at between '2016-04-01' and '2016-09-01';
--order by occurred_at desc;

--Q15
select *
from orders
where standard_qty > 1000 and poster_qty = 0 and gloss_qty = 0;

--Q16
select *
from web_events
where channel in ('organic', 'adwords') and occurred_at between '2016-01-01' and '2017-01-01'
order by occurred_at desc;

select *
from web_events
where (channel = 'organic' or channel ='adwords') and occurred_at between '2016-01-01' and '2017-01-01'
order by occurred_at ;

--Q17
select account_id
from orders
where standard_qty = 0 or poster_qty = 0 or gloss_qty = 0;

--Q18
select *
from orders
where standard_qty = 0 and (gloss_qty > 1000 or poster_qty > 1000);

--Q19
select *
from accounts
where (name like 'C%' or name like 'W%') and 
(primary_poc like '%ana%' or primary_poc like '%Ana%') and 
primary_poc not like '%eana%';

