select * from AUDITORIUM;
print 'Число обработанных строк ' + cast(@@ROWCOUNT as varchar(10)) + char(13)
print 'Версия SQL Server ' + cast(@@VERSION as varchar(max)) + char(13)
print 'Системный идентификатор процесса, назначенный сервером текущему подключению ' + cast(@@SPID as varchar(max)) + char(13)
Begin Try
declare @error int = 5 / 0
end Try
begin catch
print 'Код последней ошибки ' + cast(@@ERROR as varchar(max)) + ' Сообщение: ' + Error_Message() + char(13)
end catch
print 'Имя сервера ' + cast(@@SERVERNAME as varchar(max)) + char(13)
Begin Tran
print 'Уровень вложенности транзакции ' + cast(@@TRANCOUNT as varchar(max)) + char(13)
Commit Tran
print 'Проверка статуса считывания строк результирующего набора ' + cast(@@FETCH_STATUS as varchar(max)) + char(13)
Drop procedure If exists CheckLevelOfProcedure
go
Create procedure CheckLevelOfProcedure
as
begin
print 'Это моя процедура. Уровень вложенности текущей процедуры ' + cast(@@NESTLEVEL as varchar(max))
end
go
exec CheckLevelOfProcedure




