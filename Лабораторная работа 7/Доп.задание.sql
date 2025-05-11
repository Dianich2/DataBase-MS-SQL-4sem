use UNIVER;
select f.FACULTY, g.IDGROUP, count(*)[countOfStudent] from FACULTY f inner join GROUPS g on f.FACULTY = g.FACULTY
inner join STUDENT st on g.IDGROUP = st.IDGROUP
group by ROLLUP(f.FACULTY, g.IDGROUP);

select a.AUDITORIUM_TYPE, sum(a.AUDITORIUM_CAPACITY)[capacity], (RIGHT(a.AUDITORIUM_NAME, 1))[Building], count(*)[countOfAuditorium] from AUDITORIUM a inner join AUDITORIUM_TYPE au on a.AUDITORIUM_TYPE = au.AUDITORIUM_TYPE
group by ROLLUP (a.AUDITORIUM_TYPE, RIGHT(a.AUDITORIUM_NAME, 1));