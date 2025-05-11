DECLARE @i char = 'D',
		@a varchar = 'P',
		@b datetime,
		@c time,
		@d int,
		@e smallint,
		@f tinyint,
		@g numeric(12, 5)
Set @b = '2025-03-13'
set @c = '19:31:00'
set @d = 18
Select @e = 9, @f = 1, @g = 2222222.22

select @b[datetime], @c[time], @d[int], @e[smallint]
print 'Char ' + @i
print 'Varchar ' + @a
print 'Tinyint ' + cast(@f as varchar(10))
print 'Numeric(12, 5) ' + cast(@g as varchar(13))
