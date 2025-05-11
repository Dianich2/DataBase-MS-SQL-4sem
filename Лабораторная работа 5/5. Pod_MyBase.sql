use Pod_MyBase;
select con.ContactPersonFullName, con.Telephone from
КОНТАКТНЫЕ_ЛИЦА con where not exists(select * from [Фирма-заказчик] c where c.ContactPersonID = con.ContactPersonID);