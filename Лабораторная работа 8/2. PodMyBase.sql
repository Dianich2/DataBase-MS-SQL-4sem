drop VIEW IF EXISTS ����������_������_����
go
CREATE VIEW ����������_������_���� as
select f.CustomerCompanyName as �����, count(*) as ����������_������ from [�����-��������] f inner join ������� r 
on f.CustomerCompanyID = r.CustomerCompanyID
group by f.CustomerCompanyName;
go
select * from ����������_������_����;