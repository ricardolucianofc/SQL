use meu_db

Declare @pesquisar_nome as nvarchar(max) = 'digite aqui parte do texto que procura'

--Busca em View e Table
SELECT 
     C.name AS Valor_Encontrado,
	 Case T.XTYPE when 'V' then 'View' when 'U' then 'Table' else '?' end as Tipo,
	 T.name AS Nome 
FROM 
     sys.sysobjects AS T (NOLOCK) 
INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id 
WHERE 
     C.NAME LIKE concat('%',@pesquisar_nome,'%')
order by 1,2,3

--Busca em SP, Function, Trigger e View
SELECT  A.Text as Valor_Encontrado,
case type when 'P' then 'Stored procedure'
when 'FN' then 'Function'
when 'TF' then 'Function'
when 'TR' then 'Trigger'
when 'V' then 'View'
else 'Outros Objetos'
end as Tipo, B.name as Nome
FROM syscomments A (nolock)
JOIN sysobjects B (nolock) on A.Id = B.Id
WHERE A.Text like concat('%',@pesquisar_nome,'%')
order by 2,3,1

-- Procura dentro de Job's
SELECT name NOME_JOB, step_name ,command CODIGO, last_run_date
FROM msdb.dbo.sysjobs A
join msdb.dbo.sysjobsteps B on A.Job_id = B.Job_Id
WHERE command like concat('%',@pesquisar_nome,'%')
ORDER BY name


