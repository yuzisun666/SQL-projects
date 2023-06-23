--Q1
select total_amt_usd, 9672346.54 all_time_total
from orders;

select standard_amt_usd, 
	sum(standard_amt_usd) over() as all_time_total
from orders;

--Q2
select standard_amt_usd, 
	sum(standard_amt_usd) over(order by occurred_at) as running_total
from orders;

--Q3
select standard_amt_usd, date_trunc('month', occurred_at),
	sum(standard_amt_usd) over(partition by date_trunc('month', occurred_at) 
							   order by occurred_at) as monthly_running_total
from orders;

--Q18
--'where' clause is exucuted before the window function, so it need to be wrapped into subquery
--subquery is executed before the outer query
with running_totals as(
select id, account_id, occurred_at,
	sum(total_amt_usd) over (partition by account_id order by occurred_at) as running_total
from orders)

select *, row_number() over(partition by account_id order by running_total) order_number_over_100k
from running_totals
where running_total > 100000;



--Q18
with running_totals as(
select id, account_id,occurred_at, 
	sum(total_amt_usd) over (partition by account_id order by occurred_at) as running_total
from orders),
orders_over_100000 as(
select *, 
row_number() over(partition by account_id order by running_total) order_number_over_100K
from running_totals
where running_total >100000)

select *
from orders_over_100000
where order_number_over_100K = 1;


--Q19
select *, 
row_number() over (partition by date_trunc('month', occurred_at) order by occurred_at) as row_num
from orders;

--put the window function into a subquery so we can use where clause 
select *
from (select *, 
row_number() over (partition by date_trunc('month', occurred_at) order by occurred_at) as row_num
from orders) as t1
where row_num=1;


--Q19
select *
from (select *, 
row_number() over (partition by date_trunc('month',occurred_at) order by occurred_at desc) as row_num
from orders) as t1
where row_num=1;



--Q20
select id, account_id, total,
	rank() over(partition by account_id order by date_trunc('month',occurred_at)) as order_rank
from orders;


--Q22
select id, account_id, total,
	dense_rank() over(partition by account_id order by date_trunc('month',occurred_at)) as order_rank
from orders;

select id, account_id, total,
	dense_rank() over(partition by account_id order by occurred_at) as order_rank
from orders;

-----------
-- lead and lag window functions

select account_id, total_amt_usd, 
lag(total_amt_usd,1) over()
from orders;

select account_id, total_amt_usd, 
lag(total_amt_usd,1) over(partition by account_id order by occurred_at) lag1_total_amt_usd,
lag(total_amt_usd,5) over(partition by account_id order by occurred_at) lag5_total_amt_usd,
lead(total_amt_usd,1) over(partition by account_id order by occurred_at) lead1_total_amt_usd
from orders;



--Q23
select id, account_id, standard_qty,
dense_rank() over(partition by account_id order by date_trunc('month',occurred_at)) as dense_rank,
sum(standard_qty) over(partition by account_id order by date_trunc('month',occurred_at)) as sum_std_qty,
min(standard_qty) over(partition by account_id order by date_trunc('month',occurred_at)) as min_std_qty,
avg(standard_qty) over(partition by account_id order by date_trunc('month',occurred_at)) as avg_std_qty,
max(standard_qty) over(partition by account_id order by date_trunc('month',occurred_at)) as maxm_std_qty
from orders;


--Q24
select id, account_id, standard_qty,
dense_rank() over  account_month_window as dense_rank,
sum(standard_qty) over account_month_window as sum_std_qty,
min(standard_qty) over account_month_window as min_std_qty,
avg(standard_qty) over account_month_window as avg_std_qty,
max(standard_qty) over account_month_window as maxm_std_qty
from orders
window account_month_window as (partition by account_id order by date_trunc('month',occurred_at));


--Q25
select account_id, occurred_at, standard_qty,
ntile(4) over (order by standard_qty)
from orders;

select account_id, occurred_at, standard_qty,
ntile(4) over (partition by account_id order by standard_qty)
from orders;


