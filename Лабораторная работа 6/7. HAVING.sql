use UNIVER;
select p.SUBJECT, p.NOTE,
(select count(*) from PROGRESS p2 where p.SUBJECT = p2.SUBJECT and p.NOTE = p2.NOTE)[Количество студентов]
from PROGRESS p 
group by p.SUBJECT, p.NOTE
Having p.NOTE in (8, 9)
order by p.NOTE DESC, [Количество студентов];