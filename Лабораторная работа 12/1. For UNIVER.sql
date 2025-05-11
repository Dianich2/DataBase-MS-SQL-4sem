-- ÇÀÄÀÍÈÅ 1
Drop Table if exists NewT 
set implicit_transactions on
declare @i int, @flag char = 't'
Create table NewT(Key_ int primary key, Word varchar(10));
insert into NewT(Key_ , Word)
values(1, 'one'),
	  (2, 'two'),
	  (3, 'three'),
	  (4, 'four'),
	  (5, 'five')
if @flag = 'c' commit;
else rollback;
Set implicit_transactions off
go

-- ÇÀÄÀÍÈÅ 2
use UNIVER;

select * from STUDENT

-- ÒÐÀÍÇÀÊÖÈß ÂÛÏÎËÍßÅÒÑß ÓÑÏÅØÍÎ
begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, 'Ïåòðîâ Ïåòð Ïåòðîâè÷', '2006-05-20');
		delete from STUDENT where NAME = 'Áàêóíîâè÷ Àëèíà Îëåãîâíà';
		Update STUDENT set IDGROUP = 19 where IDSTUDENT = 1079;
		commit tran;
end try
begin catch
	print 'îøèáêà: ' + case
	when error_number() = 2627 then 'Íàðóøåíèå óíèêàëüíîñòè êëþ÷à'
	else 'íåèçâåñòíàÿ îøèáêà: ' + cast(error_number() as varchar(5)) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from STUDENT

delete from STUDENT where Name = 'Ïåòðîâ Ïåòð Ïåòðîâè÷';
insert into STUDENT(IDGROUP, NAME, BDAY) values(18, 'Áàêóíîâè÷ Àëèíà Îëåãîâíà', '1995-08-05');
Update STUDENT set IDGROUP = 18 where IDSTUDENT = 1079;






-- ÒÐÀÍÇÀÊÖÈß ÍÅ ÂÛÏÎËÍßÅÒÑß ÈÇ-ÇÀ ÂÑÒÀÂÊÈ Â ÑÒÎËÁÅÖ, ÊÎÒÎÐÛÉ ÀÂÒÎÃÅÍÅÐÈÐÓÅÌÛÉ È ßÂËßÅÒÑß ÈÄÅÍÒÈÔÈÊÀÒÎÐÎÌ
select * from STUDENT

begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, 'Ïåòðîâ Ïåòð Ïåòðîâè÷', '2006-05-20');
		insert into STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY) values(1000, 19, 'Ïåòðîâ Ïåòð Ïåòðîâè÷', '2006-05-20');
		commit tran;
end try
begin catch
	print 'îøèáêà: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + 'Íàðóøåíèå óíèêàëüíîñòè êëþ÷à'
	else CHAR(9) + 'íåèçâåñòíàÿ îøèáêà: êîä - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from STUDENT






-- ÒÐÀÍÇÀÊÖÈß ÍÅ ÂÛÏÎËÍßÅÒÑß ÈÇ-ÇÀ ÓÄÀËÅÍÈß ÑÂßÇÀÍÍÎÃÎ ÏÎËß
select * from PROGRESS

begin try
	begin tran
		insert into PROGRESS values('ÑÓÁÄ', 1070, '2013-01-11', 5);
		delete from STUDENT where Name = 'Äóáðîâà Ïàâåë Èãîðåâè÷';
		commit tran;
end try
begin catch
	print 'îøèáêà: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + 'Íàðóøåíèå óíèêàëüíîñòè êëþ÷à'
	else CHAR(9) + 'íåèçâåñòíàÿ îøèáêà: êîä - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;
go

select * from PROGRESS




-- ÇÀÄÀÍÈÅ 3


-- ÎØÈÁÊÈ ÂÎ ÂÑÒÀÂÊÅ, ÍÎ ÂÎÇÂÐÀÙÅÍÈÅ Ê ÊÎÍÒÐÎËÜÍÎÉ ÒÎ×ÊÅ
select * from STUDENT

declare @control_point varchar(32)
begin try
	begin tran
		insert into STUDENT(IDGROUP, NAME, BDAY) values(19, 'Ïåòðîâ Ïåòð Ïåòðîâè÷', '2006-05-20');
		set @control_point = 'p1'; save tran @control_point;
		insert into STUDENT(IDSTUDENT, IDGROUP, NAME, BDAY) values(1000, 19, 'Ïåòðîâ Ïåòð Ïåòðîâè÷', '2006-05-20');
		commit tran;
end try
begin catch
	print 'îøèáêà: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + 'Íàðóøåíèå óíèêàëüíîñòè êëþ÷à'
	else CHAR(9) + 'íåèçâåñòíàÿ îøèáêà: êîä - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print 'Âîçâðàùåíèå ê êîíòðîëüíîé òî÷êå: ' + @control_point;
		rollback tran @control_point;
		commit tran;
	end
end catch;
go

select * from STUDENT

