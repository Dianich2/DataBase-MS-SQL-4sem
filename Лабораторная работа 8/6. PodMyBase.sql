ALTER VIEW [����������_������_����] WITH SCHEMABINDING as
select f.CustomerCompanyName as �����, count(*) as ����������_������ from dbo.[�����-��������] f inner join dbo.������� r 
on f.CustomerCompanyID = r.CustomerCompanyID
group by f.CustomerCompanyName;
go
select * from ����������_������_����;
go