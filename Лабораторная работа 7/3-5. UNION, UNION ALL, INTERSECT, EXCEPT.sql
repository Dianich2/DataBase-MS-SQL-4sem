use UNIVER;
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('“Œ¬')
group by g.PROFESSION, pr.SUBJECT
UNION
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('’“Ë“')
group by g.PROFESSION, pr.SUBJECT;

select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('“Œ¬')
group by g.PROFESSION, pr.SUBJECT
UNION ALL
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('’“Ë“')
group by g.PROFESSION, pr.SUBJECT;

select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('“Œ¬')
group by g.PROFESSION, pr.SUBJECT
INTERSECT
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('’“Ë“')
group by g.PROFESSION, pr.SUBJECT;

select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('“Œ¬')
group by g.PROFESSION, pr.SUBJECT
EXCEPT
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('’“Ë“')
group by g.PROFESSION, pr.SUBJECT;


select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('’“Ë“')
group by g.PROFESSION, pr.SUBJECT
EXCEPT
select g.PROFESSION, pr.SUBJECT, round(avg(cast(pr.NOTE as float(4))), 2)[avg_mark] 
from GROUPS g inner join STUDENT st on g.IDGROUP = st.IDGROUP
inner join PROGRESS pr on st.IDSTUDENT = pr.IDSTUDENT
where g.FACULTY in ('“Œ¬')
group by g.PROFESSION, pr.SUBJECT;