delete from STUDENT where Name = 'Ïåòðîâ Ïåòð Ïåòðîâè÷';


-- ÎØÈÁÊÀ Â ÓÄÀËÅÍÈÈ ÑÒÐÎÊÈ, ÍÎ ÂÎÇÂÐÀÙÅÍÈÅ Ê ÊÎÍÒÐÎËÜÍÎÉ ÒÎ×ÊÅ

select * from PROGRESS

declare @control_point varchar(32), @control_point2 varchar(32)
begin try
	begin tran
		insert into PROGRESS values('ÑÓÁÄ', 1070, '2013-01-11', 5);
		set @control_point = 'p1'; save tran @control_point;
		insert into PROGRESS values('ÎÀèÏ', 1070, '2013-01-19', 7);
		set @control_point2 = 'p2'; save tran @control_point2;
		delete from STUDENT where Name = 'Äóáðîâà Ïàâåë Èãîðåâè÷';
		commit tran;
end try
begin catch
	print 'îøèáêà: '+ CHAR(10) + case
	when error_number() = 2627 then CHAR(9) + 'Íàðóøåíèå óíèêàëüíîñòè êëþ÷à'
	else CHAR(9) + 'íåèçâåñòíàÿ îøèáêà: êîä - ' + cast(error_number() as varchar(5)) + CHAR(10) + CHAR(9) + error_message()
	end;
	if @@TRANCOUNT > 0
	begin
		print 'Âîçâðàùåíèå ê êîíòðîëüíîé òî÷êå: ' + @control_point2; -- ìîæíî çàìåíèòü íà p2
		rollback tran @control_point2; -- ìîæíî çàìåíèòü íà p2
		commit tran;
	end
end catch;
go

select * from PROGRESS

delete from PROGRESS where IDSTUDENT = 1070 and SUBJECT = 'ÑÓÁÄ'
delete from PROGRESS where IDSTUDENT = 1070 and SUBJECT = 'ÎÀèÏ'


-- ÇÀÄÀÍÈÅ 4

use UNIVER;
select * from PROGRESS

-- ÃÐßÇÍÎÅ ×ÒÅÍÈÅ

-- A ---
	set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ÍÅÏÎÂÒÎÐßÞÙÅÅÑß ×ÒÅÍÈÅ

	select * from PROGRESS
-- A ---
    set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('ÎÀèÏ', 1001, '2013-01-10', 6)

-- ÔÀÍÒÎÌÍÎÅ ×ÒÅÍÈÅ

-- A ---
    set tran isolation level READ UNCOMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = 'ÁÄ' and IDSTUDENT = 1001


-- ÇÀÄÀÍÈÅ 5

-- ÃÐßÇÍÎÅ ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß

-- A ---
	set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ÍÅÏÎÂÒÎÐßÞÙÅÅÑß ×ÒÅÍÈÅ

	select * from PROGRESS
-- A ---
    set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('ÎÀèÏ', 1001, '2013-01-10', 6)

-- ÔÀÍÒÎÌÍÎÅ ×ÒÅÍÈÅ

-- A ---
    set tran isolation level READ COMMITTED 
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = 'ÁÄ' and IDSTUDENT = 1001

-- ÇÀÄÀÍÈÅ 6

-- ÃÐßÇÍÎÅ ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß

-- A ---
	set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ÍÅÏÎÂÒÎÐßÞÙÅÅÑß ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß

	select * from PROGRESS
-- A ---
    set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('ÎÀèÏ', 1001, '2013-01-10', 6)

-- ÔÀÍÒÎÌÍÎÅ ×ÒÅÍÈÅ

-- A ---
    set tran isolation level REPEATABLE READ  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = 'ÁÄ' and IDSTUDENT = 1001

-- ÇÀÄÀÍÈÅ 7

-- A ---

-- ÃÐßÇÍÎÅ ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß
	set tran isolation level SERIALIZABLE  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

-- ÍÅÏÎÂÒÎÐßÞÙÅÅÑß ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß

	select * from PROGRESS
-- A ---
    set tran isolation level SERIALIZABLE  
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	insert into PROGRESS values('ÎÀèÏ', 1001, '2013-01-10', 6)

-- ÔÀÍÒÎÌÍÎÅ ×ÒÅÍÈÅ ÍÅ ÄÎÏÓÑÊÀÅÒÑß

-- A ---
    set tran isolation level SERIALIZABLE    
	begin tran 
	select Count(*) from PROGRESS where NOTE > 5;
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select Count(*) from PROGRESS where NOTE > 5;
	commit tran;

	delete from PROGRESS where SUBJECT = 'ÁÄ' and IDSTUDENT = 1001

-- ÇÀÄÀÍÈÅ 8

select * from PROGRESS

begin tran
	insert into PROGRESS values('ÊÃ', 1071, '2025-01-15', 9)
	begin tran
		update PROGRESS set SUBJECT = 'ÎÎÏ' where IDSTUDENT = 1070
		commit
	if @@TRANCOUNT > 0 rollback;

select * from PROGRESS