use Pod_MyBase;
select p.ProgramName, a.AdvertisingType, a.Date, c.CustomerCompanyName,  con.ContactPersonFullName, con.Telephone,
case 
when(a.Date BETWEEN '2025-02-10' and '2025-02-19') then '�� 20 �������'
when(a.Date BETWEEN '2025-02-20' and '2025-02-28') then '� 20 � �����'
end [WHEN]
from
������� a inner join �������� p on a.ProgramId = p.ProgramId 
inner join [�����-��������] c on c.CustomerCompanyID = a.CustomerCompanyID
inner join ����������_���� con on c.ContactPersonID = con.ContactPersonID
order by c.CustomerCompanyName;