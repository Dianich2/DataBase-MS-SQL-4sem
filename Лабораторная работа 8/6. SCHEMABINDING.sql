ALTER VIEW [����������_������] with SCHEMABINDING
as select f.FACULTY as ���������, COUNT(*) as ����������_������ from dbo.FACULTY f inner join dbo.PULPIT p
on f.FACULTY = p.FACULTY
group by f.FACULTY
go
select * from ����������_������
go
alter table FACULTY DROP COLUMN FACULTY_NAME;