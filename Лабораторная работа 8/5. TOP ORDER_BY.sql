drop view IF EXISTS ����������;
go
create view ���������� as 
select TOP 50 s.SUBJECT as ���, s.SUBJECT_NAME as ������������_����������, s.PULPIT as ���_�������  from SUBJECT s
order by s.SUBJECT_NAME;
go 
select * from ����������;
