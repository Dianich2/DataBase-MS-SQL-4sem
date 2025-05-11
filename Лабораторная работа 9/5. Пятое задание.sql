Declare @countOfGroups int
select @countOfGroups = max(s.IDGROUP) - min(s.IDGROUP) + 1 from STUDENT s;
print 'Всего групп - ' + cast(@countOfGroups as varchar(10))
Declare @averagecountOfStudentInGroup int 
select @averagecountOfStudentInGroup = avg(GP) from (select count(*) as GP from STUDENT s
Group by s.IDGROUP) as countInGroup
print 'Среднее число студентов в группе = ' + cast(@averagecountOfStudentInGroup as varchar(10))

drop table if exists #TempStud

Create table #TempStud(IdGroup int, countOfStudent int)
insert #TempStud(IdGroup, countOfStudent)
select s.IDGROUP, count(*) from STUDENT s group by s.IDGROUP;

declare @curGroup int = 2,
		@curCountOfStudent int
while @curGroup < @countOfGroups + 2
begin
	select @curCountOfStudent = countOfStudent from #TempStud t where t.IdGroup = @curGroup
	if @averagecountOfStudentInGroup < @curCountOfStudent print 'В группе ' + cast(@curGroup as varchar(10)) + ' количество студентов > среднего количества'
	else print 'В группе ' + cast(@curGroup as varchar(10)) + ' количество студентов <= среднему количеству'
	set @curGroup = @curGroup + 1
end



