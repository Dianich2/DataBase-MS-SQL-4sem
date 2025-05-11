use UNIVER;
select top 1
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE 'нюХо')[нюХо],
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE 'ад')[ад],
(select avg(p.NOTE) from PROGRESS p
where p.SUBJECT LIKE 'ясад')[ясад]
from PROGRESS;
