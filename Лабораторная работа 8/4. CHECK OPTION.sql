drop view IF EXISTS ����������_���������;
go
create view ����������_��������� as
select a.AUDITORIUM as ���, a.AUDITORIUM_NAME as ������������_���������, a.AUDITORIUM_TYPE as ���_��������� from UNIVER.dbo.AUDITORIUM a
where a.AUDITORIUM_TYPE like '��%' WITH CHECK OPTION;
go
insert ����������_��������� values('240-1', '240-1', '��');
go
select * from ����������_���������;