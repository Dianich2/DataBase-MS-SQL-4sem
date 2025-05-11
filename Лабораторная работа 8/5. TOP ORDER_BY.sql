drop view IF EXISTS дхяжхокхмш;
go
create view дхяжхокхмш as 
select TOP 50 s.SUBJECT as йнд, s.SUBJECT_NAME as мюхлемнбюмхе_дхяжхокхмш, s.PULPIT as йнд_йютедпш  from SUBJECT s
order by s.SUBJECT_NAME;
go 
select * from дхяжхокхмш;
