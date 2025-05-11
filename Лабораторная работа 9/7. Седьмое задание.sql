drop table if exists #TempTable
go
create table #TempTable(
_Course int,
_Group int,
_Subgroup int)

Declare @curCourse int = 1,
		@curGroup int = 1,
		@curSubgroup int = 1

while @curCourse <= 4
begin
	insert #TempTable(_Course, _Group, _Subgroup)
	values(@curCourse, @curGroup, @curSubgroup)
	if @curSubgroup = 1 set @curSubgroup = 2
	else 
	begin
		set @curSubgroup = 1
		set @curGroup = @curGroup + 1
		if @curGroup > 10
		begin
			set @curCourse = @curCourse + 1
			set @curGroup = 1
		end
	end
end

select * from #TempTable

drop table if exists #TempTable2
go
create table #TempTable2(
_Faculty varchar(5),
_Course int,
_Group int)

Declare @curGroup2 int = 1

while @curGroup2 <= 10
begin
	insert #TempTable2(_Faculty, _Course, _Group)
	values('ิศา' , 2, @curGroup2)
	set @curGroup2 = @curGroup2 + 1
end

select * from #TempTable2