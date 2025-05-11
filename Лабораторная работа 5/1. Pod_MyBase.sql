use Pod_MyBase;
select c.CustomerCompanyName from
[Ôèðìà-çàêàç÷èê] c, ÐÅÊËÀÌÛ re where c.CustomerCompanyID = re.CustomerCompanyID and re.Date in(select r.Date from ÐÅÊËÀÌÛ r 
where r.Date > '2025-02-17');