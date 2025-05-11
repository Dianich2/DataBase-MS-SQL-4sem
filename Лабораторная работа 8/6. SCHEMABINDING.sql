ALTER VIEW [йнкхвеярбн_йютедп] with SCHEMABINDING
as select f.FACULTY as тюйскэрер, COUNT(*) as йнкхвеярбн_йютедп from dbo.FACULTY f inner join dbo.PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY
go
select * from йнкхвеярбн_йютедп
go
alter table FACULTY DROP COLUMN FACULTY_NAME;