select * from AUDITORIUM;
print '����� ������������ ����� ' + cast(@@ROWCOUNT as varchar(10)) + char(13)
print '������ SQL Server ' + cast(@@VERSION as varchar(max)) + char(13)
print '��������� ������������� ��������, ����������� �������� �������� ����������� ' + cast(@@SPID as varchar(max)) + char(13)
Begin Try
declare @error int = 5 / 0
end Try
begin catch
print '��� ��������� ������ ' + cast(@@ERROR as varchar(max)) + ' ���������: ' + Error_Message() + char(13)
end catch
print '��� ������� ' + cast(@@SERVERNAME as varchar(max)) + char(13)
Begin Tran
print '������� ����������� ���������� ' + cast(@@TRANCOUNT as varchar(max)) + char(13)
Commit Tran
print '�������� ������� ���������� ����� ��������������� ������ ' + cast(@@FETCH_STATUS as varchar(max)) + char(13)
Drop procedure If exists CheckLevelOfProcedure
go
Create procedure CheckLevelOfProcedure
as
begin
print '��� ��� ���������. ������� ����������� ������� ��������� ' + cast(@@NESTLEVEL as varchar(max))
end
go
exec CheckLevelOfProcedure




