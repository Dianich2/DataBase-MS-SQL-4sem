begin try
	declare @x int
	set @x = 2 / 0
end try
begin catch
	print '��� ������ ' + cast(Error_Number() as varchar)
	print '��������� �� ������ ' + Error_Message()
	print '����� ������ � ������� ' + cast(Error_Line() as varchar)
	if Error_Procedure() is not null print '��� ��������� ' + Error_Procedure()
	else print '������ ������� �� � ���������'
	print '������� ����������� ' + cast(Error_Severity() as varchar)
	print '����� ������ ' + cast(Error_State() as varchar)
end catch