use Pod_MyBase;

-- ������� 1 ----------
select * from �������

Drop PROCEDURE if exists PADVERTISING
go
CREATE PROCEDURE PADVERTISING
as
begin
	declare @count int = (select count(*) from �������);
	select * from �������
	return @count;
end
go

declare @rs int
exec @rs = PADVERTISING
print '���������� ������ = ' + cast(@rs as varchar(5))

-- ������� 2 ----------
go
alter PROCEDURE PADVERTISING @custId int, @c int output
as
begin
	declare @count int = (select count(*) from �������);
	select * from ������� where CustomerCompanyID = @custId;
	set @c = @@ROWCOUNT;
	return @count;
end
go

declare @p int = 102542, @c int = 0, @count int = 0
exec @count = PADVERTISING @custId = @p, @c = @c output
print '���������� ������ ����� = ' + cast(@count as varchar(5))
print '���������� ������ � ID �������� ' + cast(@p as varchar) + ' = ' + cast(@c as varchar(5))


-- ������� 3 ----------
go
alter PROCEDURE PADVERTISING @custId int
as
begin
	declare @count int = (select count(*) from �������);
	select * from ������� where CustomerCompanyID = @custId;
end
go

go
DROP TABLE if exists #ADVERTISING
go
CREATE TABLE #ADVERTISING(
	AdvertisingId int primary key,
	CustomerCompanyId int,
	ProgramId int,
	Date date,
	Duration time(7),
	AdvertisingType nvarchar(100)
)
go

insert #ADVERTISING exec PADVERTISING @custId = 102542

select * from #ADVERTISING

-- ������� 4 ----------

DROP PROCEDURE IF exists PADVERTISING_INSERT 
go
CREATE PROCEDURE PADVERTISING_INSERT @aId int, @custId int, @prId int, @d Date, @t time(7), @aType nvarchar(100)
as 
begin try
	insert into ������� values(@aId, @custId, @prId, @d, @t, @aType)
	return 1;
end try
begin catch
	print '��� ������ = ' + cast(error_number() as varchar(10));
	print '������� ����������� = ' + cast(error_severity() as varchar(10));
	print '���������: ' + error_message();
	return -1;
end catch

go

declare @rc int
exec @rc = PADVERTISING_INSERT @aId = 11, @custId = 102542, @prId = 1, @d = '2025-04-14', @t = '00:00:30', @aType = '������� ��������� ���������'

select * from �������

delete from ������� where AdvertisingID = 11

-- ������� 5 ----------

drop PROCEDURE if exists ADVERTISING_REPORT
go
CREATE PROCEDURE ADVERTISING_REPORT @custId int
as
begin try
	declare @buf varchar(500) = '', @curAd varchar(50) = '', @count int = 0
	declare adCursor CURSOR LOCAL for select AdvertisingType from ������� where CustomerCompanyID = @custId;
	if not exists(select AdvertisingType from ������� where CustomerCompanyID = @custId) raiserror('������ � ����������', 11, 1);
	else
		begin
			OPEN adCursor
			fetch adCursor into @curAd
			while @@FETCH_STATUS = 0
			begin
				set @buf = RTRIM(@curAd) + ', ' + @buf
				set @count += 1
				fetch adCursor into @curAd
			end
			set @buf = SUBSTRING(@buf, 1, len(@buf) - 1)
			print @buf
			close adCursor
			return @count
		end
end try
begin catch
	print '��������� ������: ' + error_message()
	return @count
end catch

go

declare @rc int, @custId int = 102542
exec @rc = ADVERTISING_REPORT @custId = @custId
print '���������� ������ �������� � id ' + cast(@custId as varchar(10)) + ' = ' + cast(@rc as varchar(10))


-- ������� 6 ----------

select * from [�����-��������]
go

drop PROCEDURE if exists PADVERTISING_INSERTX
go
CREATE PROCEDURE PADVERTISING_INSERTX @aId int, @custId int, @prId int, @d Date, @t time(7), @aType nvarchar(100), @custName nvarchar(100), @bankDet nvarchar(50), @contId int
as 
begin try
	declare @rc int = 1
	set transaction isolation level SERIALIZABLE
	begin tran
	insert into [�����-��������] values(@custId, @custName, @bankDet, @contId)
	exec @rc = PADVERTISING_INSERT @aId, @custId, @prId, @d, @t, @aType
	commit tran;
	return @rc;
end try
begin catch
	print '��� ������ = ' + cast(error_number() as varchar(10))
	print '���������2: ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
	return -1
end catch

go

declare @rc int
exec @rc = PADVERTISING_INSERTX @aId = 15, @custId = 102550, @prId = 2, @d = '2025-04-14', @t = '00:00:35', @aType = '������� ���', @custName = '�������', @bankDet= '2368593746', @contId = 2


select * from �������
select * from [�����-��������]

delete from ������� where AdvertisingID = 15
delete from [�����-��������] where CustomerCompanyID = 102550



