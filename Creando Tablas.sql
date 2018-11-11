CREATE DATABASE Academia;

USE Academia;

CREATE TABLE  Paises
(
	Cod_Pais char(2) PRIMARY KEY CHECK (LEN(Cod_Pais)=2),
	Nombre varchar (50) NOT NULL,
	Cod_ISO3 char(3) NOT NULL UNIQUE CHECK (LEN(Cod_ISO3)=3),
	Cod_Telefónico smallint -- entero de 2 bytes.
);

/*****************************************************************************
OTRA FORMA DE CREARLAS, ES CREAR LA TABLA Y DESPUES METER LAS CONDICIONES
*****************************************************************************/

--CREATE TABLE  Paises
--(
--	Cod_Pais char(2) NOT NULL,
--	Nombre varchar (50) NOT NULL,
--	Cod_ISO3 char(3) NOT NULL,
--	Cod_Telefónico smallint -- entero de 2 bytes.
--);

--ALTER TABLE Paises ADD PRIMARY KEY (Cod_Pais);
--ALTER TABLE Paises ADD CONSTRAINT CK_Cod_Pais CHECK (LEN(Cod_Pais)=2);
--ALTER TABLE Paises ADD CONSTRAINT CK_Cod_ISO CHECK (LEN(Cod_ISO3)=3);

/*****************************************************************************
CREAR UNA TABLA CON UNA REFERENCIA Y USAR LAS FOREIGN KEY
*****************************************************************************/

CREATE TABLE Estados
(
	Cod_Estado char(2) PRIMARY KEY CHECK (LEN(Cod_Estado)=2),
	Cod_Pais char(2) FOREIGN KEY REFERENCES Paises(Cod_Pais)
					ON UPDATE CASCADE
					ON DELETE CASCADE,
	Nombre varchar(50) NOT NULL,
	Cod_Telefonico smallint
);

--CREATE TABLE Estados
--(
--	Cod_Estado char(2) NOT NULL,
--	Cod_Pais char(2) NOT NULL,
--	Nombre varchar(50) NOT NULL,
--	Cod_Telefonico smallint
--);

/*****************************************************************************
EL WITH CHECK CHEQUEA QUE LOS REGISTROS EXISTENTES CUMPLAN ESAS CONDICONES 
Y SI HAY ALGUN DATO QUE NO PUEDA CUMPIRLA NO SE CREARA LA FOREING KEY
*****************************************************************************/

--ALTER TABLE Estados ADD PRIMARY KEY CHECK (Cod_Estado));
--ALTER TABLE Estados ADD CONSTRAINT CK_Cod_Estado CHECK (LEN(Cod_Estado)=2);
--ALTER TABLE Estados WITH CHECK ADD FOREIGN KEY (Cod_Pais)
--					REFERENCES Paises(Cod_Pais)
--					ON UPDATE CASCADE
--					ON DELETE CASCADE;

CREATE TABLE Academias
(
	Cod_Acad tinyint IDENTITY (1,1) PRIMARY KEY, -- entero de 1 byte
	Nombre varchar(50) NOT NULL,
	Fec_Fundacion Date NOT NULL,
	Numero varchar(10) NOT NULL,
	Calle varchar(30) NOT NULL,
	Ciduad varchar(30) NOT NULL,
	Estado char(2) NULL
	-- Si deseamos Agregar un Nombre
		CONSTRAINT FK_Academias_Estados FOREIGN KEY 
										REFERENCES Estados (Cod_Estado)
											ON UPDATE CASCADE
											ON DELETE SET NULL,
	Cod_Postal varchar(10),
);

CREATE TABLE Profesores
(
	Cod_Prof smallint IDENTITY(1,1) PRIMARY KEY,
	SSN varchar(11) UNIQUE CHECK (LEN (SSN) = 11),
	Nombre varchar(30) NOT NULL,
	Apellido varchar(30) NOT NULL,
	Numero varchar(10) NOT NULL,
	Calle varchar(30) NOT NULL,
	Ciudad varchar(30) NOT NULL,
	Estado char(2) FOREIGN KEY REFERENCES Estados (Cod_Estado)
							ON UPDATE CASCADE
							ON DELETE SET NULL,
	Cod_Postal varchar(10) NOT NULL,
	Telefono varchar (15),
	Sueldo money DEFAULT (0)
);

/***************************************************************************************************
La palabra IDENTITY lo hace añadirle una regla de negocio en que el atributo es 
autoincremental el primer 1 para indicar donde empieza y el segundo 1 es para indicar cuanto incrementa
***************************************************************************************************/

CREATE TABLE Departamentos
(
	Cod_Dpto Smallint IDENTITY (1,1) PRIMARY KEY,
	Academia tinyint NOT NULL
			FOREIGN KEY REFERENCES Academias (Cod_Acad)
						ON UPDATE CASCADE
						ON DELETE CASCADE,
	Nombre varchar(30) NOT NULL,
	Directior smallint NOT NULL DEFAULT(-1)
				FOREIGN KEY REFERENCES Profesores (Cod_Prof)
				ON UPDATE NO ACTION
				ON DELETE NO ACTION,
				/*EN CASO DE QUE SE BORRE EL PROFESOR REFERENCIADO, EN ESTE REGISTRO NO SE TOMARA NINGUNA ACCIÓN*/
	Fec_Inicio Date NOT NULL,
);

CREATE TABLE Dptos_Profesores
(
	Cod_Dpto smallint NOT NULL
				FOREIGN KEY REFERENCES [dbo].[Departamentos] (Cod_Dpto),
	Cod_Prof smallint NOT NULL
				FOREIGN KEY REFERENCES Profesores (Cod_Prof)
				ON UPDATE CASCADE
				ON DELETE CASCADE,
);

