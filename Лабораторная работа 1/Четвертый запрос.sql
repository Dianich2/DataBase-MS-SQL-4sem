SELECT *
FROM [dbo].[ЗАКАЗЫ]
WHERE [dbo].[ЗАКАЗЫ].Заказчик IN ('СВИПТРЕЙД')
Order by [dbo].[ЗАКАЗЫ].Дата_поставки