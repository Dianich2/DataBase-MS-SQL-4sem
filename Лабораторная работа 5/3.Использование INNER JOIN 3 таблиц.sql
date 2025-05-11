use UNIVER;
select p.FACULTY, p.PULPIT_NAME, pr.PROFESSION_NAME from
PULPIT p inner join PROFESSION pr on p.FACULTY = pr.FACULTY 
inner join FACULTY f on pr.FACULTY = f.FACULTY
where pr.PROFESSION_NAME Like '%технологи%';