use UNIVER;
go

-- ЗАДАНИЕ 1 ----------
select RTRIM(t.TEACHER) [Teacher_id], RTRIM(t.TEACHER_NAME) [TEACHER_NAME], t.GENDER[GENDER], RTRIM(t.PULPIT) [PULPIT] from TEACHER t
where t.PULPIT = 'ИСиТ' for XML PATH('TEACHER'),
root('TEACHERS'), elements

-- ЗАДАНИЕ 2 ----------

select RTRIM(a.AUDITORIUM_NAME) [AUDITORIUM_NAME], RTRIM(at.AUDITORIUM_TYPENAME)[AUDITORIUM_TYPENAME], a.AUDITORIUM_CAPACITY[CAPACITY] from AUDITORIUM a inner join AUDITORIUM_TYPE at on a.AUDITORIUM_TYPE = at.AUDITORIUM_TYPE
where at.AUDITORIUM_TYPE = 'ЛК' for XML AUTO,
root('LECTURE_AUDITORIUMS'), elements

-- ЗАДАНИЕ 3 ----------

DECLARE @h int = 0;
DECLARE @XML nvarchar(max) = '<SUBJECTS>
<SUBJECTR>
    <SUBJECT>КПО</SUBJECT>
    <SUBJECT_NAME>Конструирование программного обеспечения</SUBJECT_NAME>
    <PULPIT>ИСиТ</PULPIT>
</SUBJECTR>
<SUBJECTR>
    <SUBJECT>СЯП</SUBJECT>
    <SUBJECT_NAME>Скриптовые языки программирования</SUBJECT_NAME>
    <PULPIT>ИСиТ</PULPIT>
</SUBJECTR>
<SUBJECTR>
    <SUBJECT>РиАТ</SUBJECT>
    <SUBJECT_NAME>Разработка и анализ требований</SUBJECT_NAME>
    <PULPIT>ИСиТ</PULPIT>
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

delete from SUBJECT where SUBJECT in('КПО', 'РиАТ', 'СЯП')


-- ЗАДАНИЕ 4 ----------
delete from STUDENT where NAME = 'Иванов Иван Иванович'
ALTER TABLE STUDENT ALTER COLUMN INFO xml
select * from STUDENT

insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, 'Иванов Иван Иванович', '2006-04-20', 
'<STUDENT>
	<PASSPORT>
		<SERIES>КВ</SERIES>
		<NUMBER>1234567</NUMBER>
		<DATE>20.02.2020</DATE>
		<ADDRESS>
			<COUNTRY>Беларусь</COUNTRY>
			<TOWN>Горки</TOWN>
			<STREET>пр.Интернациональный</STREET>
			<HOUSE>34</HOUSE>
			<FLAT>67</FLAT>
		</ADDRESS>
	</PASSPORT>
</STUDENT>')

update STUDENT set INFO = '<STUDENT>
	<PASSPORT>
		<SERIES>КВ</SERIES>
		<NUMBER>2092095</NUMBER>
		<DATE>10.04.2024</DATE>
		<ADDRESS>
			<COUNTRY>Беларусь</COUNTRY>
			<TOWN>Горки</TOWN>
			<STREET>ул.Строителей</STREET>
			<HOUSE>21</HOUSE>
			<FLAT>15</FLAT>
		</ADDRESS>
	</PASSPORT>
</STUDENT>'
where INFO.value('(/STUDENT/PASSPORT/SERIES)[1]', 'varchar(5)') = 'КВ'

select NAME, INFO.value('(/STUDENT/PASSPORT/SERIES)[1]', 'varchar(5)')[серия паспорта],
INFO.value('(/STUDENT/PASSPORT/NUMBER)[1]', 'varchar(10)')[номер паспорта],
INFO.query('/STUDENT/PASSPORT/ADDRESS')[адрес]
from STUDENT

update STUDENT set INFO = null where NAME = 'Иванов Иван Иванович'

