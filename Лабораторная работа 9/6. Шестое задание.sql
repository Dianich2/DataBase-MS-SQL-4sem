select * from (select case
when p.NOTE between 1 and 3 then 'отправлен на пересдачу'
when p.NOTE between 4 and 6 then 'удовлетворительно'
when p.NOTE between 7 and 8 then 'хорошо'
when p.NOTE between 9 and 10 then 'отлично'
end [LevelOfKnowledge], count(*)[countOfStudent]
from PROGRESS p
group by case
when p.NOTE between 1 and 3 then 'отправлен на пересдачу'
when p.NOTE between 4 and 6 then 'удовлетворительно'
when p.NOTE between 7 and 8 then 'хорошо'
when p.NOTE between 9 and 10 then 'отлично'
end) as level
order by case [LevelOfKnowledge]
when 'отправлен на пересдачу' then 0
when 'удовлетворительно' then 1
when 'хорошо' then 2
else 3
end