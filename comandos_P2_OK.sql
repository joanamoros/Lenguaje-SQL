/* 1) Mostrar el nombre, apellidos y email de los empleados 
cuyo trabajo sea de vendedor (es decir que job_id sea SA_REP).*/

SELECT FIRST_NAME, LAST_NAME, EMAIL
FROM HR_EMPLOYEES E
WHERE E.JOB_ID = 'SA_REP'


/* 2) Dar una lista con el nombre y apellidos de empleados que no 
tengan comisión asignada (COMMISSION_PCT).*/

SELECT FIRST_NAME, LAST_NAME
FROM HR_EMPLOYEES
WHERE COMMISSION_PCT IS NULL


/* 3) Obtener una lista donde se indique cuántos empleados 
tienen comisión y cuántos no.*/

SELECT 'Empleados que tienen comisión' AS OBSERVACIÓN, COUNT (*) AS NÚMERO
FROM HR_EMPLOYEES E
WHERE COMMISSION_PCT IS NOT NULL
UNION
SELECT 'Empleados que no tienen comisión' AS OBSERVACIÓN, COUNT (*) AS NÚMERO
FROM HR_EMPLOYEES E
WHERE COMMISSION_PCT IS NULL


/* 4) Obtener una lista de empleados con nombre, apellidos 
y salarios de éstos ordenada de mayor a menor salario.*/

SELECT FIRST_NAME, LAST_NAME, SALARY
FROM HR_EMPLOYEES
ORDER BY SALARY DESC


/* 5) Realizar una lista como la anterior añadiendo además la 
columna correspondiente al nombre del departamento.*/

SELECT FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_NAME
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY SALARY DESC


/* 6) Obtener una lista de aquellos apellidos de empleados que no 
comiencen por la letra a ni terminen por la letra t, pero que contengan 
la letra i ordenada alfabéticamente por apellido.*/

SELECT LAST_NAME
FROM HR_EMPLOYEES
WHERE LAST_NAME NOT LIKE 'A*' AND LAST_NAME NOT LIKE '*T' AND LAST_NAME LIKE '*I*'
ORDER BY LAST_NAME


/* 7) Obtener una lista de aquellos apellidos de empleados que están 
repetidos y no terminen por la letra t, indicando el número de repeticiones.*/

SELECT LAST_NAME AS Apellidos, COUNT (*) AS Cuántos
FROM HR_EMPLOYEES
WHERE LAST_NAME NOT LIKE '*T'
GROUP BY LAST_NAME


/* 8) Obtener una lista con los apellidos, salario y nombre del departamento 
de los empleados directores de departamento ordenada por el nombre del 
departamento del cual sean director.*/

SELECT D.DEPARTMENT_NAME AS [Nombre del Departamento], E.LAST_NAME AS [Apellidos], E.SALARY AS [Salario]
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND E.EMPLOYEE_ID = D.MANAGER_ID
ORDER BY D.DEPARTMENT_NAME


/* 9) Obtener una lista con los nombres y apellidos de los directores de 
departamento que superen el salario medio de los directores de departamento 
de la empresa, indicando también el nombre del país dónde el departamento está ubicado.*/

SELECT E.FIRST_NAME AS Nombre, E.LAST_NAME AS Apellido, C.COUNTRY_NAME AS País
FROM HR_EMPLOYEES E, HR_DEPARTMENTS D, HR_COUNTRIES C, HR_LOCATIONS L
WHERE (E.EMPLOYEE_ID = D.MANAGER_ID AND D.LOCATION_ID = L.LOCATION_ID AND L.COUNTRY_ID = C.COUNTRY_ID 
AND E.SALARY > (SELECT AVG(E2.SALARY) FROM HR_EMPLOYEES E2, HR_DEPARTMENTS AS D2 WHERE E2.EMPLOYEE_ID = D2.MANAGER_ID))


/* 10) Obtener una lista con los nombres de los departamentos con las ciudades, 
nombre de país y nombre de la región a donde pertenezcan.*/

SELECT D.DEPARTMENT_NAME AS [Nombre del Departamento], L.CITY AS Ciudad, C.COUNTRY_NAME AS [Nombre del País], 
R.REGION_NAME AS [Nombre de la región]
FROM HR_DEPARTMENTS AS D, HR_LOCATIONS AS L, HR_COUNTRIES AS C, HR_REGIONS AS R
WHERE D.LOCATION_ID = L.LOCATION_ID AND L.COUNTRY_ID = C.COUNTRY_ID AND C.REGION_ID = R.REGION_ID


