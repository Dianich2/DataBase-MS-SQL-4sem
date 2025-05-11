Declare @groups int = 1
while 1 = 1
begin
	print 'Ãğóïïà ' + cast(@groups as varchar(3))
	set @groups = @groups + 1
	if @groups > 10 return
end