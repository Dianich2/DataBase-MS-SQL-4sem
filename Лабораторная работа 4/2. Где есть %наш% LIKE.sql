use Pod_MyBase;
select p.ProgramName, p.Rating, a.AdvertisingType, a.Date, a.Duration from
������� a inner join �������� p on a.ProgramId = p.ProgramId 
and p.ProgramName Like '%���%';