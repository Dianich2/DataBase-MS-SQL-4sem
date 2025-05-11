use Pod_MyBase;
select c.CustomerCompanyName, a.AdvertisingType, a.Date, a.Duration from
[Фирма-заказчик] c cross join РЕКЛАМЫ a
where c.CustomerCompanyID = a.CustomerCompanyID;