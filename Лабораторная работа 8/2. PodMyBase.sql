drop VIEW IF EXISTS йнкхвеярбн_пейкюл_тхпл
go
CREATE VIEW йнкхвеярбн_пейкюл_тхпл as
select f.CustomerCompanyName as тхплю, count(*) as йнкхвеярбн_пейкюл from [тХПЛЮ-ГЮЙЮГВХЙ] f inner join пейкюлш r 
on f.CustomerCompanyID = r.CustomerCompanyID
group by f.CustomerCompanyName;
go
select * from йнкхвеярбн_пейкюл_тхпл;