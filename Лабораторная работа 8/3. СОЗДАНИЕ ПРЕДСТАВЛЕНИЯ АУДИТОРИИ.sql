drop view ���������;
go
create view ��������� as
select a.AUDITORIUM as ���, a.AUDITORIUM_NAME as ������������_��������� from UNIVER.dbo.AUDITORIUM a
where a.AUDITORIUM_TYPE like '��%';
go
select * from ���������;;