use Pod_MyBase;
--������� 1
declare @customerName varchar(20), @buf varchar(100) = ''
declare cursorForCustomerNames CURSOR for select f.CustomerCompanyName from [�����-��������] f;
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

--������� 2
declare @customerName varchar(20)
declare cursorForCustomerName CURSOR LOCAL for select f.CustomerCompanyName from [�����-��������] f
OPEN cursorForCustomerName
fetch cursorForCustomerName into @customerName
print @customerName
go
declare @customerName varchar(20)
fetch cursorForCustomerName into @customerName
print @customerName
go

declare @customerName varchar(20)
declare cursorForCustomerName CURSOR for select f.CustomerCompanyName from [�����-��������] f
OPEN cursorForCustomerName
fetch cursorForCustomerName into @customerName
print @customerName
go
declare @customerName varchar(20)
fetch cursorForCustomerName into @customerName
print @customerName
go

--������� 3

declare @companyName varchar(20), @bankDetails char(10)
declare cursorForCompanies CURSOR LOCAL STATIC for select f.CustomerCompanyName, f.BankDetails from [�����-��������] f
OPEN cursorForCompanies
INSERT into [�����-��������] values(102548, 'HI-GEAR', '6372183947', 1),
								   (102549, 'PATRON', '4720147819', 3),
								   (102550, 'CYCLO', '9372817374', 5)

fetch cursorForCompanies into @companyName, @bankDetails
while @@FETCH_STATUS = 0
begin
	print '��������: ' + @companyName + ', ���������� ���������: ' + @bankDetails
	fetch cursorForCompanies into @companyName, @bankDetails
end
Close cursorForCompanies
go 

select * from [�����-��������]

delete from [�����-��������] where CustomerCompanyID in(102548, 102549, 102550) 
go



declare @companyName varchar(20), @bankDetails char(10)
declare cursorForCompanies CURSOR LOCAL for select f.CustomerCompanyName, f.BankDetails from [�����-��������] f
OPEN cursorForCompanies
INSERT into [�����-��������] values(102548, 'HI-GEAR', '6372183947', 1),
								   (102549, 'PATRON', '4720147819', 3),
								   (102550, 'CYCLO', '9372817374', 5)
fetch cursorForCompanies into @companyName, @bankDetails
while @@FETCH_STATUS = 0
begin
	print '��������: ' + @companyName + ', ���������� ���������: ' + @bankDetails
	fetch cursorForCompanies into @companyName, @bankDetails
end
Close cursorForCompanies
go 

select * from [�����-��������]

delete from [�����-��������] where CustomerCompanyID in(102548, 102549, 102550)


--������� 4

declare @companyName varchar(20)
declare cursorForCompanies CURSOR LOCAL SCROLL for select f.CustomerCompanyName from [�����-��������] f
OPEN cursorForCompanies
fetch first from cursorForCompanies into @companyName
print '������ ��������: ' + @companyName
fetch next from cursorForCompanies into @companyName
print '��������� ��������: ' + @companyName
fetch absolute 4 from cursorForCompanies into @companyName
print '��������� �������� �� ������: ' + @companyName
fetch absolute -4 from cursorForCompanies into @companyName
print '��������� �������� �� �����: ' + @companyName
fetch prior from cursorForCompanies into @companyName
print '����� �������� �� �����: ' + @companyName
fetch relative 3 from cursorForCompanies into @companyName
print '����� �������� �� ������: ' + @companyName
fetch relative -3 from cursorForCompanies into @companyName
print '������ �������� �� ������: ' + @companyName
fetch last from cursorForCompanies into @companyName
print '��������� ��������: ' + @companyName
close cursorForCompanies
go

--������� 5

select * from �������
go

declare @advertisingName varchar(20)
declare cursorForAdvertising CURSOR LOCAL for select a.AdvertisingType from ������� a FOR UPDATE;
OPEN cursorForAdvertising
fetch cursorForAdvertising into @advertisingName
Delete ������� where Current of cursorForAdvertising
fetch cursorForAdvertising into @advertisingName
Update ������� set AdvertisingType = 'NEW' where AdvertisingID = 2
CLOSE cursorForAdvertising

select * from �������
go

insert into ������� values(1, 102543, 1, '2025-02-15', '00:00:35', '������� ��������� �����')
UPdate ������� set AdvertisingType = '������� ����������' where AdvertisingID = 2

