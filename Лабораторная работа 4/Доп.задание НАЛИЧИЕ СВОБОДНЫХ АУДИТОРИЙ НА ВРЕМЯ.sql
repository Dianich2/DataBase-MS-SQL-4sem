use UNIVER;
select a.AUDITORIUM, a.AUDITORIUM_TYPE from
AUDITORIUM a left outer join TIMETABLE tim on a.AUDITORIUM = tim.AUDITORIUM_ and tim.TIME_ in ('09:35:00')
where tim.AUDITORIUM_ is null;