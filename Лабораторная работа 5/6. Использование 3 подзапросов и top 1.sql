use UNIVER;
select top 1
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE '����')[����],
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE '��')[��],
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE '����')[����]
from PROGRESS;
