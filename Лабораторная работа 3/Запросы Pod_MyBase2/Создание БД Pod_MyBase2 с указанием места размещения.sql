use master;
create database Pod_MyBase2 on primary
(name = N'Pod_MyBase_mdf', filename = N'C:\ФИТ\Лабораторные работы\4 сем\БД\Лабораторная работа 2\Pod_MyBase_mdf.mdf',
size = 10240Kb, maxsize = UNLIMITED, filegrowth = 1024Kb),
( name = N'Pod_MyBase_ndf', filename = N'C:\ФИТ\Лабораторные работы\4 сем\БД\Лабораторная работа 2\Pod_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'Pod_MyBase_fg1', filename = N'C:\ФИТ\Лабораторные работы\4 сем\БД\Лабораторная работа 2\Pod_MyBase_fgq-1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
(name = N'Pod_MyBase_log', filename = N'C:\ФИТ\Лабораторные работы\4 сем\БД\Лабораторная работа 2\Pod_MyBase_log.ldf',
size = 10240Kb, maxsize = 2048Gb, filegrowth = 10%)
go