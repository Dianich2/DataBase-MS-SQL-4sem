use Pod_MyBase;
select con.ContactPersonFullName, isnull(c.CustomerCompanyName, '***')[CustomerCompanyName] from
[КОНТАКТНЫЕ_ЛИЦА] con left outer join [Фирма-заказчик] c on c.ContactPersonID = con.ContactPersonID;
