use Pod_MyBase;
select c.CustomerCompanyName from
[�����-��������] c inner join ������� re on c.CustomerCompanyID = re.CustomerCompanyID and re.Date in(select r.Date from ������� r 
where r.Date > '2025-02-17');