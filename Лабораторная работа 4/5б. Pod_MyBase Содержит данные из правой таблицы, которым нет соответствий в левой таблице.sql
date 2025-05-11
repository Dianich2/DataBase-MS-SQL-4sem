use Pod_MyBase;
select c.CustomerCompanyID, c.CustomerCompanyName, c.BankDetails from
КОНТАКТНЫЕ_ЛИЦА con full outer join [Фирма-заказчик] c on c.ContactPersonID = con.ContactPersonID
where c.CustomerCompanyID is not null;