select * from �������
go

--������� 6.1
insert into ������� values(6, 102542, 2, '2025-02-28', '00:00:12', '������� ������������'),
						  (7, 102547, 4, '2025-02-12', '00:00:10', '������� �����')

select * from �������
go

declare @companyName varchar(20), @programName varchar(50), @advertisingName varchar(50), @duration time
declare cursorForAdvertising CURSOR LOCAL for select f.CustomerCompanyName, p.ProgramName, r.AdvertisingType, r.Duration from [�����-��������] f inner join ������� r on f.CustomerCompanyID = r.CustomerCompanyID inner join 
�������� p on p.ProgramId = r.ProgramId where r.Duration < '00:00:15' FOR UPDATE
OPEN cursorForAdvertising
fetch cursorForAdvertising into @companyName, @programName, @advertisingName, @duration
while @@FETCH_STATUS = 0
begin
	print '��������: ' + @companyName + ', ��������: ' + @programName + ', �������: ' + @advertisingName + ', �����������������: ' + cast(@duration as varchar(8))
	delete ������� where Current of cursorForAdvertising
	fetch cursorForAdvertising into @companyName, @programName, @advertisingName, @duration
end
CLOSE cursorForAdvertising
go

select * from �������

--������� 6.2

select * from �������
go

declare @programId int = 5, @duration time
declare cursorForAdvertising CURSOR LOCAL for select r.Duration from ������� r where r.ProgramId = @programId FOR UPDATE
OPEN cursorForAdvertising
fetch cursorForAdvertising into @duration
while @@FETCH_STATUS = 0
begin
	update ������� set Duration = dateadd(SECOND, 1, @duration) where CURRENT OF cursorForAdvertising
	fetch cursorForAdvertising into @duration
end
close cursorForAdvertising

select * from �������
go

--���.�������
use UNIVER;
declare @faculty varchar(10), @pulpit varchar(10), @countOfTeacher int, @subject varchar(10)
declare cursorForFaculty CURSOR LOCAL STATIC for select f.FACULTY, p.PULPIT, count(t.TEACHER), s.SUBJECT from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY full outer join TEACHER t on t.PULPIT = p.PULPIT full outer join SUBJECT s on s.PULPIT = p.PULPIT group by f.FACULTY, p.PULPIT, s.SUBJECT order by f.FACULTY, p.PULPIT, s.SUBJECT;
OPEN cursorForFaculty
fetch cursorForFaculty into @faculty, @pulpit, @countOfTeacher, @subject
while @@FETCH_STATUS = 0
begin
	declare @bufFaculty varchar(10) = @faculty
	print ' ���������: ' + @bufFaculty
	while @bufFaculty = @faculty
	begin
		declare @bufPulpit varchar(10) = @pulpit, @bufForSubjects varchar(100) = '', @countOfTeacher2 int = 0
		print '    �������:' + @bufPulpit
		while @bufPulpit = @pulpit
		begin
			--print @faculty + ' ' + @pulpit + ' ' + cast(@countOfTeacher as varchar(3)) + ' ' + @subject
			if @subject is not null set @bufForSubjects = rtrim(@subject) + ', ' + @bufForSubjects
			set @countOfTeacher2 = @countOfTeacher
			fetch cursorForFaculty into @faculty, @pulpit, @countOfTeacher, @subject
			if @@FETCH_STATUS != 0 break
		end
		print '      ���������� ��������������: ' + cast(@countOfTeacher2 as varchar(3))
		if @bufForSubjects = '' print '      ����������: ���.'
		else
		begin
			set @bufForSubjects = SUBSTRING(@bufForSubjects, 1, len(@bufForSubjects) - 1) + '.'
			print '      ����������: ' + @bufForSubjects
		end
		if @@FETCH_STATUS != 0 return
	end
end
CLOSE cursorForFaculty
go

select f.FACULTY, p.PULPIT, count(t.TEACHER), s.SUBJECT from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY full outer join TEACHER t on t.PULPIT = p.PULPIT full outer join SUBJECT s on s.PULPIT = p.PULPIT group by f.FACULTY, p.PULPIT, s.SUBJECT order by f.FACULTY, p.PULPIT, s.SUBJECT;
