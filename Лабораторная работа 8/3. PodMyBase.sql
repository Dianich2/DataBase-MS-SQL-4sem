drop VIEW IF EXISTS пейкюлш_тхпл
go
CREATE VIEW пейкюлш_тхпл as
select r.AdvertisingType as рхо_пейкюлш, p.ProgramName as мюгбюмхе_оепедювх from пейкюлш r inner join оепедювх p
on r.ProgramId = p.ProgramId
where p.ProgramName like '%МЮЬ%';
go
select * from пейкюлш_тхпл;