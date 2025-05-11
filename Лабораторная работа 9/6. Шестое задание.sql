select * from (select case
when p.NOTE between 1 and 3 then '��������� �� ���������'
when p.NOTE between 4 and 6 then '�����������������'
when p.NOTE between 7 and 8 then '������'
when p.NOTE between 9 and 10 then '�������'
end [LevelOfKnowledge], count(*)[countOfStudent]
from PROGRESS p
group by case
when p.NOTE between 1 and 3 then '��������� �� ���������'
when p.NOTE between 4 and 6 then '�����������������'
when p.NOTE between 7 and 8 then '������'
when p.NOTE between 9 and 10 then '�������'
end) as level
order by case [LevelOfKnowledge]
when '��������� �� ���������' then 0
when '�����������������' then 1
when '������' then 2
else 3
end