use UNIVER;
go
-- ������� 1 ----------

Drop FUNCTION if EXISTS COUNT_STUDENTS
go
CREATE FUNCTION COUNT_STUDENTS(@faculty varchar(20)) returns int
as 
begin
	declare @count int = (select count(*) from FACULTY f inner join GROUPS g on g.FACULTY = f.FACULTY inner join STUDENT s on s.IDGROUP = g.IDGROUP where f.FACULTY = @faculty)
	return @count;
end
go

declare @faculty varchar(20) = '����'
declare @count int = dbo.Count_Students(@faculty)
print '���������� ��������� �� ���������� ' + @faculty + ' = ' + cast(@count as varchar(10))
go


Alter FUNCTION COUNT_STUDENTS(@faculty varchar(20), @prof varchar(20)) returns int
as 
begin
	declare @count int = (select count(*) from FACULTY f inner join GROUPS g on g.FACULTY = f.FACULTY inner join STUDENT s on s.IDGROUP = g.IDGROUP where f.FACULTY = @faculty and g.PROFESSION = @prof)
	return @count;
end
go

declare @faculty varchar(20) = '����', @prof varchar(20) = '1-47 01 01'
declare @count int = dbo.Count_Students(@faculty, @prof)
print '���������� ��������� �� ���������� ' + @faculty + ', ����������� �� ������������� � ����� ' + @prof + ' = ' + cast(@count as varchar(10))
select distinct f.FACULTY, g.PROFESSION, dbo.COUNT_STUDENTS(f.FACULTY, g.PROFESSION) as Counts from FACULTY f inner join GROUPS g on g.FACULTY = f.FACULTY
go

-- ������� 2 ----------

DROP FUNCTION IF EXISTS FSUBJECTS
go
CREATE FUNCTION FSUBJECTS(@p varchar(20)) returns varchar(300)
as 
begin
	declare @subjects varchar(300) = '', @buf varchar(20)
	declare curs CURSOR LOCAL STATIC for select s.SUBJECT from SUBJECT s where s.PULPIT = @p
	OPEN curs
		fetch curs into @buf
		while @@FETCH_STATUS = 0
		begin
			set @subjects = RTRIM(@buf) + ', ' + @subjects
			fetch curs into @buf
		end
		if (@subjects is null or @subjects = '') set @subjects = '����������.'
		else
		begin
			set @subjects = '����������: ' + substring(@subjects, 1, len(@subjects) - 1)
		end
	Close curs
	return @subjects;
end
go

select p.PULPIT, dbo.FSUBJECTS(p.PULPIT) as Subjects from PULPIT p;
go

-- ������� 3 ----------

DROP FUNCTION IF EXISTS FFACPUL
go
CREATE FUNCTION FFACPUL(@faculty varchar(20), @pulpit varchar(20)) returns table
as return
select f.FACULTY, p.PULPIT from Faculty f left outer join PULPIT p on f.FACULTY = p.FACULTY 
where f.FACULTY = isnull(@faculty, f.FACULTY) and p.PULPIT = isnull(@pulpit, p.PULPIT)
go

select * from dbo.FFACPUL(null, null)
select * from dbo.FFACPUL('��', null)
select * from dbo.FFACPUL(null, '�����')
select * from dbo.FFACPUL('����', '�����')
select * from dbo.FFACPUL('����', '����')
go

-- ������� 4 ----------

DROP FUNCTION IF EXISTS FCTEACHER
go
CREATE FUNCTION FCTEACHER(@pulpit varchar(20)) returns int
as
begin
	declare @count int = (select count(*) from TEACHER t where t.PULPIT = isnull(@pulpit, t.PULPIT))
	return @count
end
go

select p.PULPIT, dbo.FCTEACHER(p.PULPIT) as [���������� ��������������] from PULPIT p

select dbo.FCTEACHER(NULL)[����� ��������������]
go
-- ������� 6 ----------


-- ������� �������� ���������� ���������
Alter FUNCTION COUNT_STUDENTS(@faculty varchar(20), @prof varchar(20)) returns int
as 
begin
	declare @count int = (select count(*) from FACULTY f inner join GROUPS g on g.FACULTY = f.FACULTY inner join STUDENT s on s.IDGROUP = g.IDGROUP where f.FACULTY = @faculty and g.PROFESSION = isnull(@prof, g.PROFESSION))
	return @count;
end
go

-- ������� ��� �������� ���������� ������
DROP FUNCTION IF EXISTS COUNT_PULPITS
go
CREATE FUNCTION COUNT_PULPITS(@faculty varchar(20)) returns int
as
begin
	declare @count int = (select count(p.PULPIT) from PULPIT p where p.FACULTY = @faculty)
	return @count
end
go

