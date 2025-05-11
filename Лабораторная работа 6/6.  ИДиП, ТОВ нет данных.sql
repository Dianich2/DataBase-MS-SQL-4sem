use UNIVER;
select f.FACULTY_NAME, g.PROFESSION, p.SUBJECT, round(avg(cast(p.NOTE as float(4))), 2) as AVG_MARK 
from FACULTY f 
inner join GROUPS g on f.FACULTY = g.FACULTY 
inner join STUDENT st on st.IDGROUP = g.IDGROUP 
inner join PROGRESS p on p.IDSTUDENT = st.IDSTUDENT
where f.FACULTY Like 'ÈÄèÏ'
group by f.FACULTY_NAME, g.PROFESSION, p.SUBJECT
order by avg_mark desc;

