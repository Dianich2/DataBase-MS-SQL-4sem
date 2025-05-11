drop view йнкхвеярбн_йютедп;
go
Create View [йнкхвеярбн_йютедп] as
select f.FACULTY as тюйскэрер, COUNT(*) as йнкхвеярбн_йютедп from UNIVER.dbo.FACULTY f inner join UNIVER.dbo.PULPIT p on f.FACULTY = p.FACULTY
group by f.FACULTY;
go
select * from dbo.йнкхвеярбн_йютедп;
