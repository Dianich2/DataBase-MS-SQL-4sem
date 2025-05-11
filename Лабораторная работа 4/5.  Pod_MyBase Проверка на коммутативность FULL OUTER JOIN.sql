use Pod_MyBase;
select * from
[Фирма-заказчик] c full outer join КОНТАКТНЫЕ_ЛИЦА con on c.ContactPersonID = con.ContactPersonID;

use Pod_MyBase;
select * from
КОНТАКТНЫЕ_ЛИЦА con full outer join  [Фирма-заказчик] c on c.ContactPersonID = con.ContactPersonID;