use UNIVER;
drop table TIMETABLE;
create table TIMETABLE(
	GROUP_ integer constraint TIMETABLE_GROUPS_FK foreign key references GROUPS(IDGROUP),
	AUDITORIUM_ char(20)  constraint TIMETABLE_AUDITORIUM_FK foreign key references AUDITORIUM(AUDITORIUM),
	SUBJECT_ char(10) constraint TIMETABLE_SUBJECT_FK  foreign key references SUBJECT(SUBJECT),
	TEACHER_ char(10)  constraint TIMETABLE_TEACHER_FK foreign key references TEACHER(TEACHER),
	DAY_OF_WEEK nvarchar(11) default 'понедельник',
	TIME_ time(0) not null
)
insert into TIMETABLE(GROUP_, AUDITORIUM_, SUBJECT_, TEACHER_, DAY_OF_WEEK, TIME_)
values(2, '413-1', 'СУБД', 'УРБ', 'понедельник', '08:00:00'),
      (1, '206-1', 'СУБД', 'СМЛВ', 'понедельник', '09:35:00'),
      (1, '301-1', 'ОАиП', 'ГРН', 'понедельник', '11:25:00'),
      (2, '236-1', 'БД', 'УРБ', 'понедельник', '09:35:00'),
      (2, '408-2', 'КГ', 'ЖЛК', 'понедельник', '13:00:00'),
      (3, '324-1', 'ИНФ', 'ДТК', 'вторник', '11:25:00'),
      (3, '413-1', 'ПЗ', 'МРЗ', 'вторник', '13:00:00'),
      (4, '206-1', 'МСОИ', 'РЖК', 'среда', '08:00:00'),
      (4, '301-1', 'ПСП', 'БРГ', 'среда', '11:25:00'),
      (5, '236-1', 'ДМ', 'НВРВ', 'четверг', '09:35:00'),
      (5, '408-2', 'ОПП', 'ЗВГЦВ', 'четверг', '13:00:00'),
      (6, '324-1', 'ЛЭВМ', 'БЗБРДВ', 'пятница', '08:00:00'),
      (6, '413-1', 'ТиОЛ', 'НСКВЦ', 'пятница', '11:25:00'),
      (7, '206-1', 'ЭП', 'МРЗ', 'понедельник', '14:40:00'),
      (7, '301-1', 'ЭТ', 'УРБ', 'понедельник', '18:00:00'),
      (8, '236-1', 'ИГ', 'ДТК', 'вторник', '09:35:00'),
      (8, '408-2', 'ЛВ', 'ГРН', 'вторник', '11:25:00'),
      (9, '324-1', 'ОХ', 'ЖЛК', 'среда', '08:00:00'),
      (9, '413-1', 'ТРИ', 'РЖК', 'среда', '16:25:00'),
      (10, '206-1', 'ПЭХ', 'СМЛВ', 'четверг', '09:35:00');