use UNIVER;
--ЗАДАНИЕ 1
declare @buf varchar(5), @res_str varchar(100) = ''
declare cursorForSubjects CURSOR for select s.SUBJECT from SUBJECT s where s.PULPIT = 'ИСиТ'
OPEN cursorForSubjects;
FETCH cursorForSubjects into @buf;
print 'Дисциплины на кафедре ИСиТ';
while @@FETCH_STATUS = 0
begin
	set @res_str = rtrim(@buf) + ', ' + @res_str;
	FETCH cursorForSubjects into @buf;
end
set @res_str = substring(@res_str, 1, len(@res_str) - 1)
print @res_str;
CLOSE cursorForSubjects
deallocate cursorForSubjects
go

--ЗАДАНИЕ 2
Declare cursorForPulpits CURSOR local for select p.PULPIT_NAME from PULPIT p
Declare @buf varchar(50)
OPEN cursorForPulpits
FETCH cursorForPulpits into @buf;
print '1. ' + @buf
go

Declare @buf varchar(50)
FETCH cursorForPulpits into @buf;
print '2. ' + @buf
go


Declare cursorForPulpitsG CURSOR for select p.PULPIT_NAME from PULPIT p
Declare @buf varchar(50)
OPEN cursorForPulpitsG
FETCH cursorForPulpitsG into @buf;
print '1. ' + @buf
go

Declare @buf varchar(50)
FETCH cursorForPulpitsG into @buf;
print '2. ' + @buf
deallocate cursorForPulpitsG
go

--ЗАДАНИЕ 3
declare @group int , @auditorium varchar(10), @subject varchar(10), @teacher varchar(10), @day varchar(10), @time time
declare cursorForTimetableS CURSOR local STATIC for select * from TIMETABLE
open cursorForTimetableS
print 'Количество пар в неделю = ' + cast(@@CURSOR_ROWS as varchar(3))
Insert into TIMETABLE values(7, '301-1', 'МП', 'БРМ', 'вторник', '18:00:00')
Insert into TIMETABLE values(7, '206-1', 'БД', 'НИСТ', 'пятница', '18:00:00')
Insert into TIMETABLE values(7, '324-1', 'БД', 'БРНЦ', 'вторник', '14:40:00')
FETCH cursorForTimetableS into @group, @auditorium, @subject, @teacher, @day, @time
while @@FETCH_STATUS = 0
begin
	print 'Группа: ' + cast(@group as varchar(3)) + ', аудитория: ' + @auditorium + ', дисциплина: ' + @subject + ', преподаватель: ' + @teacher + ', день недели: ' + @day + ', время: ' + cast(@time as varchar(10))
	FETCH cursorForTimetableS into @group, @auditorium, @subject, @teacher, @day, @time
end
CLOSE cursorForTimetableS
go
Delete from TIMETABLE where TEACHER_ in('БРМ', 'НИСТ', 'БРНЦ')
go

declare @group int , @auditorium varchar(10), @subject varchar(10), @teacher varchar(10), @day varchar(10), @time time
declare cursorForTimetableS CURSOR local for select * from TIMETABLE
open cursorForTimetableS
Insert into TIMETABLE values(7, '301-1', 'МП', 'БРМ', 'вторник', '18:00:00')
Insert into TIMETABLE values(7, '206-1', 'БД', 'НИСТ', 'пятница', '18:00:00')
Insert into TIMETABLE values(7, '324-1', 'БД', 'БРНЦ', 'вторник', '14:40:00')
FETCH cursorForTimetableS into @group, @auditorium, @subject, @teacher, @day, @time
print 'Количество пар в неделю = ' + cast(@@CURSOR_ROWS as varchar(3))
while @@FETCH_STATUS = 0
begin
	print 'Группа: ' + cast(@group as varchar(3)) + ', аудитория: ' + @auditorium + ', дисциплина: ' + @subject + ', преподаватель: ' + @teacher + ', день недели: ' + @day + ', время: ' + cast(@time as varchar(10))
	FETCH cursorForTimetableS into @group, @auditorium, @subject, @teacher, @day, @time
end
CLOSE cursorForTimetableS
go
Delete from TIMETABLE where TEACHER_ in('БРМ', 'НИСТ', 'БРНЦ')
go

--ЗАДАНИЕ 4

