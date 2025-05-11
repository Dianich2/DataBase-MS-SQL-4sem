use Pod_MyBase;
--ЗАДАНИЕ 1
declare @customerName varchar(20), @buf varchar(100) = ''
declare cursorForCustomerNames CURSOR for select f.CustomerCompanyName from [Фирма-заказчик] f;
OPEN cursorForCustomerNames
fetch cursorForCustomerNames into @customerName
while @@FETCH_STATUS = 0
begin
	set @buf = rtrim(@customerName) + ', ' + @buf;
	fetch cursorForCustomerNames into @customerName;
end
set @buf = substring(@buf, 1, len(@buf) - 1) 
print @buf
CLOSE cursorForCustomerNames
deallocate cursorForCustomerNames
go

--ЗАДАНИЕ 2
declare @customerName varchar(20)
declare cursorForCustomerName CURSOR LOCAL for select f.CustomerCompanyName from [Фирма-заказчик] f
OPEN cursorForCustomerName
fetch cursorForCustomerName into @customerName
print @customerName
go
declare @customerName varchar(20)
fetch cursorForCustomerName into @customerName
print @customerName
go

declare @customerName varchar(20)
declare cursorForCustomerName CURSOR for select f.CustomerCompanyName from [Фирма-заказчик] f
OPEN cursorForCustomerName
fetch cursorForCustomerName into @customerName
print @customerName
go
declare @customerName varchar(20)
fetch cursorForCustomerName into @customerName
print @customerName
go

--ЗАДАНИЕ 3

declare @companyName varchar(20), @bankDetails char(10)
declare cursorForCompanies CURSOR LOCAL STATIC for select f.CustomerCompanyName, f.BankDetails from [Фирма-заказчик] f
OPEN cursorForCompanies
INSERT into [Фирма-заказчик] values(102548, 'HI-GEAR', '6372183947', 1),
								   (102549, 'PATRON', '4720147819', 3),
								   (102550, 'CYCLO', '9372817374', 5)

fetch cursorForCompanies into @companyName, @bankDetails
while @@FETCH_STATUS = 0
begin
	print 'Компания: ' + @companyName + ', банковские реквизиты: ' + @bankDetails
	fetch cursorForCompanies into @companyName, @bankDetails
end
Close cursorForCompanies
go 

select * from [Фирма-заказчик]

delete from [Фирма-заказчик] where CustomerCompanyID in(102548, 102549, 102550) 
go



declare @companyName varchar(20), @bankDetails char(10)
declare cursorForCompanies CURSOR LOCAL for select f.CustomerCompanyName, f.BankDetails from [Фирма-заказчик] f
OPEN cursorForCompanies
INSERT into [Фирма-заказчик] values(102548, 'HI-GEAR', '6372183947', 1),
								   (102549, 'PATRON', '4720147819', 3),
								   (102550, 'CYCLO', '9372817374', 5)
fetch cursorForCompanies into @companyName, @bankDetails
while @@FETCH_STATUS = 0
begin
	print 'Компания: ' + @companyName + ', банковские реквизиты: ' + @bankDetails
	fetch cursorForCompanies into @companyName, @bankDetails
end
Close cursorForCompanies
go 

select * from [Фирма-заказчик]

delete from [Фирма-заказчик] where CustomerCompanyID in(102548, 102549, 102550)


--ЗАДАНИЕ 4

declare @companyName varchar(20)
declare cursorForCompanies CURSOR LOCAL SCROLL for select f.CustomerCompanyName from [Фирма-заказчик] f
OPEN cursorForCompanies
fetch first from cursorForCompanies into @companyName
print 'Первая компания: ' + @companyName
fetch next from cursorForCompanies into @companyName
print 'Следующая компания: ' + @companyName
fetch absolute 4 from cursorForCompanies into @companyName
print 'Четвертая компания от начала: ' + @companyName
fetch absolute -4 from cursorForCompanies into @companyName
print 'Четвертая компания от конца: ' + @companyName
fetch prior from cursorForCompanies into @companyName
print 'Пятая компания от конца: ' + @companyName
fetch relative 3 from cursorForCompanies into @companyName
print 'Пятая компания от начала: ' + @companyName
fetch relative -3 from cursorForCompanies into @companyName
print 'Вторая компания от начала: ' + @companyName
fetch last from cursorForCompanies into @companyName
print 'Последняя компания: ' + @companyName
close cursorForCompanies
go

--ЗАДАНИЕ 5

select * from РЕКЛАМЫ
go

declare @advertisingName varchar(20)
declare cursorForAdvertising CURSOR LOCAL for select a.AdvertisingType from РЕКЛАМЫ a FOR UPDATE;
OPEN cursorForAdvertising
fetch cursorForAdvertising into @advertisingName
Delete РЕКЛАМЫ where Current of cursorForAdvertising
fetch cursorForAdvertising into @advertisingName
Update РЕКЛАМЫ set AdvertisingType = 'NEW' where AdvertisingID = 2
CLOSE cursorForAdvertising

