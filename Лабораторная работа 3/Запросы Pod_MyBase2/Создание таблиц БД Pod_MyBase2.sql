use Pod_MyBase2;
create table ��������(
ProgramID int primary key,
ProgramName nvarchar(100) not null default '�������',
Rating real not null,
MinuteConst real not null) on FG1;

create table ����������_����(
ContactPersonID int primary key,
Telephone nvarchar(15) not null default '+3752926849302',
ContactPersonFullName nvarchar(100) not null) on FG1;

create table �����_��������(
CustomerCompanyID int primary key,
CustomerCompanyName nvarchar(100) not null,
BankDetails nvarchar(20) not null,
ContactPersonID int not null foreign key references ����������_����(ContactPersonID)) on FG1;

create table �������(
AdvertisingID int primary key,
AdvertisingType nvarchar(100) not null,
CustomerCompanyID int not null foreign key references �����_��������(CustomerCompanyID),
ProgramID int not null foreign key references ��������(ProgramID),
Date date not null,
Duration time(7) not null default '00:00:30') on FG1;