/* 11) Obtener una lista con los nombres y apellidos de los empleados, así como 
el nombre de su categoría laboral y el salario máximo de ésta, ordenado 
por el mencionado salario. */

SELECT E.FIRST_NAME AS [Nombre], E.LAST_NAME AS [Apellidos], J.JOB_TITLE AS [Categoría laboral], 
J.MAX_SALARY AS [Salario Máximo]
FROM HR_EMPLOYEES E, HR_JOBS J
WHERE E.JOB_ID = J.JOB_ID
ORDER BY J.MAX_SALARY


/* 12) Obtener una lista de categoría laborales indicando: el código y nombre 
de ésta, así como el número de empleados que pertenecen, el mayor salario pagado, 
el menor salario pagado, el salario medio todo ello referente a la mencionada categoría laboral.*/

SELECT J.JOB_ID AS [Categoría Laboral], J.JOB_TITLE AS Nombre, MIN(E.SALARY) AS [Salario Mínimo], 
MAX(E.SALARY) AS [Salario Máximo], AVG(E.SALARY) AS [Salario Medio], COUNT(*) AS [Número de empleados que pertenecen al departamento]
FROM HR_JOBS AS J, HR_EMPLOYEES AS E
WHERE E.JOB_ID = J.JOB_ID
GROUP BY J.JOB_ID, J.JOB_TITLE


/* 13) Obtener una lista con los nombres y apellidos de los empleados, así como 
el nombre y apellidos de su supervisor (mánager) ordenada por el salario 
de menor a mayor de este último.*/

SELECT E.FIRST_NAME AS [Nombre del Empleado], E.LAST_NAME AS [Apellidos del Empleado], 
M.FIRST_NAME AS [Nombre del Director], M.LAST_NAME AS [Apellidos del Director], M.SALARY AS Salario
FROM HR_EMPLOYEES AS E, HR_EMPLOYEES AS M
WHERE M.EMPLOYEE_ID = E.MANAGER_ID
ORDER BY M.SALARY


/* 14) Obtener una lista con los nombres de los departamentos indicando el montante 
de salarios que ese departamento paga a sus empleados.*/

SELECT D.DEPARTMENT_NAME AS [Nombre del Departamento], SUM (E.SALARY) AS [Salario Total]
FROM HR_DEPARTMENTS AS D, HR_EMPLOYEES AS E
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME


/* 15) Seleccionar los empleados que no sean supervisores de nadie dando sus apellidos y 
nombre separados por coma, así como el nombre del departamento para el cual trabajan.*/

SELECT E.LAST_NAME & ", " & E.FIRST_NAME AS [Nombre Completo], D2.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM (HR_EMPLOYEES AS E LEFT JOIN HR_DEPARTMENTS AS D 
ON E.EMPLOYEE_ID = D.MANAGER_ID) LEFT JOIN HR_DEPARTMENTS AS D2 
ON E.DEPARTMENT_ID = D2.DEPARTMENT_ID
WHERE D.MANAGER_ID IS NULL;


/* 16) Obtener una lista con los nombres de departamento, el número de empleados, 
el salario máximo, el mínimo, así como el promedio de cada uno de estos departamentos 
ordenados según el salario medio de mayor a menor.*/

SELECT D.DEPARTMENT_NAME AS [Nombre del Departamento], ROUND(AVG(E.SALARY), 2) AS [Sueldo Medio], 
MIN(E.SALARY) AS [Salario Mínimo], MAX(E.SALARY) AS [Salario Máximo], COUNT (*) AS Cuántos
FROM HR_DEPARTMENTS D, HR_EMPLOYEES E
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
ORDER BY AVG(E.SALARY) DESC


/* 17) Obtener el número de empleados contratados entre los años 1995 y 1999.*/

SELECT 'Número de empleados contratados' AS Observación, COUNT (*) AS NÚMERO
FROM HR_EMPLOYEES
WHERE HIRE_DATE >= #01/01/1995# AND HIRE_DATE <= #31/12/1999#


