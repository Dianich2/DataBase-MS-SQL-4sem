use Pod_MyBase;
select p.ProgramName, r.AdvertisingType, avg(DatePart(SECOND, r.Duration))[Средняя продолжительность]
from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where p.ProgramName Like '%наш%'
group by p.ProgramName, r.AdvertisingType;