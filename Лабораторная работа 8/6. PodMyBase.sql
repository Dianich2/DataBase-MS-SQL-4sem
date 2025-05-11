ALTER VIEW [йнкхвеярбн_пейкюл_тхпл] WITH SCHEMABINDING as
select f.CustomerCompanyName as тхплю, count(*) as йнкхвеярбн_пейкюл from dbo.[тХПЛЮ-ГЮЙЮГВХЙ] f inner join dbo.пейкюлш r 
on f.CustomerCompanyID = r.CustomerCompanyID
group by f.CustomerCompanyName;
go
select * from йнкхвеярбн_пейкюл_тхпл;
go