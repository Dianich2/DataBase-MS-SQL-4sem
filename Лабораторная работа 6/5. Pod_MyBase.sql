use Pod_MyBase;
select f.CustomerCompanyName, r.AdvertisingType, p.ProgramName, round(cast(avg(DatePart(Second, r.Duration)) as float(4)), 2)[������� �����] from ������� r inner join �������� p on r.ProgramId = p.ProgramId
inner join [�����-��������] f on f.CustomerCompanyID = r.CustomerCompanyID
where f.CustomerCompanyName Like '%O%'
group by f.CustomerCompanyName, r.AdvertisingType, p.ProgramName;
