use Pod_MyBase

-- ������� 2

select * from [�����-��������]

-- ���������� ����������� �������
begin try
	begin tran
		insert into [�����-��������] values(102548, 'Carwel', 2383459321, 3);
		Update [�����-��������] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
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

select * from [�����-��������]

delete from [�����-��������] where CustomerCompanyName = 'Carwel';
Update [�����-��������] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;


-- ������ ��� ��������
begin try
	begin tran
		insert into [�����-��������] values(102548, 'Carwel', 2383459321, 3);
		delete from [�����-��������] where CustomerCompanyName = '���������'
		Update [�����-��������] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
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

select * from [�����-��������]


-- ������ ��� �������
begin try
	begin tran
		Update [�����-��������] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		insert into [�����-��������] values(102544, 'Carwel', 2383459321, 3);
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

select * from [�����-��������]


-- ������� 3

declare @control_point varchar(32)
begin try
	begin tran
		Update [�����-��������] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		set @control_point = 'p1'; save tran @control_point;
		insert into [�����-��������] values(102544, 'Carwel', 2383459321, 3);
		commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 then '��������� ������������ �����'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print '����������� � ����������� �����: ' + @control_point;
		rollback tran @control_point;
		commit tran;
	end
end catch;
go

select * from [�����-��������]

Update [�����-��������] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;




declare @control_point varchar(32), @control_point2 varchar(32)
begin try
	begin tran
		Update [�����-��������] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		set @control_point = 'p1'; save tran @control_point;
		Update [�����-��������] set CustomerCompanyName = 'new2' where CustomerCompanyID = 102544;
		set @control_point2 = 'p2'; save tran @control_point2;
		delete from [�����-��������] where CustomerCompanyName = '���������'
		commit tran;
end try
begin catch
	print '������: ' + case
	when error_number() = 2627 then '��������� ������������ �����'
	else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print '����������� � ����������� �����: ' + @control_point2;
		rollback tran @control_point2;
		commit tran;
	end
end catch;
go

select * from [�����-��������]

Update [�����-��������] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;

Update [�����-��������] set CustomerCompanyName = 'MANNOL' where CustomerCompanyID = 102544;


-- ������� 4

select * from �������

-- ������� ������

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������

-- ��������������� ������

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	insert into ������� values(2, '102542', 5, '2025-02-20', '00:00:44', '������� ����������')


-- ��������� ������

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	delete from ������� where AdvertisingID = 7

-- ������� 5

	select * from �������

-- ������� ������ �� �����������

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������

-- ��������������� ������

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	insert into ������� values(2, '102542', 5, '2025-02-20', '00:00:44', '������� ����������')


-- ��������� ������

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	delete from ������� where AdvertisingID = 7



-- ������� 6

	select * from �������

-- ������� ������ �� �����������

-- A ---
	set tran isolation level REPEATABLE READ 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������

-- ��������������� ������ �� �����������

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	insert into ������� values(2, '102542', 5, '2025-02-20', '00:00:44', '������� ����������')


-- ��������� ������

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	delete from ������� where AdvertisingID = 7



-- ������� 7

	select * from �������

-- ������� ������ �� �����������

-- A ---
	set tran isolation level SERIALIZABLE 
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������

-- ��������������� ������ �� �����������

-- A ---
	set tran isolation level SERIALIZABLE  
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	insert into ������� values(2, '102542', 5, '2025-02-20', '00:00:44', '������� ����������')


-- ��������� ������ �� �����������

-- A ---
	set tran isolation level SERIALIZABLE  
	begin tran 
	select count(*) from ������� where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from ������� where CustomerCompanyID = '102542'
	commit tran;

	select * from �������
	delete from ������� where AdvertisingID = 7


-- ������� 8

select * from [�����-��������]

begin tran
	insert into [�����-��������] values(102570, 'TEST', 1029684921, 5);
	begin tran
		update [�����-��������] set ContactPersonID = 7 where CustomerCompanyID = 102542;
		commit
	if @@TRANCOUNT > 0 rollback;

select * from [�����-��������]