/* 1 CONDICION: Usuarios con mayor reputaci�n.

1. Seleccionar columnas DisplayName, location, Reputation.
2. Ordenar los resultados por la columna Reputaci�n de forma desc.
3. Presentar los resultados en una tabla mostrando solo las columnas DisplayName, Location, Reputation.*/

SELECT DisplayName, Location, Reputation
FROM Users
ORDER BY Reputation DESC;

/* 2 CONDICION: Usuarios que publicaron para aquellos posts que tienen un propietario.

1. Seleccionar columna Title de la Posts JUNTO con el DisplayName (unir las tablas Posts y Users Utilizando OwnerUserId)
2. Presentar los resultados en una tabla ostrando las columnas Title y DisplayName.*/

SELECT Posts.Title, Users.DisplayName
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id;

/* 3 CONDICION: -
1. Calcular el promedio de Score de los Posts por cada Usuario y mostrar el DisplayName del usuario con el promedio de Score (Agrupar los posts por OwnerUserId).
2. Presentar los resultados en una tabla mostrando las columnas DisplayName y el promedio de Score
*/

SELECT Users.DisplayName, AVG(Posts.Score) AS AverageScore
FROM Posts
JOIN Users ON Posts.OwnerUserId = Users.Id
GROUP BY Users.DisplayName;

/* 4 CONDICION: Usuarios 

1. Encuentra el DisplayName (Utilizar una subconsulta para calcular el total de comentarios por usuarios y filtrar aquellos que han realizado m�s de 100 comentarios en total).
2. Presentar los resultados en una tabla mostrando el DisplayName de los usuarios

*/

SELECT DisplayName
FROM Users
WHERE Id IN (
    SELECT OwnerUserId
    FROM Posts
    GROUP BY OwnerUserId
    HAVING COUNT(*) > 100
);

/* 5 CONDICION: Ubicaciones Vac�as de la tabla Users

1. Actualizar la columna Location de la Tabla Users cambiando todas las ubicaciones vac�as por Desconocido (Utilizar una consulta de actualizaci�n para cambiar las ubicaciones vac�as).
2. Mostrar un mensaje indicando que la actualizaci�n se realiz� correctamente.

*/

UPDATE Users
SET Location = 'Desconocido'
WHERE Location IS NULL OR Location = ''
SELECT 'Actualizaci�n realizada correctamente' AS Message;

/* 6 CONDICION: Usuarios con menos de 100 de reputaci�n.

1. Eliminar todos los comentarios realizados por usuarios con menos de 100 de reputaci�n (Utilizar una consulta de eliminaci�n por usuarios para eliminar todos los comentarios realizados).
2. Mostrar un mensaje indicando cu�ntos comentarios fueron eliminados (en total o por user, up to you).
*/

DELETE FROM Comments
WHERE UserId IN (
    SELECT Id
    FROM Users
    WHERE Reputation < 100
);

/* 7 CONDICION: -

1. Mostrar, por usuario, el n�mero total de publicaciones (Posts), Comentarios (Comments) y medallas (Bagdes) que han realizados (Utilizar uniones JOIN para combinar la informaci�n de las tablas Posts, Comments y Badges).
2. Presentar los resultados en una tabla mostrando el DisplayName del usuario junto con el total de publicaciones, comentarios y medallas.
*/

SELECT 
    u.DisplayName,
    (SELECT COUNT(*) 
     FROM Posts p 
     WHERE p.OwnerUserId = u.Id) AS TotalPosts,
    (SELECT COUNT(*) 
     FROM Comments c 
     WHERE c.UserId = u.Id) AS TotalComments,
    (SELECT COUNT(*) 
     FROM Badges b 
     WHERE b.UserId = u.Id) AS TotalBadges
FROM Users u;

/* 8 CONDICION: Publicaciones m�s populares.

1. Mostrar las 10 publicaciones m�s populares basadas en la puntuaci�n (Score) de la tabla Posts.
2. Ordenar las publicaciones por puntuaci�n de forma desc y seleccionar solo las 10 primeras. 
3. Presentar los resultados en una tabla mostrando en una tabla mostrando el Title de la publicaci�n y su puntaci�n*/

SELECT TOP 10 Title, Score
FROM Posts
ORDER BY Score DESC;

/*CONDICI�N: Comentarios m�s recientes

1. Mostrar los 5 comentarios m�s recientes de la tabla Comments.
2. Ordenar los comentarios por fecha de creaci�n de forma desc y seleccionar los 5 primeros.
3. Presentar los resultados en una  tabla mostrando el Text del comentarios y la fecha de creaci�n.*/

SELECT TOP 5 Text, CreationDate
FROM Comments
ORDER BY CreationDate DESC;