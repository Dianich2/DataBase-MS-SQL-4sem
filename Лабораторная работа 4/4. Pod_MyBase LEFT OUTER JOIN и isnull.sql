use Pod_MyBase;
select con.ContactPersonFullName, isnull(c.CustomerCompanyName, '***')[CustomerCompanyName] from
[����������_����] con left outer join [�����-��������] c on c.ContactPersonID = con.ContactPersonID;
