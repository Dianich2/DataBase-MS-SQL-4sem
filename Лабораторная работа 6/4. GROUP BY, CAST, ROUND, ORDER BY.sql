use UNIVER;
select f.FACULTY_NAME, g.PROFESSION, (4 - g.YEAR_FIRST % 10)[COURSE], round(avg(cast(p.NOTE as float(4))), 2) as AVG_MARK 
from FACULTY f 
inner join GROUPS g on f.FACULTY = g.FACULTY 
inner join STUDENT st on st.IDGROUP = g.IDGROUP 
inner join PROGRESS p on p.IDSTUDENT = st.IDSTUDENT
group by f.FACULTY_NAME, g.PROFESSION, (4 - g.YEAR_FIRST % 10)
order by avg_mark desc;

