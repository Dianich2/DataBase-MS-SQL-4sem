drop view IF EXISTS ����������_����_��_��������
go
CREATE VIEW ����������_����_��_�������� as
select TOP 50 c.ContactPersonID as ���, c.ContactPersonFullName as ���, c.Telephone as �������
from ����������_���� c
order by ���;
go
select * from ����������_����_��_��������