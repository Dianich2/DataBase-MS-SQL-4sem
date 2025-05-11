use UNIVER;
Select f.FACULTY, p.PULPIT, pr.PROFESSION_NAME, s.SUBJECT_NAME, st.NAME,
case 
when(prg.NOTE = 6) then 'רוסעü'
when(prg.NOTE = 7) then 'סולü'
when(prg.NOTE = 8) then 'גמסולü'
end [NOTE]
from
FACULTY f Inner join PULPIT p on f.FACULTY = p.FACULTY 
inner join PROFESSION pr on pr.FACULTY = f.FACULTY
inner join SUBJECT s on p.PULPIT = s.PULPIT
inner join GROUPs g on g.PROFESSION = pr.PROFESSION
inner join STUDENT st on st.IDGROUP = g.IDGROUP
inner join PROGRESS prg on prg.IDSTUDENT = st.IDSTUDENT 
Where prg.NOTE BETWEEN 6 and 8
order by prg.NOTE DESC;
