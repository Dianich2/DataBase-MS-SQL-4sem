use Pod_MyBase;
go

-- ������� 1 ----------
DROP TABLE IF EXISTS TR_CHECK
go
CREATE TABLE TR_CHECK(
	ID int identity,
	STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
	TRNAME varchar(50),
	CC nvarchar(300)
)
go

select * from [����������_����]

DROP TRIGGER IF EXISTS TR_CUSTOMER_INS
go
CREATE TRIGGER TR_CUSTOMER_INS on [����������_����] after INSERT
as
declare @conId int, @tel nvarchar(18), @fullName nvarchar(100), @cc nvarchar(300)
set @conId = (select ContactPersonID from inserted)
set @tel = (select Telephone from inserted)
set @fullName = (select ContactPersonFullName from inserted)
set @cc = rtrim(cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName)
insert into TR_CHECK values('INS', 'TR_CUSTOMER_INS', @cc)
return

insert into ����������_���� values(15, '+375295743119', '������ ���� ��������')

select * from TR_CHECK

-- ������� 2 ----------

DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL
go
CREATE TRIGGER TR_CUSTOMER_DEL on [����������_����] after DELETE
as
declare @conId int, @tel nvarchar(18), @fullName nvarchar(100), @cc nvarchar(300)
set @conId = (select ContactPersonID from deleted)
set @tel = (select Telephone from deleted)
set @fullName = (select ContactPersonFullName from deleted)
set @cc = rtrim(cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName)
insert into TR_CHECK values('DEL', 'TR_CUSTOMER_DEL', @cc)
return

delete from ����������_���� where ContactPersonID = 15

select * from TR_CHECK

-- ������� 3 ----------

DROP TRIGGER IF EXISTS TR_CUSTOMER_UPD
go
CREATE TRIGGER TR_CUSTOMER_UPD on [����������_����] after UPDATE
as
declare @conId int, @tel nvarchar(18), @fullName nvarchar(100), @cc nvarchar(300),
@conIdNew int, @telNew nvarchar(18), @fullNameNew nvarchar(100)
set @conId = (select ContactPersonID from deleted)
set @tel = (select Telephone from deleted)
set @fullName = (select ContactPersonFullName from deleted)
set @conIdNew = (select ContactPersonID from inserted)
set @telNew = (select Telephone from inserted)
set @fullNameNew = (select ContactPersonFullName from inserted)
set @cc = rtrim('��: ' + cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName + '  �����: ' + cast(@conIdNew as varchar(3)) + ', ' + @telNew + ', ' + @fullNameNew)
insert into TR_CHECK values('UPD', 'TR_CUSTOMER_UPD', @cc)
return

update ����������_���� set ContactPersonFullName = 'TEST' where ContactPersonID = 15

select * from TR_CHECK

delete from TR_CHECK

-- ������� 4 ----------

DROP TRIGGER IF EXISTS TR_CUSTOMER
go
CREATE TRIGGER TR_CUSTOMER on [����������_����] after INSERT, DELETE, UPDATE 
as
declare @insert_count int = (select count(*) from inserted)
declare @delete_count int = (select count(*) from deleted)
declare @conId int, @tel nvarchar(18), @fullName nvarchar(100), @cc nvarchar(300),
@conIdNew int, @telNew nvarchar(18), @fullNameNew nvarchar(100)
if @insert_count > 0 and @delete_count = 0
begin
	set @conId = (select ContactPersonID from inserted)
	set @tel = (select Telephone from inserted)
	set @fullName = (select ContactPersonFullName from inserted)
	set @cc = rtrim(cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName)
	insert into TR_CHECK values('INS', 'TR_CUSTOMER', @cc)
end
else if @insert_count = 0 and @delete_count > 0
begin
	set @conId = (select ContactPersonID from deleted)
	set @tel = (select Telephone from deleted)
	set @fullName = (select ContactPersonFullName from deleted)
	set @cc = rtrim(cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName)
	insert into TR_CHECK values('DEL', 'TR_CUSTOMER', @cc)
end
else
begin
	set @conId = (select ContactPersonID from deleted)
	set @tel = (select Telephone from deleted)
	set @fullName = (select ContactPersonFullName from deleted)
	set @conIdNew = (select ContactPersonID from inserted)
	set @telNew = (select Telephone from inserted)
	set @fullNameNew = (select ContactPersonFullName from inserted)
	set @cc = rtrim('��: ' + cast(@conId as varchar(3)) + ', ' + @tel + ', ' + @fullName + '  �����: ' + cast(@conIdNew as varchar(3)) + ', ' + @telNew + ', ' + @fullNameNew)
	insert into TR_CHECK values('UPD', 'TR_CUSTOMER', @cc)
end
return
go

insert into ����������_���� values(15, '+375295743119', '������ ���� ��������')

update ����������_���� set ContactPersonFullName = 'TEST' where ContactPersonID = 15

delete from ����������_���� where ContactPersonID = 15

select * from TR_CHECK

-- ������� 5 ----------

select * from ����������_����

insert into ����������_����(Telephone, ContactPersonFullName)
values('+375294567830', 'error')

-- ������� 6 ----------

DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL1
go
CREATE TRIGGER TR_CUSTOMER_DEL1 on [����������_����] after DELETE
as
print 'TR_CUSTOMER_DEL1'
return

DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL2
go
CREATE TRIGGER TR_CUSTOMER_DEL2 on [����������_����] after DELETE
as
print 'TR_CUSTOMER_DEL2'
return

DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL3
go
CREATE TRIGGER TR_CUSTOMER_DEL3 on [����������_����] after DELETE
as
print 'TR_CUSTOMER_DEL3'
return