declare @teacher varchar(50)
declare cursorForTeachers CURSOR LOCAL SCROLL for select t.TEACHER_NAME from TEACHER t where t.PULPIT = 'ИСиТ' order by t.TEACHER_NAME
OPEN cursorForTeachers;
Fetch first from cursorForTeachers into @teacher
print 'Первый преподаватель в списке: ' + @teacher
Fetch next from cursorForTeachers into @teacher
print 'Следующий преподаватель в списке: ' + @teacher
Fetch absolute 5 from cursorForTeachers into @teacher
print 'Пятый преподаватель в списке от начала: ' + @teacher
Fetch absolute -5 from cursorForTeachers into @teacher
print 'Пятый преподаватель в списке от конца: ' + @teacher
Fetch prior from cursorForTeachers into @teacher
print 'Шестой преподаватель в списке от конца: ' + @teacher
Fetch relative 4 from cursorForTeachers into @teacher
print 'Второй преподаватель в списке от конца: ' + @teacher
Fetch relative -1 from cursorForTeachers into @teacher
print 'Третий преподаватель в списке от конца: ' + @teacher
Fetch last from cursorForTeachers into @teacher
print 'Последний преподаватель в списке: ' + @teacher
Close cursorForTeachers
go

select t.TEACHER_NAME from TEACHER t where t.PULPIT = 'ИСиТ' order by t.TEACHER_NAME
go

--ЗАДАНИЕ 5

select s.IDGROUP, s.NAME, s.BDAY from STUDENT s order by s.IDSTUDENT
go

declare @idGroup int, @name varchar(50), @b_day date
declare cursorForStudents CURSOR LOCAL SCROLL for select s.IDGROUP, s.NAME, s.BDAY from STUDENT s order by s.IDSTUDENT FOR UPDATE
OPEN cursorForStudents
fetch last from cursorForStudents into @idGroup, @name, @b_day
print @name
DELETE STUDENT where CURRENT OF cursorForStudents
fetch prior from cursorForStudents into @idGroup, @name, @b_day
print @name
UPDATE STUDENT set IDGROUP = IDGROUP + 1 where CURRENT OF cursorForStudents
CLOSE cursorFORStudents
go

select s.IDGROUP, s.NAME, s.BDAY from STUDENT s order by s.IDSTUDENT
go

insert into STUDENT(IDGROUP, NAME, BDAY) values(18, 'Бакунович Алина Олеговна', '1995-08-05')
UPDATE STUDENT set IDGROUP = 18 where IDSTUDENT = 1079
go

-- ЗАДАНИЕ 6.1

insert into PROGRESS values('ОАиП', 1008, '2013-01-15', 2),
						   ('ОАиП', 1009, '2013-01-15', 3),
						   ('ОАиП', 1010, '2013-01-15', 1)

select s.NAME, g.PROFESSION, g.IDGROUP, p.SUBJECT, p.PDATE, p.NOTE from PROGRESS p inner join STUDENT s on 
p.IDSTUDENT = s.IDSTUDENT inner join GROUPS g on s.IDGROUP = g.IDGROUP
go

declare @name varchar(50), @profession varchar(20), @idGroup int, @subject varchar(10), @date date, @mark int
declare cursorForStudentWithBadMark CURSOR LOCAL for select s.NAME, g.PROFESSION, g.IDGROUP, p.SUBJECT, p.PDATE, p.NOTE from PROGRESS p inner join STUDENT s on 
p.IDSTUDENT = s.IDSTUDENT inner join GROUPS g on s.IDGROUP = g.IDGROUP where p.NOTE < 4 FOR UPDATE
OPEN cursorForStudentWithBadMark
fetch cursorForStudentWithBadMark into @name, @profession, @idGroup, @subject, @date, @mark
while @@FETCH_STATUS = 0
begin
	print 'Студент: ' + @name + ', специальность: ' + @profession + ', группа: ' + cast(@idGroup as varchar(3)) + ', предмет: ' + @subject + ', дата сдачи: ' + cast(@date as varchar(15)) + ', оценка: ' + cast(@mark as varchar(2))
	DELETE PROGRESS where CURRENT OF cursorForStudentWithBadMark
	fetch cursorForStudentWithBadMark into @name, @profession, @idGroup, @subject, @date, @mark
end
close cursorForStudentWithBadMark
go

select s.NAME, g.PROFESSION, g.IDGROUP, p.SUBJECT, p.PDATE, p.NOTE from PROGRESS p inner join STUDENT s on 
p.IDSTUDENT = s.IDSTUDENT inner join GROUPS g on s.IDGROUP = g.IDGROUP
go

-- ЗАДАНИЕ 6.2

select p.IDSTUDENT, p.NOTE from PROGRESS p
go

declare @mark int, @idCurStud int = 1001
declare cursorForStudent CURSOR LOCAL for select p.NOTE from PROGRESS p where p.IDSTUDENT = @idCurStud FOR UPDATE
OPEN cursorForStudent
fetch cursorForStudent into @mark
while @@FETCH_STATUS = 0
begin
	UPDATE PROGRESS set NOTE = @mark + 1 where CURRENT OF cursorForStudent
	fetch cursorForStudent into @mark
end
close cursorForStudent
go

select p.IDSTUDENT, p.NOTE from PROGRESS p
go