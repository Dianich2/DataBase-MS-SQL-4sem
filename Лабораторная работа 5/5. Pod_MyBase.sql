use Pod_MyBase;
select con.ContactPersonFullName, con.Telephone from
����������_���� con where not exists(select * from [�����-��������] c where c.ContactPersonID = con.ContactPersonID);