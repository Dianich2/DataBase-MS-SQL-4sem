use Pod_MyBase;
select p.ProgramName, a.AdvertisingType, a.Date, c.CustomerCompanyName,  con.ContactPersonFullName, con.Telephone,
case 
when(a.Date BETWEEN '2025-02-10' and '2025-02-19') then 'до 20 февраля'
when(a.Date BETWEEN '2025-02-20' and '2025-02-28') then 'с 20 и позже'
end [WHEN]
from
РЕКЛАМЫ a inner join ПЕРЕДАЧИ p on a.ProgramId = p.ProgramId 
inner join [Фирма-заказчик] c on c.CustomerCompanyID = a.CustomerCompanyID
inner join КОНТАКТНЫЕ_ЛИЦА con on c.ContactPersonID = con.ContactPersonID
order by c.CustomerCompanyName;