/* 18) Obtener el número de países que tiene cada región, indicando el código y nombre de ésta.*/

SELECT R.REGION_ID AS [Código de la región], REGION_NAME AS [Nombre de la región], 
COUNT (C.COUNTRY_ID) AS [Número de países]
FROM HR_REGIONS R, HR_COUNTRIES C
WHERE R.REGION_ID = C.REGION_ID
GROUP BY R.REGION_ID, REGION_NAME


/* 19) Obtener una lista de ciudades junto al nombre de país y nombre de la 
región a donde pertenezcan, en la cual se indique el número de departamentos que ésta 
aloja. La lista ha de estar ordenada de mayor a menor número de departamentos.*/

SELECT L.CITY AS Ciudad, C.COUNTRY_NAME AS País, R.REGION_NAME AS Región, COUNT (*) AS [Número de departamentos]
FROM HR_DEPARTMENTS AS D, HR_LOCATIONS AS L, HR_COUNTRIES AS C, HR_REGIONS AS R
WHERE D.LOCATION_ID = L.LOCATION_ID AND L.COUNTRY_ID = C.COUNTRY_ID AND C.REGION_ID = R.REGION_ID
GROUP BY L.CITY, C.COUNTRY_NAME, R.REGION_NAME
ORDER BY COUNT(*) DESC


/* 20) Obtener la lista de ciudades en las que no se aloja ningún departamento de 
la empresa incluyendo el nombre de país y nombre de la región.*/

SELECT L.CITY AS Ciudad, (SELECT C.COUNTRY_NAME FROM HR_COUNTRIES AS C WHERE C.COUNTRY_ID = L.COUNTRY_ID) AS País, 
(SELECT R.REGION_NAME FROM HR_REGIONS AS R WHERE R.REGION_ID = 
(SELECT C.REGION_ID FROM HR_COUNTRIES AS C WHERE C.COUNTRY_ID = L.COUNTRY_ID)) AS Región
FROM HR_LOCATIONS AS L 
WHERE ((SELECT COUNT (D.LOCATION_ID) FROM HR_DEPARTMENTS AS D WHERE D.LOCATION_ID = L.LOCATION_ID) = 0)


/* 21) Realizar una relación con los nombres de los directores de los departamentos ordenado 
por apellidos, esta única columna se llamará Nombre Completo, apareciendo apellidos una coma y el nombre.*/

SELECT E.LAST_NAME + ", " + E.FIRST_NAME AS [Nombre Completo]
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND E.EMPLOYEE_ID =
D.MANAGER_ID
ORDER BY E.LAST_NAME


/* 22) Obtener nombre, apellidos, salario y nombre del departamento de aquellos empleados que, 
no siendo jefes de departamento, superen el salario medio del departamento para el cual trabajan.*/

SELECT E.FIRST_NAME AS Nombre, E.LAST_NAME AS Apellido, E.SALARY AS Salario, 
D.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D
WHERE (E.DEPARTMENT_ID = D.DEPARTMENT_ID) AND (E.EMPLOYEE_ID <> D.MANAGER_ID) 
AND (E.SALARY > (SELECT AVG(E2.SALARY) FROM HR_EMPLOYEES AS E2
WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID))


/* 23) Realizar una lista de códigos de departamento y nombre de éstos de tal manera 
que ningún empleado trabaje en ellos y otra que sí tengan algún empleado.*/

SELECT D.DEPARTMENT_ID AS [Código del Departamento], D.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM HR_DEPARTMENTS AS D
WHERE D.DEPARTMENT_ID NOT IN (SELECT E.DEPARTMENT_ID FROM
HR_EMPLOYEES AS E WHERE E.DEPARTMENT_ID IS NOT NULL)
UNION
SELECT D.DEPARTMENT_ID AS [Código del Departamento], D.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM HR_DEPARTMENTS AS D
WHERE D.DEPARTMENT_ID IN (SELECT E.DEPARTMENT_ID FROM HR_EMPLOYEES AS E WHERE E.DEPARTMENT_ID IS NOT NULL)


/*24) Obtener por cada tipo de trabajo (JOB_ID), indicando también su nombre (JOB_TITLE), 
el salario más alto pagado (es decir cuál es el importe pagado a aquel empleado que más gana).*/

