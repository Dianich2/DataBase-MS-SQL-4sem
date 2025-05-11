use Pod_MyBase

-- ЗАДАНИЕ 2

select * from [Фирма-заказчик]

-- ТРАНЗАКЦИЯ ВЫПОЛНЯЕТСЯ УСПЕШНО
begin try
	begin tran
		insert into [Фирма-заказчик] values(102548, 'Carwel', 2383459321, 3);
		Update [Фирма-заказчик] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 then 'Нарушение уникальности ключа'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from [Фирма-заказчик]

delete from [Фирма-заказчик] where CustomerCompanyName = 'Carwel';
Update [Фирма-заказчик] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;


-- ОШИБКА ПРИ УДАЛЕНИИ
begin try
	begin tran
		insert into [Фирма-заказчик] values(102548, 'Carwel', 2383459321, 3);
		delete from [Фирма-заказчик] where CustomerCompanyName = 'СВИПТРЕЙД'
		Update [Фирма-заказчик] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 then 'Нарушение уникальности ключа'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from [Фирма-заказчик]


-- ОШИБКА ПРИ ВСТАВКЕ
begin try
	begin tran
		Update [Фирма-заказчик] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		insert into [Фирма-заказчик] values(102544, 'Carwel', 2383459321, 3);
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 then 'Нарушение уникальности ключа'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from [Фирма-заказчик]


-- ЗАДАНИЕ 3

declare @control_point varchar(32)
begin try
	begin tran
		Update [Фирма-заказчик] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		set @control_point = 'p1'; save tran @control_point;
		insert into [Фирма-заказчик] values(102544, 'Carwel', 2383459321, 3);
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 then 'Нарушение уникальности ключа'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print 'Возвращение к контрольной точке: ' + @control_point;
		rollback tran @control_point;
		commit tran;
	end
end catch;
go

select * from [Фирма-заказчик]

Update [Фирма-заказчик] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;




declare @control_point varchar(32), @control_point2 varchar(32)
begin try
	begin tran
		Update [Фирма-заказчик] set CustomerCompanyName = 'new' where CustomerCompanyID = 102543;
		set @control_point = 'p1'; save tran @control_point;
		Update [Фирма-заказчик] set CustomerCompanyName = 'new2' where CustomerCompanyID = 102544;
		set @control_point2 = 'p2'; save tran @control_point2;
		delete from [Фирма-заказчик] where CustomerCompanyName = 'СВИПТРЕЙД'
		commit tran;
end try
begin catch
	print 'ошибка: ' + case
	when error_number() = 2627 then 'Нарушение уникальности ключа'
	else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print 'Возвращение к контрольной точке: ' + @control_point2;
		rollback tran @control_point2;
		commit tran;
	end
end catch;
go

select * from [Фирма-заказчик]

Update [Фирма-заказчик] set CustomerCompanyName = 'REVLINE' where CustomerCompanyID = 102543;

Update [Фирма-заказчик] set CustomerCompanyName = 'MANNOL' where CustomerCompanyID = 102544;


-- ЗАДАНИЕ 4

select * from РЕКЛАМЫ

-- ГРЯЗНОЕ ЧТЕНИЕ

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ

-- НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	insert into РЕКЛАМЫ values(2, '102542', 5, '2025-02-20', '00:00:44', 'Реклама двигателей')


-- ФАНТОМНОЕ ЧТЕНИЕ

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	delete from РЕКЛАМЫ where AdvertisingID = 7

-- ЗАДАНИЕ 5

	select * from РЕКЛАМЫ

-- ГРЯЗНОЕ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ

-- НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	insert into РЕКЛАМЫ values(2, '102542', 5, '2025-02-20', '00:00:44', 'Реклама двигателей')


-- ФАНТОМНОЕ ЧТЕНИЕ

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	delete from РЕКЛАМЫ where AdvertisingID = 7



-- ЗАДАНИЕ 6

	select * from РЕКЛАМЫ

-- ГРЯЗНОЕ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level REPEATABLE READ 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ

-- НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	insert into РЕКЛАМЫ values(2, '102542', 5, '2025-02-20', '00:00:44', 'Реклама двигателей')


-- ФАНТОМНОЕ ЧТЕНИЕ

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	delete from РЕКЛАМЫ where AdvertisingID = 7



-- ЗАДАНИЕ 7

	select * from РЕКЛАМЫ

-- ГРЯЗНОЕ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level SERIALIZABLE 
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ

-- НЕПОВТОРЯЮЩЕЕСЯ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level SERIALIZABLE  
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	insert into РЕКЛАМЫ values(2, '102542', 5, '2025-02-20', '00:00:44', 'Реклама двигателей')


-- ФАНТОМНОЕ ЧТЕНИЕ НЕ ДОПУСКАЕТСЯ

-- A ---
	set tran isolation level SERIALIZABLE  
	begin tran 
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	-------------------------- t1 ------------------
	-------------------------- t2 -----------------
	select count(*) from РЕКЛАМЫ where CustomerCompanyID = '102542'
	commit tran;

	select * from РЕКЛАМЫ
	delete from РЕКЛАМЫ where AdvertisingID = 7


-- ЗАДАНИЕ 8

select * from [Фирма-заказчик]

begin tran
	insert into [Фирма-заказчик] values(102570, 'TEST', 1029684921, 5);
	begin tran
		update [Фирма-заказчик] set ContactPersonID = 7 where CustomerCompanyID = 102542;
		commit
	if @@TRANCOUNT > 0 rollback;

select * from [Фирма-заказчик]