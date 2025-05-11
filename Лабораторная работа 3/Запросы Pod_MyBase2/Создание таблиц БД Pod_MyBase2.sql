use Pod_MyBase2;
create table ÏÅĞÅÄÀ×È(
ProgramID int primary key,
ProgramName nvarchar(100) not null default 'Íîâîñòè',
Rating real not null,
MinuteConst real not null) on FG1;

create table ÊÎÍÒÀÊÒÍÛÅ_ËÈÖÀ(
ContactPersonID int primary key,
Telephone nvarchar(15) not null default '+3752926849302',
ContactPersonFullName nvarchar(100) not null) on FG1;

create table ÔÈĞÌÀ_ÇÀÊÀÇ×ÈÊ(
CustomerCompanyID int primary key,
CustomerCompanyName nvarchar(100) not null,
BankDetails nvarchar(20) not null,
ContactPersonID int not null foreign key references ÊÎÍÒÀÊÒÍÛÅ_ËÈÖÀ(ContactPersonID)) on FG1;

create table ĞÅÊËÀÌÛ(
AdvertisingID int primary key,
AdvertisingType nvarchar(100) not null,
CustomerCompanyID int not null foreign key references ÔÈĞÌÀ_ÇÀÊÀÇ×ÈÊ(CustomerCompanyID),
ProgramID int not null foreign key references ÏÅĞÅÄÀ×È(ProgramID),
Date date not null,
Duration time(7) not null default '00:00:30') on FG1;