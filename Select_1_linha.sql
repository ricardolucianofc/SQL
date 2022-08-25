SELECT TOP 1 REPLACE(REPLACE(REPLACE((

SELECT campo AS XXX FROM TABELA

FOR XML RAW('YYY')),'<YYY XXX="','' ),'"/>',', ') + '..', ', ..', '') AS Resultado