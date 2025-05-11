drop VIEW IF EXISTS пейкюлш_тхпл
go
CREATE VIEW пейкюлш_тхпл as
select r.AdvertisingID as йнд, r.AdvertisingType as рхо_пейкюлш, r.Date as дюрю from пейкюлш r
where r.Date between '2025-02-20' and '2025-02-28' WITH CHECK OPTION;
go
Insert пейкюлш_тхпл values(6, 'пЕЙКЮЛЮ ЬХМ', '2025-02-10');
go
select * from пейкюлш_тхпл;
go
