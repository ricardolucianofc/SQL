CREATE TABLE #professores (
    id INT,
    professor VARCHAR(50),
    latitude REAL,
    longitude REAL,
    distancia_km FLOAT
)

INSERT INTO #professores (id, professor, latitude, longitude)
VALUES
(1, 'senac', -25.4413563, -49.2740054),
(2, 'terminal do portao', -25.4762913, -49.2948362),
(3, 'terminal da rui barbosa', -25.436289, -49.2760351),
(4, 'terminal de capao raso', -25.4920746, -49.2955984),
(5, 'terminal do PINH', -25.5126212, -49.2977603)

DECLARE @id INT = 1

SELECT TOP 10 
    P1.professor, 
    P1.latitude, 
    P1.longitude,
    ROUND(geography::Point(P1.latitude, P1.longitude, 4326).STDistance(geography::Point(P2.latitude, P2.longitude, 4326))/1000, 3) AS distancia_km
FROM #professores AS P1
CROSS APPLY (
    SELECT latitude, longitude
    FROM #professores
    WHERE id = @id
) AS P2
WHERE P1.id <> @id
ORDER BY distancia_km ASC

DROP TABLE #professores

Para melhorar a performance, podemos criar um índice espacial na coluna (latitude, longitude) da tabela professores:

CREATE SPATIAL INDEX idx_professores ON professores (latitude, longitude)

Com o índice espacial criado, o SQL Server pode utilizar técnicas de busca espacial eficientes para localizar rapidamente os professores próximos ao professor especificado pelo parâmetro @id.

***
--mysql
CREATE TABLE professores (
    id INT,
    professor VARCHAR(50),
    latitude FLOAT,
    longitude FLOAT,
    distancia_km FLOAT
);

INSERT INTO professores (id, professor, latitude, longitude)
VALUES
(1, 'senac', -25.4413563, -49.2740054),
(2, 'terminal do portao', -25.4762913, -49.2948362),
(3, 'terminal da rui barbosa', -25.436289, -49.2760351),
(4, 'terminal de capao raso', -25.4920746, -49.2955984),
(5, 'terminal do pinhais', -25.5126212, -49.2977603);

SET @id := 1;

SELECT 
    P1.professor, 
    P1.latitude, 
    P1.longitude,
    ROUND(ST_Distance_Sphere(point(P1.longitude, P1.latitude), point(P2.longitude, P2.latitude))/1000, 3) AS distancia_km
FROM professores AS P1
CROSS JOIN (
    SELECT latitude, longitude
    FROM professores
    WHERE id = @id
) AS P2
WHERE P1.id <> @id
ORDER BY distancia_km ASC
LIMIT 2;

