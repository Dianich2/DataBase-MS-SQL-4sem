use UNIVER;
select p.FACULTY, p.PULPIT_NAME, pr.PROFESSION_NAME from
PULPIT p inner join PROFESSION pr on p.FACULTY = pr.FACULTY and
pr.PROFESSION_NAME in(select pro.PROFESSION_NAME from PROFESSION pro where pro.PROFESSION_NAME Like '%технологи%');