-- ������� ��� �������� ���������� �����
DROP FUNCTION IF EXISTS COUNT_GROUPS
go
CREATE FUNCTION COUNT_GROUPS(@faculty varchar(20)) returns int
as
begin
	declare @count int = (select count(g.IDGROUP) from GROUPS g where g.FACULTY = @faculty)
	return @count
end
go

-- ������� ��� �������� ���������� ��������������
DROP FUNCTION IF EXISTS COUNT_SPEC
go
CREATE FUNCTION COUNT_SPEC(@faculty varchar(20)) returns int
as
begin
	declare @count int = (select count(p.PROFESSION) from PROFESSION p where p.FACULTY = @faculty)
	return @count
end
go

-- ������� ������������ ������
DROP FUNCTION IF EXISTS FACULTY_REPORT
go
CREATE FUNCTION FACULTY_REPORT(@c int) returns @fr table
([���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
[���������� ���������] int, [���������� ��������������] int )
as 
begin 
declare cc CURSOR static for 
	       select f.FACULTY from FACULTY f where dbo.COUNT_STUDENTS(FACULTY, null) > @c
	       declare @f varchar(30)
	       open cc
		   fetch cc into @f
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  dbo.COUNT_PULPITS(@f),
	            dbo.COUNT_GROUPS(@f),   dbo.COUNT_STUDENTS(@f, null),
	            dbo.COUNT_SPEC(@f)); 
	            fetch cc into @f 
	       end  
		   close cc
        return
	end
go

select * from dbo.FACULTY_REPORT(0)


-- ��� ������� ----------

-- ���������
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




-- �������

DROP FUNCTION if exists PRINT_REPORTX
go
CREATE FUNCTION PRINT_REPORTX(@f varchar(20), @p varchar(20)) returns nvarchar(max)
as
begin
	declare @curFaculty varchar(20), @curPulpit varchar(20), @res varchar(max) = ''
	if @f is not null
	begin
		if not exists(select * from FACULTY f where f.FACULTY = @f)
		begin
			return (@res + '������ ���������� ���' + char(10) + '���������� ������ � ������ = 0') 
		end
	end
	if @f is not null and @p is not null
	begin
		declare @count int = (select count(*) from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY where f.FACULTY = @f and p.PULPIT = @p)
		if @count = 0 
		begin
			return (@res + '����� ������� ��� �� ������ ����������' + char(10) + '���������� ������ � ������ = 0')
		end
	end
	if @f is null and @p is not null
	begin
		declare @count2 int = (select count(*) from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY where p.PULPIT = @p)
		if @count2 = 0 
		begin
			return (@res + '����� ������� ��� �� �� ����� �� �����������' + char(10) + '���������� ������ � ������ = ')
		end
	end
	declare curs CURSOR LOCAL for select * from dbo.FFACPUL(@f, @p)
	declare @bufFaculty varchar(20), @bufPulpit varchar(20), @amount int = 0
	OPEN curs
	fetch curs into @curFaculty, @curPulpit
	while @@FETCH_STATUS = 0
	begin
		set @bufFaculty = @curFaculty
		set @bufPulpit = @curPulpit
		set @res = @res + ' ���������: ' + @bufFaculty + Char(10)
		while @bufFaculty = @curFaculty
		begin
			set @bufPulpit = @curPulpit
			set @res = @res + '    �������: ' + @bufPulpit + char(10)
			declare @count3 int = dbo.FCTEACHER(@bufPulpit)
			set @res = @res +  '      ���������� ��������������: ' + cast(@count3 as varchar(20)) + char(10)
			set @res = @res + '     ' + rtrim(dbo.FSUBJECTS(@bufPulpit)) + char(10)
			set @amount += 1
			fetch curs into @curFaculty, @curPulpit
			if @@FETCH_STATUS != 0 break
		end
	end
	return @res + '���������� ������ � ������ = ' + cast(@amount as varchar(20)) 
end
go

declare @f varchar(20) = '��', @p varchar(20) = '����'
print dbo.PRINT_REPORTX(@f, @p) 
go

declare @f varchar(20) = '��', @p varchar(20) = '���'
print dbo.PRINT_REPORTX(@f, @p) 
go

declare @f varchar(20) = '�', @p varchar(20) = '���'
print dbo.PRINT_REPORTX(@f, @p)
go

declare @f varchar(20) = '��', @p varchar(20) = null
print dbo.PRINT_REPORTX(@f, @p)
go

declare @f varchar(20) = '�', @p varchar(20) = null
print dbo.PRINT_REPORTX(@f, @p)
go

declare @f varchar(20) = null , @p varchar(20) = '����'
print dbo.PRINT_REPORTX(@f, @p)
go

declare @f varchar(20) = null , @p varchar(20) = '���'
print dbo.PRINT_REPORTX(@f, @p)
go
