drop view IF EXISTS кейжхнммше_юсдхрнпхх;
go
create view кейжхнммше_юсдхрнпхх as
select a.AUDITORIUM as йнд, a.AUDITORIUM_NAME as мюхлемнбюмхе_юсдхрнпхх, a.AUDITORIUM_TYPE as рхо_юсдхрнпхх from UNIVER.dbo.AUDITORIUM a
where a.AUDITORIUM_TYPE like 'кй%' WITH CHECK OPTION;
go
insert кейжхнммше_юсдхрнпхх values('240-1', '240-1', 'ка');
go
select * from кейжхнммше_юсдхрнпхх;