select * from РЕКЛАМЫ
go

insert into РЕКЛАМЫ values(1, 102543, 1, '2025-02-15', '00:00:35', 'Реклама машинного масла')
UPdate РЕКЛАМЫ set AdvertisingType = 'Реклама двигателей' where AdvertisingID = 2

select * from РЕКЛАМЫ
go

--ЗАДАНИЕ 6.1
insert into РЕКЛАМЫ values(6, 102542, 2, '2025-02-28', '00:00:12', 'Реклама акумуляторов'),
						  (7, 102547, 4, '2025-02-12', '00:00:10', 'Реклама масла')

select * from РЕКЛАМЫ
go

declare @companyName varchar(20), @programName varchar(50), @advertisingName varchar(50), @duration time
declare cursorForAdvertising CURSOR LOCAL for select f.CustomerCompanyName, p.ProgramName, r.AdvertisingType, r.Duration from [Фирма-заказчик] f inner join РЕКЛАМЫ r on f.CustomerCompanyID = r.CustomerCompanyID inner join 
ПЕРЕДАЧИ p on p.ProgramId = r.ProgramId where r.Duration < '00:00:15' FOR UPDATE
OPEN cursorForAdvertising
fetch cursorForAdvertising into @companyName, @programName, @advertisingName, @duration
while @@FETCH_STATUS = 0
begin
	print 'Компания: ' + @companyName + ', передача: ' + @programName + ', реклама: ' + @advertisingName + ', продолжительность: ' + cast(@duration as varchar(8))
	delete РЕКЛАМЫ where Current of cursorForAdvertising
	fetch cursorForAdvertising into @companyName, @programName, @advertisingName, @duration
end
CLOSE cursorForAdvertising
go

select * from РЕКЛАМЫ

--ЗАДАНИЕ 6.2

select * from РЕКЛАМЫ
go

declare @programId int = 5, @duration time
declare cursorForAdvertising CURSOR LOCAL for select r.Duration from РЕКЛАМЫ r where r.ProgramId = @programId FOR UPDATE
OPEN cursorForAdvertising
fetch cursorForAdvertising into @duration
while @@FETCH_STATUS = 0
begin
	update РЕКЛАМЫ set Duration = dateadd(SECOND, 1, @duration) where CURRENT OF cursorForAdvertising
	fetch cursorForAdvertising into @duration
end
close cursorForAdvertising

select * from РЕКЛАМЫ
go

--ДОП.ЗАДАНИЕ
use UNIVER;
declare @faculty varchar(10), @pulpit varchar(10), @countOfTeacher int, @subject varchar(10)
declare cursorForFaculty CURSOR LOCAL STATIC for select f.FACULTY, p.PULPIT, count(t.TEACHER), s.SUBJECT from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY full outer join TEACHER t on t.PULPIT = p.PULPIT full outer join SUBJECT s on s.PULPIT = p.PULPIT group by f.FACULTY, p.PULPIT, s.SUBJECT order by f.FACULTY, p.PULPIT, s.SUBJECT;
OPEN cursorForFaculty
fetch cursorForFaculty into @faculty, @pulpit, @countOfTeacher, @subject
while @@FETCH_STATUS = 0
begin
	declare @bufFaculty varchar(10) = @faculty
	print ' Факультет: ' + @bufFaculty
	while @bufFaculty = @faculty
	begin
		declare @bufPulpit varchar(10) = @pulpit, @bufForSubjects varchar(100) = '', @countOfTeacher2 int = 0
		print '    Кафедра:' + @bufPulpit
		while @bufPulpit = @pulpit
		begin
			--print @faculty + ' ' + @pulpit + ' ' + cast(@countOfTeacher as varchar(3)) + ' ' + @subject
			if @subject is not null set @bufForSubjects = rtrim(@subject) + ', ' + @bufForSubjects
			set @countOfTeacher2 = @countOfTeacher
			fetch cursorForFaculty into @faculty, @pulpit, @countOfTeacher, @subject
			if @@FETCH_STATUS != 0 break
		end
		print '      Количество преподавателей: ' + cast(@countOfTeacher2 as varchar(3))
		if @bufForSubjects = '' print '      Дисциплины: нет.'
		else
		begin
			set @bufForSubjects = SUBSTRING(@bufForSubjects, 1, len(@bufForSubjects) - 1) + '.'
			print '      Дисциплины: ' + @bufForSubjects
		end
		if @@FETCH_STATUS != 0 return
	end
end
CLOSE cursorForFaculty
go

select f.FACULTY, p.PULPIT, count(t.TEACHER), s.SUBJECT from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY full outer join TEACHER t on t.PULPIT = p.PULPIT full outer join SUBJECT s on s.PULPIT = p.PULPIT group by f.FACULTY, p.PULPIT, s.SUBJECT order by f.FACULTY, p.PULPIT, s.SUBJECT;
