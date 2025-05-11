Declare @z float(5),
		@t float(5),
		@x float(5)
set @t = 90
set @x = 7
set @z = case
when(@t > @x) then Power(sin(@t), 2)
when(@t < @x) then 4 * (@t + @x)
else 1 - exp(@x - 2)
end
print cast (@z as varchar(10)) + char(13)


Declare @FIO varchar(max) = 'Макейчик Татьяна Леонидовна',
		@SmallFIO varchar(max),
		@buf varchar(max)
set @buf = @FIO
set @buf = SUBSTRING(@buf, CHARINDEX(' ', @buf) + 1, Len(@buf) - CHARINDEX(' ', @buf))
set @SmallFIO = SUBSTRING(@FIO, 1, CHARINDEX(' ', @FIO)) + ' '
set @SmallFIO = @SmallFIO + SUBSTRING(@buf, 1, 1) + '. '
set @buf = SUBSTRING(@buf, CHARINDEX(' ', @buf) + 1, Len(@buf) - CHARINDEX(' ', @buf))
set @SmallFIO = @SmallFIO + SUBSTRING(@buf, 1, 1) + '.'
print @SmallFIO


select *, (cast(DATEDIFF(MONTH ,s.BDAY,GETDATE()) / 12 as varchar(10)) + ' years and ' + cast(DATEDIFF(MONTH ,s.BDAY,GETDATE()) % 12 as varchar(10)) + 'months')[Age] from STUDENT s 
where Month(s.BDAY) = Month(GETDATE()) + 1;

Declare @studGroup int = 2,
		@subject varchar(max) = 'ОАиП'
select distinct DATENAME(WEEKDAY, p.PDATE)[DayOfWeek] from PROGRESS p inner join STUDENT s
on p.IDSTUDENT = s.IDSTUDENT where s.IDGROUP = @studGroup and p.SUBJECT = @subject