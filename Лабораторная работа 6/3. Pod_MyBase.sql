use Pod_MyBase;
select * from (select case
when r.Duration between '00:00:10' and '00:00:30' then '10-30 секунд'
when r.Duration between '00:00:31' and '00:00:50' then '31-50 секунд'
end [Продолжительность], count(*)[Количество]
from РЕКЛАМЫ r group by case
when r.Duration between '00:00:10' and '00:00:30' then '10-30 секунд'
when r.Duration between '00:00:31' and '00:00:50' then '31-50 секунд'
end) as T
order by case [Продолжительность]
when '10-30 секунд' then 1
when '31-50 секунд' then 2
end Desc;