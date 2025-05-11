use Pod_MyBase;
select c.CustomerCompanyName, a.AdvertisingType, a.Date, a.Duration from
[Фирма-заказчик] c inner join РЕКЛАМЫ a on c.CustomerCompanyID = a.CustomerCompanyID;