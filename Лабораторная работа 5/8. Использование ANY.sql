use UNIVER;
select t.SUBJECT_, t.TEACHER_, t.DAY_OF_WEEK, t.TIME_ from
TIMETABLE t where t.TIME_ >= any(select ti.TIME_ from TIMETABLE ti
where ti.TEACHER_ like 'ÌÐÇ');