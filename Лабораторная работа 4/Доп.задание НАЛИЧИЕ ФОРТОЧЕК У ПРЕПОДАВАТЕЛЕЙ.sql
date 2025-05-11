use UNIVER;
select t.TEACHER_NAME, t.PULPIT from
TEACHER t left outer join TIMETABLE tim on t.TEACHER = tim.TEACHER_ and tim.DAY_OF_WEEK in('понедельник') and tim.TIME_ in('09:35:00')
where tim.TEACHER_ is null and t.PULPIT in('ИСиТ');