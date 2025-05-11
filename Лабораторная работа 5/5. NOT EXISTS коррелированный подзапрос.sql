use UNIVER;
Select f.FACULTY from
FACULTY f where not exists(select * from PULPIT p 
where f.FACULTY = p.FACULTY);