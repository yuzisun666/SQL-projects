drop table if exists table_a; -- delete table _a from a database if it exists in the database
drop table if exists table_b; 

create table table_a(
				id int primary key,
				a varchar(10));

insert into table_a (id,a) Values (1, 'm'), (2,'n'),(4, 'o');

create table table_b(
				id int primary key,
				b varchar(10));

insert into table_b (id,b) Values (2, 'p'), (3,'q'),(5, 'r');

--Inner join
select * 
from table_a a
join table_b b
on a.id = b.id;

--left join
select * 
from table_a a
left join table_b b
on a.id = b.id;
--where b is not null;

--right join
select * 
from table_a a
right join table_b b
on a.id = b.id;

--full outer join
select * 
from table_a a
full join table_b b
on a.id = b.id;


--natural join 
select * 
from table_a a
natural join table_b b;

--cross join 
select * 
from table_a a
cross join table_b b;

--self join
select *
from table_a as x
join table_a as y
on x.id = y.id;

______________________________________________________________________________________________________

select * from employee;

-- List employees and their managers

select concat(e.first_name,' ',e.last_name) as emplyee,
	concat(m.first_name,' ',m.last_name) as manager
from employee as e
join employee as m
on e.manager_id = m.employee_id;

select concat(e.first_name,' ',e.last_name) as emplyee,
	concat(m.first_name,' ',m.last_name) as manager
from employee as e
left join employee as m
on e.manager_id = m.employee_id;