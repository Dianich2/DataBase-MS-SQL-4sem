Declare @countOfGroups int
select @countOfGroups = max(s.IDGROUP) - min(s.IDGROUP) + 1 from STUDENT s;
print '����� ����� - ' + cast(@countOfGroups as varchar(10))
Declare @averagecountOfStudentInGroup int 
select @averagecountOfStudentInGroup = avg(GP) from (select count(*) as GP from STUDENT s
Group by s.IDGROUP) as countInGroup
print '������� ����� ��������� � ������ = ' + cast(@averagecountOfStudentInGroup as varchar(10))

drop table if exists #TempStud

Create table #TempStud(IdGroup int, countOfStudent int)
insert #TempStud(IdGroup, countOfStudent)
select s.IDGROUP, count(*) from STUDENT s group by s.IDGROUP;

declare @curGroup int = 2,
		@curCountOfStudent int
while @curGroup < @countOfGroups + 2
begin
	select @curCountOfStudent = countOfStudent from #TempStud t where t.IdGroup = @curGroup
	if @averagecountOfStudentInGroup < @curCountOfStudent print '� ������ ' + cast(@curGroup as varchar(10)) + ' ���������� ��������� > �������� ����������'
	else print '� ������ ' + cast(@curGroup as varchar(10)) + ' ���������� ��������� <= �������� ����������'
	set @curGroup = @curGroup + 1
end



