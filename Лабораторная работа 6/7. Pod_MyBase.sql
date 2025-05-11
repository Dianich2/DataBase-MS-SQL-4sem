use Pod_MyBase;
select r.AdvertisingType, (select count(*) from РЕКЛАМЫ r1 where r.AdvertisingType = r1.AdvertisingType)[Количество]
from РЕКЛАМЫ r 
group by r.AdvertisingType
Having r.AdvertisingType Like '%з%'
order by r.AdvertisingType;