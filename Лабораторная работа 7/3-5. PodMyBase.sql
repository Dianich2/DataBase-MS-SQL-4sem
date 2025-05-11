use Pod_MyBase;
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%42%'
group by p.ProgramName, r.AdvertisingType
UNION
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%43%'
group by p.ProgramName, r.AdvertisingType;

select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%42%'
group by p.ProgramName, r.AdvertisingType
UNION ALL
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%43%'
group by p.ProgramName, r.AdvertisingType;

select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%42%'
group by p.ProgramName, r.AdvertisingType
INTERSECT
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%43%'
group by p.ProgramName, r.AdvertisingType;

select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%42%'
group by p.ProgramName, r.AdvertisingType
EXCEPT
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%43%'
group by p.ProgramName, r.AdvertisingType;

select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%43%'
group by p.ProgramName, r.AdvertisingType
EXCEPT
select p.ProgramName, r.AdvertisingType, avg(DATEPART(SECOND, r.Duration))[Средняя продолжительность] from РЕКЛАМЫ r inner join ПЕРЕДАЧИ p on r.ProgramId = p.ProgramId
where r.CustomerCompanyID Like '%42%'
group by p.ProgramName, r.AdvertisingType;