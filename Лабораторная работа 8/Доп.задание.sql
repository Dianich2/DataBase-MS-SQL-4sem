drop view IF EXISTS ����������
go
CREATE VIEW ���������� as 
select t.DAY_OF_WEEK as ����_������, t.TIME_ as �����, t.SUBJECT_ as �������, 
t.AUDITORIUM_ as ���������, t.TEACHER_ as �������������, t.GROUP_ as ������ 
from TIMETABLE t;
go
select * from ���������� as p PIVOT
(max(������) for ����_������ in([�����������], [�������], [�����], [�������], [�������], [�������])) as newTable;