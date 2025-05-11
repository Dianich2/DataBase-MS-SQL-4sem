use Pod_MyBase;
select p.ProgramName, r.AdvertisingType, round(avg(cast(DatePart(SECOND, r.Duration)as float(4))),2)[Средняя продолжительность]
from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where p.ProgramName Like '%наш%'
group by CUBE (p.ProgramName, r.AdvertisingType);