use Pod_MyBase;
go

select * from [�����-��������]
select * from �������

-- ������� 1 ----------
select * from [�����-��������] for xml PATH('�����'),
root('�����'), elements

-- ������� 2 ---------
select f.CustomerCompanyName, r.AdvertisingType, r.Date, r.Duration from [�����-��������] f  inner join ������� r on f.CustomerCompanyID = r.CustomerCompanyID
where r.ProgramId = 5 for xml AUTO,
root('�������'),elements

-- ������� 3 ----------

declare @h int = 0,
@buf varchar(max) = '
<CustomerCompanies>
	<CustomerCompany>
		<CustomerCompanyID>102550</CustomerCompanyID>
		<CustomerCompanyName>DELVIN</CustomerCompanyName>
		<BankDetails>6574927548</BankDetails>
		<ContactPersonID>2</ContactPersonID>
	</CustomerCompany>
	<CustomerCompany>
		<CustomerCompanyID>102551</CustomerCompanyID>
		<CustomerCompanyName>CARWEL</CustomerCompanyName>
		<BankDetails>9749264528</BankDetails>
		<ContactPersonID>1</ContactPersonID>
	</CustomerCompany>
	<CustomerCompany>
		<CustomerCompanyID>102552</CustomerCompanyID>
		<CustomerCompanyName>HI-GEAR</CustomerCompanyName>
		<BankDetails>7582645361</BankDetails>
		<ContactPersonID>3</ContactPersonID>
	</CustomerCompany>
</CustomerCompanies>
';

exec sp_xml_preparedocument @h output, @buf;

insert into [�����-��������] 
select * from openxml(@h, '/CustomerCompanies/CustomerCompany', 0)
with([CustomerCompanyID] int 'CustomerCompanyID', [CustomerCompanyName] varchar(100) 'CustomerCompanyName', [BankDetails] varchar(10) 'BankDetails', [ContactPersonID] int 'ContactPersonID')
exec sp_xml_removedocument @h;

select * from [�����-��������]
delete from [�����-��������] where CustomerCompanyID in(102550, 102551, 102552)

-- ������� 4 ---------

ALTER TABLE [�����-��������] ALTER COLUMN INFO xml

insert into [�����-��������] values(102555, 'TEST', '4629946574', 5, 
'<�����>
	<��������>TEST</��������>
	<�������������>������� ���</�������������>
	<����_��������>24.04.2025</����_��������>
	<����������_���������>4629946574</����������_���������>
	<���������������>��������</���������������>
</�����>
')

update [�����-��������] set INFO =  
'<�����>
	<��������>BUF</��������>
	<�������������>������� �������������</�������������>
	<����_��������>20.04.2025</����_��������>
	<����������_���������>4629946574</����������_���������>
	<���������������>��������</���������������>
</�����>
' where INFO.value('(/�����/��������)[1]', 'varchar(100)') = 'TEST'

select * from [�����-��������]

delete from [�����-��������] where CustomerCompanyID = 102555

-- ������� 5 ----------
use Pod_MyBase
go
create xml schema collection [�����-��������] as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <xs:element name="�����">
        <xs:complexType>
            <xs:sequence>
                <xs:element name="��������" type="xs:string"/>
                <xs:element name="�������������" type="xs:string"/>
                <xs:element name="����_��������">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:element>
                <xs:element name="����������_���������">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xs:maxLength value="10"/>
							<xs:minLength value="10"/>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:element>
                <xs:element name="���������������" type="xs:string"/>
            </xs:sequence>
        </xs:complexType>
    </xs:element>
</xs:schema>';


ALTER TABLE [�����-��������] ALTER COLUMN INFO xml(dbo.[�����-��������])

-- ������� -----
insert into [�����-��������] values(102555, 'TEST', '4629946574', 5, 
'<�����>
	<��������>TEST</��������>
	<�������������>������� ���</�������������>
	<����_��������>24.04.2025</����_��������>
	<����������_���������>4629946574</����������_���������>
	<���������������>��������</���������������>
</�����>
')

-- ������ � ���� -----
insert into [�����-��������] values(102555, 'TEST', '4629946574', 5, 
'<�����>
	<��������>TEST</��������>
	<�������������>������� ���</�������������>
	<����_��������>24.0.2025</����_��������>
	<����������_���������>4629946574</����������_���������>
	<���������������>��������</���������������>
</�����>
')

-- ������� -----
update [�����-��������] set INFO =  
'<�����>
	<��������>BUF</��������>
	<�������������>������� �������������</�������������>
	<����_��������>20.04.2025</����_��������>
	<����������_���������>4629946574</����������_���������>
	<���������������>��������</���������������>
</�����>
' where INFO.value('(/�����/��������)[1]', 'varchar(100)') = 'TEST'

-- ������ � ����� ����������_���������� -----
update [�����-��������] set INFO =  
'<�����>
	<��������>BUF</��������>
	<�������������>������� �������������</�������������>
	<����_��������>20.04.2025</����_��������>
	<����������_���������>46299465</����������_���������>
	<���������������>��������</���������������>
</�����>
' where INFO.value('(/�����/��������)[1]', 'varchar(100)') = 'TEST'

select * from [�����-��������]


-- ��� ������� ----------
use UNIVER
go

DROP FUNCTION IF EXISTS COUNT_PULPIT
go 
CREATE FUNCTION COUNT_PULPIT(@f varchar(10)) returns int
as 
begin
	declare @count int = (select count(p.PULPIT) from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY where f.FACULTY = isnull(@f, f.FACULTY))
	return @count
end
go


select 
	(select RTRIM(f.FACULTY) as '@���', 
		(select dbo.COUNT_PULPIT(f.FACULTY) from FACULTY f1 where f1.FACULTY = f.FACULTY for xml PATH('����������_������'), type), 
		(select RTRIM(p1.PULPIT) as '@���',
			(select RTRIM(t1.TEACHER) as '@���', 
			(select distinct t2.TEACHER_NAME from TEACHER t2 where t2.PULPIT = p1.PULPIT and t2.TEACHER = t1.TEACHER) 
			from TEACHER t1 where t1.PULPIT = p1.PULPIT for xml path('�������������'), type) as '�������������' 
			from PULPIT p1 where p1.FACULTY = f.FACULTY for xml PATH('�������'), type) as '�������' for xml PATH('���������'), type) 
from FACULTY f inner join PULPIT p on f.FACULTY = p.FACULTY inner join TEACHER t on p.PULPIT = t.PULPIT group by f.FACULTY for xml PATH(''), type, root('�����������')

