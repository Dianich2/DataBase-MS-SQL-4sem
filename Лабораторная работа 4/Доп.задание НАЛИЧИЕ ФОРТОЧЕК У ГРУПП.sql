use UNIVER;
select g.IDGROUP, g.PROFESSION, g.YEAR_FIRST from
GROUPS g left join TIMETABLE t on g.IDGROUP = t.GROUP_ and t.DAY_OF_WEEK in('понедельник') and t.TIME_ in('08:00:00', '09:35:00', '11:25:00', '18:00:00', '14:40:00', '13:00:00')
where t.GROUP_ is null;