select t.name from sys.triggers t inner join sys.trigger_events tr_e
on t.object_id = tr_e.object_id where OBJECT_NAME(t.parent_id) = '����������_����'
and tr_e.type_desc = 'DELETE'

go
DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL
go
DROP TRIGGER IF EXISTS TR_CUSTOMER
go

exec sp_settriggerorder @triggername = 'TR_CUSTOMER_DEL3',
	@order = 'First', @stmttype = 'DELETE'

exec sp_settriggerorder @triggername = 'TR_CUSTOMER_DEL2',
	@order = 'Last', @stmttype = 'DELETE'

insert into ����������_���� values(15, '+375295743119', '������ ���� ��������')

delete from ����������_���� where ContactPersonID = 15


-- ������� 7 ----------

DROP TRIGGER IF EXISTS TR_CUSTOMER_CHECK
go
CREATE TRIGGER TR_CUSTOMER_CHECK on [����������_����] after insert
as
declare @largeIdCount int = (select count(*) from ����������_���� where ContactPersonID > 100)
if @largeIdCount != 0
begin
	raiserror('Id �� ������ ��������� 100', 10, 1)
	rollback
end
return

insert into ����������_���� values(102, '+375295743119', '������ ���� ��������')

select * from ����������_����

-- ������� 8 ----------

DROP TRIGGER IF EXISTS TR_CONTACT
go
CREATE TRIGGER TR_CONTACT on [����������_����] instead of DELETE
as
raiserror('������ ������� ������ � ������� ����������_����', 10, 1)
return

delete from ����������_���� 


DROP TRIGGER IF EXISTS TR_CONTACT_INS
go
CREATE TRIGGER TR_CONTACT_INS on ����������_���� instead of INSERT
as
print '�������� ����������� �����������'
return

insert into ����������_����(Telephone, ContactPersonFullName) values('+375295743119', '������ ���� ��������')

select * from ����������_����



DROP TRIGGER IF EXISTS TR_CUSTOMER_INS
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_UPD
go
DROP TRIGGER IF EXISTS TR_CUSTOMER
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL1
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL2
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_DEL3
go
DROP TRIGGER IF EXISTS TR_CUSTOMER_CHECK
go
DROP TRIGGER IF EXISTS TR_CONTACT
go
DROP TRIGGER IF EXISTS TR_CONTACT_INS
go

select * from sys.triggers

-- ������� 9 ----------

DROP TRIGGER IF EXISTS DDL_POD
go
CREATE TRIGGER DDL_POD on database for CREATE_TABLE, DROP_TABLE
as
declare @et varchar(max) = EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @on varchar(max) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @ot varchar(max) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)');
print '��� �������: '+@et;
print '��� �������: '+@on;
print '��� �������: '+@ot;
raiserror( N'�������� �������� � �������� ������ � �� Pod_MyBase ���������', 16, 1);  
rollback;  
return

CREATE TABLE TEST2(ID int primary key)

DROP TABLE TEST


-- ��� ������� ----------

DROP TABLE IF EXISTS WEATHER
go
CREATE TABLE WEATHER(
	City varchar(30),
	Start_date date,
	End_date date,
	Temperature decimal
)
go

DROP TRIGGER IF EXISTS TR_CHECK_WEATHER
go
CREATE TRIGGER TR_CHECK_WEATHER on WEATHER after INSERT, UPDATE
as
declare @start_date date = (select Start_date from inserted)
declare @end_date date = (select End_date from inserted)
if @start_date > @end_date
begin
	raiserror('������, ����� ���� ������ ���� ����� ���� �����', 10, 1)
	rollback
end
declare @city varchar(30) = (select City from inserted)
declare @count int = (select count(*) from (select * from WEATHER w where 
((w.Start_date >= @start_date and w.Start_date <= @end_date) or
(w.End_date >= @start_date and w.End_date <= @end_date) or
(w.Start_date <= @start_date and w.End_date >= @end_date)) and (@city = w.City and w.Start_date != @start_date and w.End_date != @end_date)) as T)
if @count > 0
begin
	raiserror('������, ����� ���� ������������', 10, 1)
	rollback
end
return

select * from WEATHER

delete from WEATHER

-- ���� ������ ����� ���� �����
insert into WEATHER values('�����', '2025-04-21', '2025-04-20', 5)

-- �Ѩ ������
insert into WEATHER values('�����', '2025-04-20', '2025-04-25', 5)

-- ���� �������� � ����������, ������� ��� ����������
insert into WEATHER values('�����', '2025-04-22', '2025-04-26', 5)

-- ���� �������� � ����������, ������� ��� ����������
insert into WEATHER values('�����', '2025-04-18', '2025-04-22', 5)

-- ���� �������� � ����������, ������� ��� ����������
insert into WEATHER values('�����', '2025-04-18', '2025-04-26', 5)

-- ���� �������� � ����������, ������� ��� ����������
insert into WEATHER values('�����', '2025-04-22', '2025-04-24', 5)

-- �Ѩ ������, ������ ��� ������ �����
insert into WEATHER values('�����', '2025-04-22', '2025-04-24', 5)

-- �Ѩ ������, ������ ���� �� ������������
insert into WEATHER values('�����', '2025-04-25', '2025-04-26', 5)

-- ���������� ���� �������� � ����������� ���
update WEATHER set Start_date = '2025-04-23' where City = '�����' and Start_date = '2025-04-25'

-- ���������� ���� �������� � ����, ��� ���� ������ ���������� ����� ���� �����
update WEATHER set Start_date = '2025-04-27' where City = '�����' and Start_date = '2025-04-25'

-- �Ѩ ������, ������ ��� ���������� ���� ����������
update WEATHER set Start_date = '2025-04-26' where City = '�����' and Start_date = '2025-04-25'

select * from WEATHER

delete from WEATHER