select * from STUDENT
-- ЗАДАНИЕ 5 ----------

use UNIVER
go
create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
       <xs:element name="студент">  
       <xs:complexType><xs:sequence>
       <xs:element name="паспорт" maxOccurs="1" minOccurs="1">
       <xs:complexType>
       <xs:attribute name="серия" type="xs:string" use="required" />
       <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
       <xs:attribute name="дата"  use="required" >  
       <xs:simpleType>  <xs:restriction base ="xs:string">
   <xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
   </xs:restriction> 	</xs:simpleType>
   </xs:attribute> </xs:complexType> 
   </xs:element>
   <xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
   <xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
   </xs:sequence></xs:complexType>  </xs:element>
   </xs:sequence></xs:complexType>
   </xs:element>
</xs:schema>';

select  * from sys.triggers

ALTER TABLE STUDENT ALTER COLUMN INFO xml(dbo.STUDENT)

select * from STUDENT

-- УСПЕШНО -----
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, 'Иванов Иван Иванович', '2006-04-20', 
'<студент>
	<паспорт серия="КВ" дата="20.02.2020" номер="1234567">
	</паспорт>
	<телефон>292602834</телефон>
	<адрес>
		<страна>Беларусь</страна>
		<город>Горки</город>
		<улица>пр.Интернациональный</улица>
		<дом>34</дом>
		<квартира>67</квартира>
	</адрес>
</студент>')

-- ОШИБКА В ТЕЛЕФОНЕ -----
insert into STUDENT(IDGROUP, NAME, BDAY, INFO) values(7, 'Иванов Иван Иванович', '2006-04-20', 
'<студент>
	<паспорт серия="КВ" дата="20.02.2020" номер="1234567">
	</паспорт>
	<телефон>+375292602834</телефон>
	<адрес>
		<страна>Беларусь</страна>
		<город>Горки</город>
		<улица>пр.Интернациональный</улица>
		<дом>34</дом>
		<квартира>67</квартира>
	</адрес>
</студент>')

-- УСПЕШНО -----
update STUDENT set INFO = '<студент>
	<паспорт серия="КВ" дата="25.02.2020" номер="2222222">
	</паспорт>
	<телефон>292602834</телефон>
	<адрес>
		<страна>Беларусь</страна>
		<город>Горки</город>
		<улица>пр.Интернациональный</улица>
		<дом>34</дом>
		<квартира>67</квартира>
	</адрес>
</студент>' where INFO.value('(/студент/паспорт/@серия)[1]', 'varchar(5)') = 'КВ'


-- ОШИБКА В ДАТЕ -----
update STUDENT set INFO = '<студент>
	<паспорт серия="КВ" дата="25.0.2020" номер="2222222">
	</паспорт>
	<телефон>292602834</телефон>
	<адрес>
		<страна>Беларусь</страна>
		<город>Горки</город>
		<улица>пр.Интернациональный</улица>
		<дом>34</дом>
		<квартира>67</квартира>
	</адрес>
</студент>' where INFO.value('(/студент/паспорт/@серия)[1]', 'varchar(5)') = 'КВ'

select * from STUDENT

select * from AUDITORIUM

create xml schema collection AUDITORIUM_S as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
           elementFormDefault="qualified"
           xmlns:xs="http://www.w3.org/2001/XMLSchema">
   <xs:element name="аудитория">  
       <xs:complexType>
			<xs:attribute name="вместимость" type="xs:unsignedInt" />
			<xs:attribute name="номер" type="xs:unsignedInt" use="required" />
			<xs:attribute name="корпус" type="xs:unsignedInt" use="required"/>
	   </xs:complexType> 
   </xs:element>
</xs:schema>';

ALTER TABLE AUDITORIUM ADD INFO xml(dbo.AUDITORIUM_S)

select * from AUDITORIUM

update AUDITORIUM set INFO = '
<аудитория вместимость="15" номер="206" корпус="1"></аудитория>
' where AUDITORIUM = '206-1'