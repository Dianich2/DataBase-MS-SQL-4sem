use UNIVER;
select a.AUDITORIUM, a.AUDITORIUM_TYPE from
AUDITORIUM a left join TIMETABLE t on a.AUDITORIUM = t.AUDITORIUM_ and t.DAY_OF_WEEK in('понедельник')
where t.AUDITORIUM_ is null;