use Pod_MyBase;
select p.ProgramName, r.AdvertisingType, avg(DatePart(SECOND, r.Duration))[������� �����������������]
from ������� r inner join �������� p on r.ProgramId = p.ProgramId
where p.ProgramName Like '%���%'
group by p.ProgramName, r.AdvertisingType;