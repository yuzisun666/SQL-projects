--First name: YUZI
--Last name: SUN
--Student ID: 3748 6382 42   

--Q1
select concat(StfFirstName, ' ', StfLastname) name  
from Staff
where StfZipCode like '98%' and StfZipCode like '%0,1,3,4,5,6,7,8,9';

--Q2
select StfZipCode, count(*)
from Staff
group by StfZipCode
order by count(*) desc
limit 1;


--Q3
select concat(StfFirstName, ' ', StfLastname) name, Title, DateHired
from Faculty f
join Staff s
on f.StaffID = s.StaffID
where Title in ('professor', 'associate professor') and DateHired between '1992-01-01' and '1992-12-31'
order by DateHired desc;

--Q4
select f.Title, count(f.StaffID)
from Faculty f
join Staff s
on f.StaffID = s.StaffID
group by s.DateHired
Having f.Title in ('professors', 'associate professors') and s.DateHired > '1992-12-31';


--Q5
select concat(s.StudFirstName, ' ', s.StudLastName) name, avg(grade)
from Students s
join Student_Schedules sch
on s.StudentID = sch.StudentID
join Student_Class_Status sta
on sch.ClassStatus = sta.ClassStatus 
group by s.StudentID, sch.StudentID
having sta.ClassStatus = 2
order by 2 desc;


--Q6
select SubjectCode, SubjectName
from Subjects s
left join Faculty_Subjects f
on s.SubjectID = F.SubjectID
where f.StaffID is null;


--Q7
select concat(StfFirstName, ' ', StfLastname) name, count(*)
from Faculty_Classes fac
join Staff s
on s.StaffID = fac.StaffID
group by fac.StaffID
having count(fac.ClassID) > 7;

--Q8
select concat(StfFirstName, ' ', StfLastName) name, 
from Staff s
left join Students stu
on s.StfZipCode = stu.StudZipCode
where stu.StudZipCode is null
order by concat(StfFirstName, ' ', StfLastname) name;

--Q9
select concat(s1.StudFirstName, ' ', s1.StudLastName) name
from Students s1
join Students s2
on s1.StudZipCode = s2.StudZipCode
order by 1;




