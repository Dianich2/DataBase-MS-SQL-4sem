-- ������� 1
Drop Table if exists NewT 
set implicit_transactions on
declare @i int, @flag char = 't'
Create table NewT(Key_ int primary key, Word varchar(10));
insert into NewT(Key_ , Word)
values(1, 'one'),
	  (2, 'two'),
	  (3, 'three'),
	  (4, 'four'),
	  (5, 'five')
if @flag = 'c' commit;
else rollback;
Set implicit_transactions off
go

-- ������� 2
use UNIVER;

select * from STUDENT

-- ���������� ����������� �������
begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, '������ ���� ��������', '2006-05-20');
		delete from STUDENT where NAME = '��������� ����� ��������';
		Update STUDENT set IDGROUP = 19 where IDSTUDENT = 1079;
		commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 then '��������� ������������ �����'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from STUDENT

delete from STUDENT where Name = '������ ���� ��������';
insert into STUDENT(IDGROUP, NAME, BDAY) values(18, '��������� ����� ��������', '1995-08-05');
Update STUDENT set IDGROUP = 18 where IDSTUDENT = 1079;






-- ���������� �� ����������� ��-�� ������� � �������, ������� ���������������� � �������� ���������������
select * from STUDENT

begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, '������ ���� ��������', '2006-05-20');
		insert into STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY) values(1000, 19, '������ ���� ��������', '2006-05-20');
		commit tran;
end try
begin catch
	print '������: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + '��������� ������������ �����'
	else CHAR(9) + '����������� ������: ��� - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from STUDENT






-- ���������� �� ����������� ��-�� �������� ���������� ����
select * from PROGRESS

begin try
	begin tran
		insert into PROGRESS values('����', 1070, '2013-01-11', 5);
		delete from STUDENT where Name = '������� ����� ��������';
		commit tran;
end try
begin catch
	print '������: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + '��������� ������������ �����'
	else CHAR(9) + '����������� ������: ��� - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from PROGRESS




-- ������� 3


-- ������ �� �������, �� ����������� � ����������� �����
select * from STUDENT

declare @control_point varchar(32)
begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, '������ ���� ��������', '2006-05-20');
		set @control_point = 'p1'; save tran @control_point;
		insert into STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY) values(1000, 19, '������ ���� ��������', '2006-05-20');
		commit tran;
end try
begin catch
	print '������: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + '��������� ������������ �����'
	else CHAR(9) + '����������� ������: ��� - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print '����������� � ����������� �����: ' + @control_point;
		rollback tran @control_point;
		commit tran;
	end
end catch;
go

select * from STUDENT

delete from STUDENT where Name = '������ ���� ��������';


-- ������ � �������� ������, �� ����������� � ����������� �����

select * from PROGRESS

declare @control_point varchar(32), @control_point2 varchar(32)
begin try
	begin tran
		insert into PROGRESS values('����', 1070, '2013-01-11', 5);
		set @control_point = 'p1'; save tran @control_point;
		insert into PROGRESS values('����', 1070, '2013-01-19', 7);
		set @control_point2 = 'p2'; save tran @control_point2;
		delete from STUDENT where Name = '������� ����� ��������';
		commit tran;
end try
begin catch
	print '������: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + '��������� ������������ �����'
	else CHAR(9) + '����������� ������: ��� - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print '����������� � ����������� �����: ' + @control_point2; -- ����� �������� �� p2
		rollback tran @control_point2; -- ����� �������� �� p2
		commit tran;
	end
end catch;
go

select * from PROGRESS

delete from PROGRESS where IDSTUDENT = 1070 and SUBJECT = '����'
delete from PROGRESS where IDSTUDENT = 1070 and SUBJECT = '����'


-- ������� 4

use UNIVER;
select * from PROGRESS

-- ������� ������

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ��������������� ������

	select * from PROGRESS
-- A ---
    set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('����', 1001, '2013-01-10', 6)

-- ��������� ������

-- A ---
    set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = '��' and IDSTUDENT = 1001


-- ������� 5

-- ������� ������ �� �����������

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ��������������� ������

	select * from PROGRESS
-- A ---
    set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('����', 1001, '2013-01-10', 6)

-- ��������� ������

-- A ---
    set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = '��' and IDSTUDENT = 1001

-- ������� 6

-- ������� ������ �� �����������

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ��������������� ������ �� �����������

	select * from PROGRESS
-- A ---
    set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('����', 1001, '2013-01-10', 6)

-- ��������� ������

-- A ---
    set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = '��' and IDSTUDENT = 1001

-- ������� 7

-- A ---

-- ������� ������ �� �����������
	set tran isolation level SERIALIZABLE  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ��������������� ������ �� �����������

	select * from PROGRESS
-- A ---
    set tran isolation level SERIALIZABLE  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('����', 1001, '2013-01-10', 6)

-- ��������� ������ �� �����������

-- A ---
    set tran isolation level SERIALIZABLE    
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = '��' and IDSTUDENT = 1001

-- ������� 8

select * from PROGRESS

begin tran
	insert into PROGRESS values('��', 1071, '2025-01-15', 9)
	begin tran
		update PROGRESS set SUBJECT = '���' where IDSTUDENT = 1070
		commit
	if @@TRANCOUNT > 0 rollback;

select * from PROGRESS