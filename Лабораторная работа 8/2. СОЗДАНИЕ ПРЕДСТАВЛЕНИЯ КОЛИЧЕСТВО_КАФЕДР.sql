drop view ����������_������;
go
Create View [����������_������] as
select f.FACULTY as ���������, COUNT(*) as ����������_������ from UNIVER.dbo.FACULTY f inner join UNIVER.dbo.PULPIT p on f.FACULTY = p.FACULTY
group by f.FACULTY;
go
select * from dbo.����������_������;
