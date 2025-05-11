use Pod_MyBase;
select r.AdvertisingType, max(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[������������ ���������], 
min(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[����������� ���������], avg(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[������� ���������], 
sum(DatePart(SECOND, r.Duration) * p.MinuteCost / 60)[����� ���������], count(*)[����������]
from ������� r inner join �������� p on r.ProgramId = p.ProgramId
group by r.AdvertisingType
order by [����������] Desc;