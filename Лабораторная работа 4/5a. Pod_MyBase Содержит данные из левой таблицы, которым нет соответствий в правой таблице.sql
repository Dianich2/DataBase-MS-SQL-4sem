use Pod_MyBase;
select con.ContactPersonId, con.ContactPersonFullName, con.Telephone from
КОНТАКТНЫЕ_ЛИЦА con full outer join [Фирма-заказчик] c on con.ContactPersonID = c.ContactPersonID
where c.CustomerCompanyName is null;