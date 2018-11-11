Use tempdb;

-- CREACIÓN DE TABLAS
CREATE TABLE Facturas(Factura INT, Cliente INT, Fecha DATETIME,Total Money default(0));
CREATE TABLE Facturas_Detalles(Factura INT, Detalle INT ,Producto VarChar(10),Total Money);

-- CREACIÓN DEL TRIGGER
CREATE TRIGGER Detalles_Modificados
ON Facturas_Detalles
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
	UPDATE Facturas
	SET Total =Total + Total_Detalles
	FROM
	(
		SELECT Factura AS Fac,SUM(Total) AS Total_Detalles
		FROM
			(
				SELECT Factura, Total FROM Inserted
				UNION ALL
				SELECT Factura, -Total FROM Deleted
			) T
		GROUP BY Factura
	) A
	WHERE Factura = Fac;
END;

------------------------------------
Select * from Facturas;
Select * from Facturas_Detalles;
------------------------------------

---------Creación de las Facturas----------
INSERT INTO Facturas (Factura,Cliente,Fecha) 
VALUES (1,10,'20171005'),
		(2,15,'20171005');

Select * from Facturas;

INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) VALUES (1, 1,'Bici-roja',100);

Select * From Facturas;
Select * From Facturas_Detalles;

/*INSERTAR MULTIPLES DETALLES EN LA 1 FACTURA*/
INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) 
VALUES (2, 1,'Bici-roja',100),
		(2, 2,'Gafas',25),
		(2, 3,'Guantes',20);

Select * From Facturas;
Select * From Facturas_Detalles;

-- creacion de detalles en diferentes facturas

INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) 
VALUES (1, 2,'Bici-roja',100),
		(1, 3,'Gafas',25),
		(2, 4,'Guantes',10);

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;


-- creacion de detalles en diferentes facturas en instrucciones separadas
BEGIN TRANSACTION;
	INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) VALUES (1, 2,'Bici-roja',100)
	INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) VALUES (1, 3,'Gafas',25)
	INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) VALUES (2, 4,'Guantes',10);
COMMIT;

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;

-- Modificacion de los detalles de la factura
UPDATE Facturas_Detalles
SET Total = 15
WHERE Producto = 'Gafas'

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;
-------------------------------------------------------------
UPDATE Facturas_Detalles
SET Total = Total * .9
WHERE Factura = 1 AND Detalle = 2

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;

-------------------------------------------------------------
-- Eliminación de Facturas_Detalles

DELETE Facturas_Detalles
WHERE Producto = 'Bici-Roja'

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;


DELETE Facturas_Detalles
WHERE Producto = 'Guantes'

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;

-- MODIFICACION DEL TRIGGER Y LA IMPORTANCIA DEL UNION ALL

ALTER TRIGGER Detalles_Modificados
ON Facturas_Detalles
AFTER UPDATE, INSERT, DELETE
AS
BEGIN
	UPDATE Facturas
	SET Total =Total + Total_Detalles
	FROM
	(
		SELECT Factura AS Fac,SUM(Total) AS Total_Detalles
		FROM
			(
				SELECT Factura, Total FROM Inserted
				UNION
				SELECT Factura, -Total FROM Deleted
			) T
		GROUP BY Factura
	) A
	WHERE Factura = Fac;
END;
--PARA ELIMINAR LOS DATOS DE LAS TABLAS SIN PREGUNTAS
TRUNCATE TABLE Facturas;
TRUNCATE TABLE Facturas_Detalles;

Select * From Facturas;
Select * From Facturas_Detalles ORDER BY Factura,Detalle;

-- CREAMOS LAS MISMAS FACTURAS

INSERT INTO Facturas (Factura,Cliente,Fecha) 
VALUES (1,10,'20171005'),
		(2,15,'20171005');

Select * from Facturas;


Select * From Facturas;
Select * From Facturas_Detalles;

/*INSERTAR MULTIPLES DETALLES EN LA 1 FACTURA*/
INSERT INTO Facturas_Detalles(Factura, Detalle, Producto, Total) 
VALUES (2, 1,'Bici-roja',100),
		(2, 2,'Gafas',25),
		(2, 3,'Guantes',25);

Select * From Facturas;
Select * From Facturas_Detalles;

--------------------- PROBLEMA -----------------------
 SELECT Factura, Total FROM Inserted
 SELECT Factura, - Total From Deleted
 ------------ Simulamos la tabla Inserted ---------------
 CREATE TABLE Insertados (Factura INT, Total Money);
 INSERT INTO Insertados (Factura, Total)
			VALUES  (2, 100),
					(2, 25),
					(2, 25);
SELECT * FROM Insertados;
------------ Simulamos la tabla deleted----------------

CREATE TABLE Eliminados(Factura INT, Total Money);
SELECT * FROM Eliminados;

------- DIFERENCIAS ENTRE UNION Y UNION ALL ------------
SELECT Factura, Total FROM Insertados
UNION -- operacion de conjuntos, borra los elementos repetidos
SELECT Factura, -Total FROM Eliminados;

SELECT Factura, Total FROM Insertados
UNION ALL -- todos, no importa que estén repetidos
SELECT Factura, - Total FROM Eliminados

-- hacemos limpieza de las tablas

DROP TABLE Facturas;
DROP TABLE Facturas_Detalles;
-- DROP TRIGGER Detales_Modificados;
DROP TABLE Insertados;
DROP TABLE Eliminados;
