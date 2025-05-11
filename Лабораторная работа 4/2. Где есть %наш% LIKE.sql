use Pod_MyBase;
select p.ProgramName, p.Rating, a.AdvertisingType, a.Date, a.Duration from
пейкюлш a inner join оепедювх p on a.ProgramId = p.ProgramId 
and p.ProgramName Like '%МЮЬ%';