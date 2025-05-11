use Pod_MyBase;
select re.AdvertisingType, re.Duration from
–≈ À¿Ã€ re where re.AdvertisingID = (select top(1) r.AdvertisingID from
–≈ À¿Ã€ r where r.CustomerCompanyID = re.CustomerCompanyID order by Duration desc);