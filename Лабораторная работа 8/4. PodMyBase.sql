drop VIEW IF EXISTS �������_����
go
CREATE VIEW �������_���� as
select r.AdvertisingID as ���, r.AdvertisingType as ���_�������, r.Date as ���� from ������� r
where r.Date between '2025-02-20' and '2025-02-28' WITH CHECK OPTION;
go
Insert �������_���� values(6, '������� ���', '2025-02-10');
go
select * from �������_����;
go
