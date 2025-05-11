drop view IF EXISTS йнмрюйрмше_кхжю_он_юктюбхрс
go
CREATE VIEW йнмрюйрмше_кхжю_он_юктюбхрс as
select TOP 50 c.ContactPersonID as йнд, c.ContactPersonFullName as тхн, c.Telephone as рекетнм
from йнмрюйрмше_кхжю c
order by тхн;
go
select * from йнмрюйрмше_кхжю_он_юктюбхрс