use Pod_MyBase;
select f.CustomerCompanyName, r.AdvertisingType, p.ProgramName, round(cast(avg(DatePart(Second, r.Duration)) as float(4)), 2)[Среднее время] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
inner join [Фирма-заказчик] f on f.CustomerCompanyID = r.CustomerCompanyID
where f.CustomerCompanyName Like '%O%'
group by f.CustomerCompanyName, r.AdvertisingType, p.ProgramName;
