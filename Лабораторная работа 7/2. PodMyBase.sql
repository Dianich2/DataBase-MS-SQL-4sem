use Pod_MyBase;
select p.ProgramName, r.AdvertisingType, round(avg(cast(DatePart(SECOND, r.Duration)as float(4))),2)[������� �����������������]
from ������� r inner join �������� p on r.ProgramId = p.ProgramId
where p.ProgramName Like '%���%'
group by CUBE (p.ProgramName, r.AdvertisingType);