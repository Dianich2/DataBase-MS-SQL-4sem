use Univer;
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'TIMETABLE'
go

set nocount on
IF OBJECT_ID('tempdb..#BUF_TABLE') is not null
begin
	DROP table #BUF_TABLE
end
Create table #BUF_TABLE(TIND int, TFIELD varchar(100));
go
DECLARE @i int = 0;
while @i < 5000
begin
	insert #BUF_TABLE(TIND, TFIELD)
	values (rand() * 50000, REPLICATE('1', 5));
	set @i = @i + 1;
end
go
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
go
select * from #BUF_TABLE where TIND Between 5000 and 10000 order by TIND;
go
CHECKPOINT;
DBCC DROPCLEANBUFFERS;
go
CREATE clustered index #EXPLRE_CL on #BUF_TABLE(TIND asc);
go
select * from #BUF_TABLE where TIND Between 5000 and 10000 order by TIND;


-- «¿ƒ¿Õ»≈ 2
IF OBJECT_ID('tempdb..#BUF_TABLE2') is not null
begin
	DROP table #BUF_TABLE2
end
go
Create table #BUF_TABLE2(TKEY int, CC int identity(1,1), TF varchar(100));
go
declare @i int
set @i = 0;
while @i < 30000
begin
	insert #BUF_TABLE2(TKEY, TF)
	values(floor(20000 * rand()), replicate('1',5))
	set @i = @i + 1;
end;
select count(*)[ ÓÎË˜ÂÒÚ‚Ó ÒÚÓÍ] from #BUF_TABLE2;
select * from #BUF_TABLE2;

go
CREATE index #EX_NONCLU on #BUF_TABLE2(TKEY, CC)
go
SELECT * from  #BUF_TABLE2 where  TKEY > 1500 and  CC < 4500;  
SELECT * from  #BUF_TABLE2 order by  TKEY, CC
SELECT * from  #BUF_TABLE2 where  TKEY = 556 and  CC > 3


--«¿ƒ¿Õ»≈ 3
IF OBJECT_ID('tempdb..#BUF_TABLE3') is not null
begin
	DROP table #BUF_TABLE3
end
go
Create table #BUF_TABLE3(TKEY int, CC int identity(1,1), TF varchar(100));
go
declare @i int
set @i = 0;
while @i < 30000
begin
	insert #BUF_TABLE3(TKEY, TF)
	values(floor(20000 * rand()), replicate('1',5))
	set @i = @i + 1;
end;
go 
select CC from #BUF_TABLE3 where TKEY > 19500
go
CREATE index #EX_TKEY_CC on #BUF_TABLE3(TKEY) INCLUDE(CC)
go 
select CC from #BUF_TABLE3 where TKEY >19500
go

--«¿ƒ¿Õ»≈ 4
IF OBJECT_ID('tempdb..#BUF_TABLE4') is not null
begin
	DROP table #BUF_TABLE4
end
go
Create table #BUF_TABLE4(TKEY int, CC int identity(1,1), TF varchar(100));
go
declare @i int
set @i = 0;
while @i < 30000
begin
	insert #BUF_TABLE4(TKEY, TF)
	values(floor(20000 * rand()), replicate('1',5))
	set @i = @i + 1;
end;
go 
SELECT TKEY from  #BUF_TABLE4 where TKEY between 5000 and 19999; 
SELECT TKEY from  #BUF_TABLE4 where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #BUF_TABLE4 where TKEY=17000
go
CREATE  index #EX_WHERE on #BUF_TABLE4(TKEY) where (TKEY >= 12000 and TKEY < 20000);  
go
SELECT TKEY from  #BUF_TABLE4 where TKEY between 5000 and 19999; 
SELECT TKEY from  #BUF_TABLE4 where TKEY>15000 and  TKEY < 20000  
SELECT TKEY from  #BUF_TABLE4 where TKEY=17000
go

--«¿ƒ¿Õ»≈ 5
IF OBJECT_ID('tempdb..#BUF_TABLE5') is not null
begin
	DROP table #BUF_TABLE5
end

Create table #BUF_TABLE5(TKEY int, CC int identity(1,1), TF varchar(100));

declare @i int
set @i = 0;
while @i < 30000
begin
	insert #BUF_TABLE5(TKEY, TF)
	values(floor(20000 * rand()), replicate('1',5))
	set @i = @i + 1;
end;

CREATE index #EX_TKEY ON #BUF_TABLE5(TKEY); 

select ii.name[»Õƒ≈ —], ss.avg_fragmentation_in_percent[Ù‡„ÏÂÌÚ‡ˆËˇ]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'), OBJECT_ID(N'#BUF_TABLE5'), null, null, null) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;


INSERT top(10000) #BUF_TABLE5(TKEY, TF) select TKEY, TF from #BUF_TABLE5;


select ii.name[»Õƒ≈ —], ss.avg_fragmentation_in_percent[Ù‡„ÏÂÌÚ‡ˆËˇ]
from sys.dm_db_index_physical_stats(DB_ID('TEMPDB'), OBJECT_ID('tempdb..#BUF_TABLE5'), null, null, null) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;


ALTER index #EX_TKEY on #BUF_TABLE5 reorganize;
select ii.name[»Õƒ≈ —], ss.avg_fragmentation_in_percent[Ù‡„ÏÂÌÚ‡ˆËˇ]
from sys.dm_db_index_physical_stats(DB_ID('TEMPDB'), OBJECT_ID('tempdb..#BUF_TABLE5'), null, null, null) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;


ALTER index #EX_TKEY on #BUF_TABLE5 rebuild with (online = off);
select ii.name[»Õƒ≈ —], ss.avg_fragmentation_in_percent[Ù‡„ÏÂÌÚ‡ˆËˇ]
from sys.dm_db_index_physical_stats(DB_ID('TEMPDB'), OBJECT_ID('tempdb..#BUF_TABLE5'), null, null, null) ss join sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id where name is not null;

--«¿ƒ¿Õ»≈ 6
DROP index if exists #EX_TKEY on #BUF_TABLE5;
CREATE index #EX_TKEY on #BUF_TABLE5(TKEY) with (fillfactor = 65);

INSERT top(50)percent INTO #BUF_TABLE5(TKEY, TF) 
                                              SELECT TKEY, TF  FROM #BUF_TABLE5;
SELECT name [»Ì‰ÂÍÒ], avg_fragmentation_in_percent [‘‡„ÏÂÌÚ‡ˆËˇ (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),    
OBJECT_ID(N'#BUF_TABLE5'), NULL, NULL, NULL) ss  JOIN sys.indexes ii 
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;