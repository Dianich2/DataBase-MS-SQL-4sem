use Pod_MyBase;
select re.AdvertisingType, re.Duration from
������� re where re.AdvertisingID = (select top(1) r.AdvertisingID from
������� r where r.CustomerCompanyID = re.CustomerCompanyID order by Duration desc);