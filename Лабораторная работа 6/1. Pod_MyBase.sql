use Pod_MyBase;
select r.AdvertisingType, max(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[Максимальная стоимость], 
min(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[Минимальная стоимость], avg(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[Средняя стоимость], 
sum(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[Общая стоимость], count(*)[Количество]
from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
group by r.AdvertisingType
order by [Количество] Desc;