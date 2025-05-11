drop view IF EXISTS РАСПИСАНИЕ
go
CREATE VIEW РАСПИСАНИЕ as 
select t.DAY_OF_WEEK as ДЕНЬ_НЕДЕЛИ, t.TIME_ as ВРЕМЯ, t.SUBJECT_ as ПРЕДМЕТ, 
t.AUDITORIUM_ as АУДИТОРИЯ, t.TEACHER_ as ПРЕПОДАВАТЕЛЬ, t.GROUP_ as ГРУППА 
from TIMETABLE t;
go
select * from РАСПИСАНИЕ as p PIVOT
(max(Группа) for ДЕНЬ_НЕДЕЛИ in([понедельник], [вторник], [среда], [четверг], [пятница], [суббота])) as newTable;