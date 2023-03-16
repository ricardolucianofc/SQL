SELECT TOP 1 REPLACE(REPLACE(REPLACE((

SELECT campo AS XXX FROM TABELA

FOR XML RAW('YYY')),'<YYY XXX="','' ),'"/>',', ') + '..', ', ..', '') AS Resultado

--

SELECT STUFF((SELECT ', ' + cidade FROM cidades FOR XML PATH('')), 1, 2, '') AS todas_cidades;
