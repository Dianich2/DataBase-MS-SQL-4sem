use UNIVER;
go

-- ������� 1 ----------
select RTRIM(t.TEACHER) [Teacher_id], RTRIM(t.TEACHER_NAME) [TEACHER_NAME], t.GENDER[GENDER], RTRIM(t.PULPIT) [PULPIT] from TEACHER t
where t.PULPIT = '����' for XML PATH('TEACHER'),
root('TEACHERS'), elements

-- ������� 2 ----------

select RTRIM(a.AUDITORIUM_NAME) [AUDITORIUM_NAME], RTRIM(at.AUDITORIUM_TYPENAME)[AUDITORIUM_TYPENAME], a.AUDITORIUM_CAPACITY[CAPACITY] from AUDITORIUM a inner join AUDITORIUM_TYPE at on a.AUDITORIUM_TYPE = at.AUDITORIUM_TYPE
where at.AUDITORIUM_TYPE = '��' for XML AUTO,
root('LECTURE_AUDITORIUMS'), elements

-- ������� 3 ----------

DECLARE @h int = 0;
DECLARE @XML nvarchar(max) = '<SUBJECTS>
<SUBJECTR>
    <SUBJECT>���</SUBJECT>
    <SUBJECT_NAME>��������������� ������������ �����������</SUBJECT_NAME>
    <PULPIT>����</PULPIT>
</SUBJECTR>
<SUBJECTR>
    <SUBJECT>���</SUBJECT>
    <SUBJECT_NAME>���������� ����� ����������������</SUBJECT_NAME>
    <PULPIT>����</PULPIT>
</SUBJECTR>
<SUBJECTR>
    <SUBJECT>����</SUBJECT>
    <SUBJECT_NAME>���������� � ������ ����������</SUBJECT_NAME>
    <PULPIT>����</PULPIT>
</SUBJECTR>
</SUBJECTS>';

EXEC sys.sp_xml_preparedocument @h OUTPUT, @XML;

select * from SUBJECT

insert into SUBJECT 
select * from OPENXML(@h, '/SUBJECTS/SUBJECTR', 0)
WITH (
    [SUBJECT] nvarchar(10) 'SUBJECT', 
    [SUBJECT_NAME] nvarchar(100) 'SUBJECT_NAME', 
    [PULPIT] nvarchar(10) 'PULPIT'
);

EXEC sys.sp_xml_removedocument @h;

select * from SUBJECT

delete from SUBJECT where SUBJECT in('���', '����', '���')


-- ������� 4 ----------
delete from STUDENT where NAME = '������ ���� ��������'
ALTER TABLE STUDENT ALTER COLUMN INFO xml
select * from STUDENT

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, '������ ���� ��������', '2006-04-20', 
'<STUDENT>
	<PASSPORT>
		<SERIES>��</SERIES>
		<NUMBER>1234567</NUMBER>
		<DATE>20.02.2020</DATE>
		<ADDRESS>
			<COUNTRY>��������</COUNTRY>
			<TOWN>�����</TOWN>
			<STREET>��.�����������������</STREET>
			<HOUSE>34</HOUSE>
			<FLAT>67</FLAT>
		</ADDRESS>
	</PASSPORT>
</STUDENT>')

update STUDENT set INFO = '<STUDENT>
	<PASSPORT>
		<SERIES>��</SERIES>
		<NUMBER>2092095</NUMBER>
		<DATE>10.04.2024</DATE>
		<ADDRESS>
			<COUNTRY>��������</COUNTRY>
			<TOWN>�����</TOWN>
			<STREET>��.����������</STREET>
			<HOUSE>21</HOUSE>
			<FLAT>15</FLAT>
		</ADDRESS>
	</PASSPORT>
</STUDENT>'
where INFO.value('(/STUDENT/PASSPORT/SERIES)[1]', 'varchar(5)') = '��'

select NAME, INFO.value('(/STUDENT/PASSPORT/SERIES)[1]', 'varchar(5)')[����� ��������],
INFO.value('(/STUDENT/PASSPORT/NUMBER)[1]', 'varchar(10)')[����� ��������],
INFO.query('/STUDENT/PASSPORT/ADDRESS')[�����]
from STUDENT

update STUDENT set INFO = null where NAME = '������ ���� ��������'

select * from STUDENT
-- ������� 5 ----------

use UNIVER
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="�������">  
       <xs:complexType><xs:sequence>
       <xs:element name="�������" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="�����" type="xs:string" use="required" />
       <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="����"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
   <xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

select  * from sys.triggers

ALTER TABLE STUDENT ALTER COLUMN INFO xml(dbo.STUDENT)

select * from STUDENT

-- ������� -----
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, '������ ���� ��������', '2006-04-20', 
'<�������>
	<������� �����="��" ����="20.02.2020" �����="1234567">
	</�������>
	<�������>292602834</�������>
	<�����>
		<������>��������</������>
		<�����>�����</�����>
		<�����>��.�����������������</�����>
		<���>34</���>
		<��������>67</��������>
	</�����>
</�������>')

-- ������ � �������� -----
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, '������ ���� ��������', '2006-04-20', 
'<�������>
	<������� �����="��" ����="20.02.2020" �����="1234567">
	</�������>
	<�������>+375292602834</�������>
	<�����>
		<������>��������</������>
		<�����>�����</�����>
		<�����>��.�����������������</�����>
		<���>34</���>
		<��������>67</��������>
	</�����>
</�������>')

-- ������� -----
update STUDENT set INFO = '<�������>
	<������� �����="��" ����="25.02.2020" �����="2222222">
	</�������>
	<�������>292602834</�������>
	<�����>
		<������>��������</������>
		<�����>�����</�����>
		<�����>��.�����������������</�����>
		<���>34</���>
		<��������>67</��������>
	</�����>
</�������>' where INFO.value('(/�������/�������/@�����)[1]', 'varchar(5)') = '��'


-- ������ � ���� -----
update STUDENT set INFO = '<�������>
	<������� �����="��" ����="25.0.2020" �����="2222222">
	</�������>
	<�������>292602834</�������>
	<�����>
		<������>��������</������>
		<�����>�����</�����>
		<�����>��.�����������������</�����>
		<���>34</���>
		<��������>67</��������>
	</�����>
</�������>' where INFO.value('(/�������/�������/@�����)[1]', 'varchar(5)') = '��'

select * from STUDENT

select * from AUDITORIUM

create xml schema collection AUDITORIUM_S as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
   <xs:element name="���������">  
       <xs:complexType>
			<xs:attribute name="�����������" type="xs:unsignedInt" />
			<xs:attribute name="�����" type="xs:unsignedInt" use="required" />
			<xs:attribute name="������" type="xs:unsignedInt" use="required"/>
	   </xs:complexType> 
   </xs:element>
</xs:schema>';

ALTER TABLE AUDITORIUM ADD INFO xml(dbo.AUDITORIUM_S)

select * from AUDITORIUM

update AUDITORIUM set INFO = '
<��������� �����������="15" �����="206" ������="1"></���������>
' where AUDITORIUM = '206-1'