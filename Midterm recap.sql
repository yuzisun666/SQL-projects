--First name: YUZI
--Last name: SUN
--Student ID: 3748 6382 42   

--Q1
select concat(StfFirstName, ' ', StfLastname) name  
from Staff
where StfZipCode like '98%' and (StfZipCode like '%0' or 
								 StfZipCode like '%1' or 
								 StfZipCode like '%2')


--Q2
select StfZipCode
from Staff
group by StfZipCode
order by count(*) desc
limit 1;




--Q3
select concat(s.StfFirstName, ' ', s.StfLastname) name, f.Title, s.DateHired
from Staff as s
join Faculty as f
on f.StaffID = s.StaffID
where f.Title in ('Professor', 'Associate Professor') and 
	  s.datehired >= '1992-01-01' and s.datehired < '1993-01-01'
order by s.datehired desc;


select *
from faculty


--Q3
select Concat(s.stffirstname, ' ', s.stflastname) as name,
    f.Title, s.DateHired
from staff as s
join faculty as f
on s.StaffID = f.StaffID
where f.title in ('Professor', 'Associate Professor') and
      s.DateHired >= '1992-01-01' and  s.DateHired < '1993-01-01';

--Q3
select concat(s.stffirstname, '', s.stflastname) as name, s.datehired, f.title
from staff s
join faculty f
on s.staffid=f.staffid
where f.title in ('Professor', 'Associate Professor') and s.datehired >= '1992-01-01' and s.datehired < '1993-01-01'
order by datehired desc;



--Q4
select count(*)
from staff as s
join faculty as f
on s.StaffID = f.StaffID
where f.title in ('Professor', 'Associate Professor') and
      s.DateHired >= '1993-01-01';





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


--Q5
select Concat(s.StudFirstName, ' ', s.StudLastName) as student_name,
  AVG(grade) as Student_Average_Grade
FROM students as s
join student_schedules as ss
on s.StudentID = ss.studentid
join classes as c
on ss.classid = c.classid
join subjects sj
on c.subjectid = sj.subjectid
Where ss.classstatus = 2
group by 1
order by 2 DESC;


--Q5
select concat(s1.studfirstname,' ',s1.studlastname) as name, avg(grade) as Student_Average_Grade
from students s1
join student_schedules s2
on s1.studentid = s2.studentid
where s2.classstatus = 2
group by 1
order by 2 DESC;


having s2.classstatus = 2







--Q6
select SubjectCode, SubjectName
from Subjects s
left join Faculty_Subjects f
on s.SubjectID = F.SubjectID
where f.StaffID is null;

--Q6
select subjectcode, subjectname
from subjects s
left join faculty_subjects fs
on s.subjectid = fs.subjectid
where staffid is null;

--Q7
select concat(StfFirstName, ' ', StfLastname) name, count(*), s.StaffID
from Faculty_Classes fac
join Staff s
on s.StaffID = fac.StaffID
group by concat(StfFirstName, ' ', StfLastname)
having count(fac.ClassID) > 7;


--Q7
select Concat(staff.stffirstname, ' ',staff.stflastname), count(*)
from classes
join faculty_classes
on classes.classid = faculty_classes.classid
join faculty
on faculty_classes.staffid = faculty.staffid
join staff
on staff.staffid = faculty.staffid
GROUP BY 1
having count(*) > 7;


--Q7
select concat(stffirstname, ' ', stflastname) as name, count(classid) as number_of_classes
from staff s 
join faculty_classes f
on s.staffid = f.staffid
group by 1
having count(classid) > 7





--Q8
select concat(StfFirstName, ' ', StfLastName) name
from staff s
left join Students stu
on s.StfZipCode = stu.StudZipCode
where stu.StudZipCode is null
order by name;

--Q8
select Concat(s.stflastname,'',s.stffirstname) as Faculty_member 
from staff s 
left join students st 
on s.stfzipcode = st.studzipcode 
where st.studentid is null 
order by 1;



--Q9
select concat(s1.StudFirstName, ' ', s1.StudLastName) name
from Students s1
join Students s2
on s1.StudZipCode = s2.StudZipCode
order by 1;

--Q9
select s1.studfirstname ||' '|| s1.studlastname as student 
from students s1 
join students s2 
on s1.studzipcode = s2.studzipcode 

group by 1 
having count(*)>=2 
order by 1;



where s1.studentid != s2.studentid
--Q9
select concat(s1.studfirstname, ' ', s1.studlastname) name
from students s1
join students s2
on s1. studzipcode = s2.studzipcode
order by 1;











--Q5
select Concat(s.StudFirstName, ' ', s.StudLastName) as student_name,
  AVG(grade) as Student_Average_Grade
FROM students as s
join student_schedules as ss
on s.StudentID = ss.studentid
join classes as c
on ss.classid = c.classid
join subjects sj
on c.subjectid = sj.subjectid
Where ss.classstatus = 2
group by 1
order by 2 DESC;

-- Using Average GPA rather than Average Grade
select concat(s.studfirstname,' ',s.studlastname) name, 
	cast(sum(((grade)/20 - 1)*credits)/sum(credits) as Decimal(5,2)) as GPA
from Students s
join Student_Schedules ss
on s.StudentID = ss.StudentID
join Classes c
on ss.ClassID = c.ClassID
where classstatus = 2
group by s.StudentID
order by 2 desc;


--Q8
select Concat(s.stflastname,'',s.stffirstname) as Faculty_member 
from staff s 
left join students st 
on s.stfzipcode = st.studzipcode 
where st.studentid is null 
order by 1;


--Q9
select s1.studfirstname ||' '|| s1.studlastname as student 
from students s1 
join students s2 
on s1.studzipcode = s2.studzipcode 
group by 1 
having count(*)>=2 
order by 1;




