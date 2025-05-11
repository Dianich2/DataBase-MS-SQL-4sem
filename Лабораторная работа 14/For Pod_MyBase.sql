use Pod_MyBase;
go

DROP FUNCTION IF EXISTS COUNT_ADVERTISINGS
go
CREATE FUNCTION COUNT_ADVERTISINGS(@custId int) returns int
as
begin
	declare @count int = (select count(*) from РЕКЛАМЫ r where r.CustomerCompanyID = @custId)
	return @count
end
go

declare @custId int = 102542
declare @count int = dbo.COUNT_ADVERTISINGS(@custId);
print 'Количество заказанных реклам у компании с id = ' + cast(@custId as varchar(10)) + ' = ' + cast(@count as varchar(10))
go

Alter FUNCTION COUNT_ADVERTISINGS(@custId int, @programId int) returns int
as
begin
	declare @count int = (select count(*) from РЕКЛАМЫ r where r.CustomerCompanyID = @custId and r.ProgramId = @programId)
	return @count
end
go

select distinct r.CustomerCompanyID, r.ProgramId, dbo.COUNT_ADVERTISINGS(r.CustomerCompanyID, r.ProgramId) from РЕКЛАМЫ r
go

-- ЗАДАНИЕ 2 ----------

DROP FUNCTION IF EXISTS FADVERTISING_TYPES
go
CREATE FUNCTION FADVERTISING_TYPES(@custId int) returns varchar(300)
as
begin
	declare @types varchar(300) = '', @buf varchar(50)
	declare curs CURSOR LOCAL STATIC for select r.AdvertisingType from РЕКЛАМЫ r where r.CustomerCompanyID = @custId
	OPEN curs
		fetch curs into @buf
		while @@FETCH_STATUS = 0
		begin
			set @types = rtrim(@buf) + ', ' + @types
			fetch curs into @buf
		end
		if (@types is null or @types = '') set @types = 'Типы реклам.'
		else
		begin
			set @types = 'Типы реклам: ' + substring(@types, 1, len(@types) - 1)
		end
	CLOSE curs
	return @types
end
go

select distinct r.CustomerCompanyID, dbo.FADVERTISING_TYPES(r.CustomerCompanyID) from РЕКЛАМЫ r
go

-- ЗАДАНИЕ 3 ----------

DROP FUNCTION IF EXISTS FCUSTPROG
go
CREATE FUNCTION FCUSTPROG(@custId int, @progId int) returns table
as return
select f.CustomerCompanyID, r.ProgramId from [Фирма-заказчик] f left outer join РЕКЛАМЫ r on f.CustomerCompanyID = r.CustomerCompanyID where f.CustomerCompanyID = isnull(@custId, f.CustomerCompanyID) and r.ProgramId = isnull(@progId, r.ProgramId)
go

select * from dbo.FCUSTPROG(null, null)
select * from dbo.FCUSTPROG(102542, null)
select * from dbo.FCUSTPROG(null, 5)
select * from dbo.FCUSTPROG(102542, 5)
select * from dbo.FCUSTPROG(102544, 5)
go

-- ЗАДАНИЕ 4 ----------

DROP FUNCTION IF EXISTS FCADVERTISING
go
CREATE FUNCTION FCADVERTISING(@custId int) returns int
as
begin
	declare @count int = (select count(*) from РЕКЛАМЫ r where r.CustomerCompanyID = isnull(@custId, r.CustomerCompanyID))
	return @count
end
go

select distinct r.CustomerCompanyID, dbo.FCADVERTISING(r.CustomerCompanyID) as [Количество реклам] from РЕКЛАМЫ r

select dbo.FCADVERTISING(null)[Всего реклам]


