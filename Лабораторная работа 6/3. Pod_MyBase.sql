use Pod_MyBase;
select * from (select case
when r.Duration between '00:00:10' and '00:00:30' then '10-30 ������'
when r.Duration between '00:00:31' and '00:00:50' then '31-50 ������'
end [�����������������], count(*)[����������]
from ������� r group by case
when r.Duration between '00:00:10' and '00:00:30' then '10-30 ������'
when r.Duration between '00:00:31' and '00:00:50' then '31-50 ������'
end) as T
order by case [�����������������]
when '10-30 ������' then 1
when '31-50 ������' then 2
end Desc;