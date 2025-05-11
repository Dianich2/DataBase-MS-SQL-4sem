begin try
	declare @x int
	set @x = 2 / 0
end try
begin catch
	print 'Код ошибки ' + cast(Error_Number() as varchar)
	print 'Сообщение об ошибке ' + Error_Message()
	print 'Номер строки с ошибкой ' + cast(Error_Line() as varchar)
	if Error_Procedure() is not null print 'Имя процедуры ' + Error_Procedure()
	else print 'Ошибка сделана не в процедуре'
	print 'Уровень серьезности ' + cast(Error_Severity() as varchar)
	print 'Метка ошибки ' + cast(Error_State() as varchar)
end catch