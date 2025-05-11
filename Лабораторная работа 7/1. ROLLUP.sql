use UNIVER;
select f.FACULTY, g.PROFESSION, pr.SUBJECT, round(avg(Cast(pr.NOTE as float(4))), 2)[avg_mark] from FACULTY f inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT st on g.IDGROUP = st.IDGROUP 
inner join PROGRESS pr on pr.IDSTUDENT = st.IDSTUDENT
group by f.FACULTY, g.PROFESSION, pr.SUBJECT;

select f.FACULTY, g.PROFESSION, pr.SUBJECT, round(avg(Cast(pr.NOTE as float(4))), 2)[avg_mark] from FACULTY f inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT st on g.IDGROUP = st.IDGROUP 
inner join PROGRESS pr on pr.IDSTUDENT = st.IDSTUDENT
group by ROllUP (f.FACULTY, g.PROFESSION, pr.SUBJECT);
