use Pod_MyBase;
select c.CustomerCompanyName from
[Ôèðìà-çàêàç÷èê] c inner join ÐÅÊËÀÌÛ re on c.CustomerCompanyID = re.CustomerCompanyID and re.Date in(select r.Date from ÐÅÊËÀÌÛ r 
where r.Date > '2025-02-17');