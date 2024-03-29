USE [WEB]
GO
/****** Object:  UserDefinedFunction [dbo].[FC_BLOB_to_BASE64]    Script Date: 08/04/2022 10:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[FC_BLOB_to_BASE64](
	@valor VARBINARY(MAX)
)
RETURNS VARCHAR(MAX) AS
BEGIN

DECLARE @retorno VARCHAR(MAX)
SELECT @retorno = CONCAT('data:image/jpeg;base64,',CAST('' AS XML).value('xs:base64Binary(sql:variable("@valor"))', 'varchar(max)'))
RETURN (@retorno)

END