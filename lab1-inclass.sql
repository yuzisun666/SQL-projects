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
select name, website, primary_poc
from accounts
where name = 'Exxon Mobil';

--Q9
select poster_qty + gloss_qty as total_qty_nonstandard
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
where name in ('Apple','Walmart')

--Q12
select name,primay_poc,id,








