use Pod_MyBase;
select r.AdvertisingType, (select count(*) from ������� r1 where r.AdvertisingType = r1.AdvertisingType)[����������]
from ������� r 
group by r.AdvertisingType
Having r.AdvertisingType Like '%�%'
order by r.AdvertisingType;