USE [UNIVER]
GO
/****** Object:  StoredProcedure [dbo].[PSUBJECT]    Script Date: 13.04.2025 21:13:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PSUBJECT] @p varchar(20) = null, @c int output
as
begin
declare @count int = (select count(*) from SUBJECT);
select s.SUBJECT[код], s.SUBJECT_NAME[дисциплина], s.PULPIT[кафедра] from SUBJECT s where s.PULPIT = @p;
set @c = @@ROWCOUNT
return @count;
end;