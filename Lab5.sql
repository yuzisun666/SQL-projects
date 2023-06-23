--Q1
select date_part('year',occurred_at), sum(total_amt_usd)
from orders
group by 1
order by 2 desc;

--Q2
select date_part('year',occurred_at),date_part('month',occurred_at), sum(total_amt_usd)
from orders
group by 1,2
order by 3 desc
limit 1;

--Q3
select date_part('year',occurred_at) ord_year, count(*) total_sales
from orders
group by 1
order by 2 desc;

--Q4
select date_trunc('month',occurred_at) order_month, sum(gloss_amt_usd) tot_spent
from accounts a
join orders o
on a.id = o.account_id and a.name='Walmart'
group by 1
order by 2 desc
limit 1;

--Q5
select s.name,count(*), 
	case when count(*)>200 then 'top'
	else 'notTop' end as sales_rep_level
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
group by 1;

--Q5 with only top category
select s.name,count(*), 
	case when count(*)>200 then 'top' end as sales_rep_level
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
group by 1;

--Q6
select s.name,count(*) num_orders, sum(o.total_amt_usd) total_spent,
	case 
		when count(*)>200 or sum(o.total_amt_usd)>750000 then 'top'
		when count(*)>150 or sum(o.total_amt_usd)>500000 then 'middle'
		else 'low' end as sales_rep_level
from accounts a
join orders o
on a.id = o.account_id 
join sales_reps s
on a.sales_rep_id = s.id
group by 1
order by 3 desc;


