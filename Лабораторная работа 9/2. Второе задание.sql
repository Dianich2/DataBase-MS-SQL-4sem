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
print 'Количество аудиторий = ' + cast(@countOfAuditorium as varchar(10))
print 'Средняя вместимость = ' + cast(@averageCapacity as varchar(10))
print 'Количество аудиторий, вместимость которых меньше средней = ' + cast(@countOfSmallAuditorium as varchar(10))
print 'Процент таких аудиторий = ' + cast(@percentOfSmallAuditorium as varchar(10))
end
if @totalCapacity < 200
begin
print 'Общая вместимость аудиторий = ' + cast(@totalCapacity as varchar(10))
end
