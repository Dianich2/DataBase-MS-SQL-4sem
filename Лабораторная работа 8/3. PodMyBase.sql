drop VIEW IF EXISTS �������_����
go
CREATE VIEW �������_���� as
select r.AdvertisingType as ���_�������, p.ProgramName as ��������_�������� from ������� r inner join �������� p
on r.ProgramId = p.ProgramId
where p.ProgramName like '%���%';
go
select * from �������_����;