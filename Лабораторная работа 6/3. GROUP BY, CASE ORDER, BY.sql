use UNIVER;
select * from (select case 
when pr.NOTE between 1 and 4 then '1-4'
when pr.NOTE between 5 and 7 then '5-7'
when pr.NOTE between 8 and 10 then '8-10'
end [Диапазон_оценки], count(*)[Количество]
from PROGRESS pr Group by Case 
when pr.NOTE between 1 and 4 then '1-4'
when pr.NOTE between 5 and 7 then '5-7'
when pr.NOTE between 8 and 10 then '8-10'
end) Tab
order by Case [Диапазон_оценки]
when '1-4' then 3
when '5-7' then 2
when '8-10' then 1
end