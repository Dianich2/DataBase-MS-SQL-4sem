use Pod_MyBase;
select con.ContactPersonId, con.ContactPersonFullName, con.Telephone from
����������_���� con full outer join [�����-��������] c on con.ContactPersonID = c.ContactPersonID
where c.CustomerCompanyName is null;