/**************************************************************************/
-- CHECK nos sirve para crear restricciones a nivel de campo
-- EL constraint es a nivel de tabla?
/**************************************************************************/

--CREATE TABLE Materias
--(
--	Cod_Materia Smallint IDENTITY(1,1) PRIMARY KEY,
--	Nombre varchar(30) NOT NULL,
--	Electiva bit NOT NULL DEFAULT (0),
--	Peso tinyint
--		CHECK (Peso > 0 AND -- ESTE CHECK VA A FALLAR POR QUE EL CAMPO ELECTIVA Y PESO SE CREAN AL MISMO TIEMPO, 
--		--Y NO ESTÁ PERMITIDO UTILIZAR EN LA RESTRICCION UN CAMPO DEL MISMO REGISTRO 
--				Peso <= (CASE ELECTIVA
--							WHEN 0 THEN 6
--							ELSE 2
--						END)
--				)
--);

/********************************************************************************************/
--COMO CORREGIR O CONSEGUIR LA RESTRICCION QUE QUEREMOS EN LA TABLA MATERIAS
/*******************************************************************************************/
-- CREAMOS LA TABLA MATERIAS CON LA UNICA RESTRICCION DE QUE EL PESO SEA MAYOR QUE 0.
CREATE TABLE Materias
(
	Cod_Materias Smallint IDENTITY(1,1) PRIMARY KEY,
	Nombre varchar(30) NOT NULL,
	Electiva bit NOT NULL DEFAULT (0),
	Peso tinyint NOT NULL DEFAULT (1) CHECK (Peso > 0)
);
-- UNA VEZ CREADA LA TABLA CREAMOS UNA RESTRICCION A NIVEL DE TABLA Y NO AL NIVEL DEL CAMPO PESO. AUNQUE AFECTE DE LA MISMA FORMA
ALTER TABLE Materias
	ADD CONSTRAINT CheckPesoMateria
	CHECK (Peso <= (CASE Electiva WHEN 0 THEN 6	ELSE 2 END));
/******************************************
**************************************************/

CREATE TABLE Cursos
(
	Cod_Curso int IDENTITY(1,1) PRIMARY KEY,
	Cod_Prof Smallint FOREIGN KEY REFERENCES Profesores (Cod_Prof)
		ON DELETE SET NULL,
	Cod_Materia Smallint FOREIGN KEY REFERENCES Materias(Cod_Materias)
		ON DELETE CASCADE,
	Aula int NOT NULL,
	Hora_Inicio time NOT NULL,
	Hora_Fin time NOT NULL,
	Duracion_Min AS (DATEDIFF(MINUTE, Hora_Inicio,Hora_Fin))
	--no definimos el tipo de dato
);
ALTER TABLE Cursos
	ADD CONSTRAINT CheckHoras
	CHECK (Hora_Inicio < Hora_Fin);

ALTER TABLE Cursos
	ADD Activo bit NOT NULL
	DEFAULT (1);