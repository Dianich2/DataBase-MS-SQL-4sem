use UNIVER;
select * from
PULPIT p FULL OUTER JOIN TEACHER t on p.PULPIT = t.PULPIT
where t.TEACHER is not NULL
order by t.TEACHER_NAME;

use UNIVER;
select * from
TEACHER t FULL OUTER JOIN PULPIT p on p.PULPIT = t.PULPIT
where t.TEACHER is not NULL
order by t.TEACHER_NAME;