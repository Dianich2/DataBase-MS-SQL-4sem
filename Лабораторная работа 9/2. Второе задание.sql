Declare @totalCapacity int 
Select @totalCapacity= sum(AUDITORIUM_CAPACITY) from AUDITORIUM;
if @totalCapacity > 200
begin
declare @countOfAuditorium int,
		@averageCapacity int,
		@countOfSmallAuditorium int,
		@percentOfSmallAuditorium int
select @countOfAuditorium = count(*) from AUDITORIUM
select @averageCapacity = avg(AUDITORIUM_CAPACITY) from AUDITORIUM
select @countOfSmallAuditorium = count(*) from AUDITORIUM a where a.AUDITORIUM_CAPACITY < @averageCapacity
select @percentOfSmallAuditorium = @countOfSmallAuditorium * 100 / @countOfAuditorium
print '���������� ��������� = ' + cast(@countOfAuditorium as varchar(10))
print '������� ����������� = ' + cast(@averageCapacity as varchar(10))
print '���������� ���������, ����������� ������� ������ ������� = ' + cast(@countOfSmallAuditorium as varchar(10))
print '������� ����� ��������� = ' + cast(@percentOfSmallAuditorium as varchar(10))
end
if @totalCapacity < 200
begin
print '����� ����������� ��������� = ' + cast(@totalCapacity as varchar(10))
end