SELECT J.JOB_ID AS [Tipo de trabajo], J.JOB_TITLE AS Nombre, MAX(E.SALARY) AS [Salario más Alto]
FROM HR_JOBS AS J
LEFT JOIN HR_EMPLOYEES AS E ON J.JOB_ID = E.JOB_ID
GROUP BY J.JOB_ID, J.JOB_TITLE;


/* 25) Obtener nombre, apellidos, salario y nombre del departamento de aquellos empleados que 
superen el 90% del salario del jefe de su departamento.*/

SELECT E.FIRST_NAME AS Nombre, E.LAST_NAME AS Apellido, E.SALARY AS Salario, 
D.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM HR_EMPLOYEES AS E
LEFT JOIN HR_DEPARTMENTS AS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.MANAGER_ID IS NOT NULL 
AND E.SALARY > 0.9*(SELECT E1.SALARY FROM HR_EMPLOYEES AS E1 WHERE E1.EMPLOYEE_ID = D.MANAGER_ID)
  
  
/* 26) Obtener nombre, apellidos, salario y nombre del departamento de aquellos empleados que 
trabajen en un departamento alojado en una ciudad en la cual estén alojados otros departamentos 
de la empresa (lo cual significa que en esa ciudad habrá al menos dos departamentos alojados) 
y además superen el salario medio del departamento para el cual trabajan.*/

SELECT E.FIRST_NAME AS Nombre, E.LAST_NAME AS Apellido, E.SALARY AS Salario, D.DEPARTMENT_NAME AS [Nombre del Departamento]
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D, HR_LOCATIONS AS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND E.SALARY > (SELECT AVG(E2.SALARY) FROM HR_EMPLOYEES AS E2 WHERE E2.DEPARTMENT_ID = E.DEPARTMENT_ID)
AND L.CITY IN (SELECT L2.CITY FROM HR_DEPARTMENTS AS D2, HR_LOCATIONS AS L2 WHERE D2.LOCATION_ID = L2.LOCATION_ID 
GROUP BY L2.CITY HAVING COUNT(*) >= 2);


/* 27) Obtener una lista de empleados que incluya una columna con su nombre y 
apellidos (estos dos campos serán una cadena única estando separados por una coma) 
y otra con el número de compañeros que tengan el mismo trabajo que éste. 
Esta lista debe ordenarse alfabéticamente según el nombre de departamento al cual pertenezca, 
de la “A” a la “Z”. Esta lista solo afectará a empleados asignados a algún departamento.*/

SELECT D.DEPARTMENT_NAME AS [Nombre del Departamento], E.LAST_NAME & ", " & E.FIRST_NAME AS [Nombre Completo], 
(
	SELECT COUNT(*) 
	FROM HR_EMPLOYEES AS E1 
	WHERE E1.JOB_ID = E.JOB_ID AND E1.EMPLOYEE_ID <> E.EMPLOYEE_ID
) AS [Número de Compañeros]
FROM HR_EMPLOYEES AS E, HR_DEPARTMENTS AS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY D.DEPARTMENT_NAME;


/* 28) Dar una lista con el nombre y apellidos de los empleados cuyo trabajo actual tenga 
un salario máximo menor a 10000 €, incluyendo el nombre y apellidos de su supervisor. 
Esta lista solo debe incluir a empleados pertenecientes a algún departamento cuyo salario 
sea mayor que el salario promedio de todos sus compañeros de departamento con igual trabajo que éste.*/

SELECT E.FIRST_NAME AS [Nombre], E.LAST_NAME AS [Apellido], (SELECT E1.LAST_NAME & ", " & E1.FIRST_NAME 
FROM HR_EMPLOYEES AS E1 WHERE E1.EMPLOYEE_ID = E.MANAGER_ID) AS [Jefe]
FROM HR_EMPLOYEES AS E, HR_JOBS AS J
WHERE E.JOB_ID = J.JOB_ID AND J.MAX_SALARY < 10000 AND E.DEPARTMENT_ID IS NOT NULL AND E.SALARY > (
	SELECT AVG(E2.SALARY)
	FROM HR_EMPLOYEES AS E2
	WHERE E2.JOB_ID = E.JOB_ID AND E2.DEPARTMENT_ID = E.DEPARTMENT_ID
)
ORDER BY E.LAST_NAME, E.FIRST_NAME;






