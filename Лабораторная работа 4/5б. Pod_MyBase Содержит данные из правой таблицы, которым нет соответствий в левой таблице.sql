use Pod_MyBase;
select c.CustomerCompanyID, c.CustomerCompanyName, c.BankDetails from
����������_���� con full outer join [�����-��������] c on c.ContactPersonID = con.ContactPersonID
where c.CustomerCompanyID is not null;