-- ���.������� ----------
use UNIVER
go
DROP PROCEDURE if exists PRINT_REPORT
go
CREATE PROCEDURE PRINT_REPORT @f char(10), @p char(10)
as
begin try
	declare @buf varchar(100) = '', @curSub varchar(10), @countPulp int = 0
	if (@f is not null and @p is not null)
	begin
		if not exists(select * from FACULTY where FACULTY.FACULTY = @f)
		begin
			raiserror('������ ���������� ���', 11, 1)
			return 0
		end
		declare @count int = (select count(t.TEACHER) from FACULTY f Left join PULPIT p on f.FACULTY = p.FACULTY inner join TEACHER t on p.PULPIT = t.PULPIT where f.FACULTY = @f and p.PULPIT = @p group by f.FACULTY, p.PULPIT)
		if @count is null 
		begin
			raiserror('����� ������� ��� �� ������ ����������', 11, 1)
			return 0
		end
		declare curs CURSOR LOCAL for select s.SUBJECT from PULPIT p inner join SUBJECT s on s.PULPIT = p.PULPIT where p.PULPIT = @p
		OPEN curs
		fetch curs into @curSub
		while @@FETCH_STATUS = 0
		begin
			set @buf = RTRIM(@curSub) + ', ' + @buf;
			fetch curs into @curSub
		end
		print ' ���������: ' + @f;
		print '    �������: ' + @p;
		print '      ���������� ��������������: ' + cast(@count as varchar(5));
		if @buf = '' or @buf is null print '      ����������: ���.'
		else
		begin
			set @buf = SUBSTRING(@buf, 1, len(@buf) - 1) + '.'
			print '      ����������: ' + @buf
		end
		close curs
		return 1
	end
	else if (@f is not null and @p is null)
	begin
		if not exists(select * from FACULTY where FACULTY.FACULTY = @f)
		begin
			raiserror('������ ���������� ���', 11, 1)
			return 0
		end
		declare @facult char(10), @pulpit char(10), @count2 int = 0, @subj varchar(10), @count3 int
        declare curs CURSOR LOCAL for select f.FACULTY, p.PULPIT, s.SUBJECT, count(t.TEACHER) from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY left join SUBJECT s on p.PULPIT = s.PULPIT left join TEACHER t on t.PULPIT = s.PULPIT where f.FACULTY = @f group by f.FACULTY, p.PULPIT, s.SUBJECT order by f.FACULTY, p.PULPIT, s.SUBJECT
		OPEN curs
		fetch curs into @facult, @pulpit, @subj, @count2
		print ' ���������: ' + @f
		while @@FETCH_STATUS = 0
		begin
			declare @pulpit2 char(10) = @pulpit
			while @pulpit = @pulpit2
			begin
				set @buf = RTRIM(@subj) + ', ' + @buf;
				set @count3 = @count2
				fetch curs into @facult, @pulpit, @subj, @count2
				if @@FETCH_STATUS != 0 break;
			end
			print '    �������: ' + @pulpit2
			print '      ���������� ��������������: ' + cast(@count3 as varchar(5))
			if @buf = '' or @buf is null print '      ����������: ���.'
			else
			begin
				set @buf = SUBSTRING(@buf, 1, len(@buf) - 1) + '.'
				print '      ����������: ' + @buf
			end
			set @buf = ''
		end
		close curs
		return (select count(p.PULPIT) from PULPIT p where p.FACULTY = @f)
	end
	else if (@f is null and @p is not null)
	begin
		if not exists(select * from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY where p.PULPIT = @p) raiserror('����� ������� ��� �� �� ����� ����������', 11, 1)
		else
		begin
			set @f = (select f.FACULTY from FACULTY f inner join PULPIT p on p.FACULTY = f.FACULTY where p.PULPIT = @p)
			declare @count4 int = (select count(t.TEACHER) from FACULTY f Left join PULPIT p on f.FACULTY = p.FACULTY inner join TEACHER t on p.PULPIT = t.PULPIT where f.FACULTY = @f and p.PULPIT = @p group by f.FACULTY, p.PULPIT)
			declare curs CURSOR LOCAL for select s.SUBJECT from PULPIT p inner join SUBJECT s on s.PULPIT = p.PULPIT where p.PULPIT = @p
			OPEN curs
			fetch curs into @curSub
			while @@FETCH_STATUS = 0
			begin
				set @buf = RTRIM(@curSub) + ', ' + @buf;
				fetch curs into @curSub
			end
			print ' ���������: ' + @f;
			print '    �������: ' + @p;
			print '      ���������� ��������������: ' + cast(@count4 as varchar(5));
			if @buf = '' or @buf is null print '      ����������: ���.'
			else
			begin
				set @buf = SUBSTRING(@buf, 1, len(@buf) - 1) + '.'
				print '      ����������: ' + @buf
			end
			close curs
			return 1
		end
	end
end try
begin catch
	print '������: ' + error_message()
	return 0
end catch

go

declare @countP int
exec @countP = PRINT_REPORT @f = '��', @p = '����'
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = '��', @p = '���'
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = '�', @p = '���'
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = '��', @p = null
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = '�', @p = null
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = null, @p = '����'
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go

declare @countP int
exec @countP = PRINT_REPORT @f = null, @p = '���'
print '���������� ������ � ������ = ' + cast(@countP as varchar(5))
go
