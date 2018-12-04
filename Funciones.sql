/*******************************************************************************************************************
CONJUNTO DE INSTRUCCIONES SQL QUE DADOS UNOS VALORES DE EMTRADA, EJECUTA ALGUNAS OPERACIONES Y RETORNA UN RESULTADO
*******************************************************************************************************************/

/* DOS TIPOS DE FUNCIONES GRANDES : DE SISTEMA O DEFINIDAS POR EL USUARIO
 DENTRO DE LAS FUNCIONES DEL SISTEMA
 1ºESCALARES
 Cogen un valor de entrada, ejecutan operaciones y devuelven un valor
 2º ACUMULACION
 Conjunto de valores de entrada, realizan unas operaciones y devuelven un valor

UNA FUNCION ESCALAR ES IGUAL A UNA EXPRESION Y SE PUEDEN USAR COMO TALES
 TODOS LOS GESTORES DE BD OFRECEN FUNCIONES COMUNES
 funciones de conversion : CAST, CONVERT Y PARSE
 funciones matemáticas : ABS, SQRT, LOG, RADIANS, EXP, SIN,COS FLOOR....
 funciones de cadenas de caracteres : ASCII, CONCAT, FORMAT, LEFT, RIGHT, TRIM, STUGG, SUBSTRING, CHAR....
 funciones de fechas : GETDATE, DATEPART, DAY, MONTH, YEAR, DATEADD, DATEDIFF, EOMONTH.....
 funciones del sistema : @@ERROR, @@ROWCOUNT, @@ IDENTITY, CHECKSUM....

 TODAS ESTAS FUNCIONES SON FUNCIONES DETERMINISTAS : ES DECIR, PARA EL MISMO CONJUNTO DE DATOS DE ENTRADA, DEVUELVEN SIEMPRE EL MISMO RESULTADO
 FUNCIONES NO DETERMINISTAS : PARA EL MISMO CONJUNTO DE DATOS DE ENTRADA, PUEDEN DEVOLVER RESULTADOS DIFERENTES

 UNA FUNCION ACUMULADA SON UNA CARACTERISTICA ESPECIAL DE LOS LENGUAJES QUE TRABAJAN CON CONJUNTOS DE DATOS.
 Nos permiten tomar un conjunto de datos y aplicar funciones sobre el TOTAL de los datos, y no sobre datos especificos
 1º se ejecuta la operacion de seleccion, se toma el resultado, y sobre este resultado se aplican las funciones de acumulacion

 GROUP BY -> ESPECIFICAR SUBDIVISION DE GRUPOS (AGRUPAR POR) 
 HAVING -> ES COMO EL WHERE DEL SELECT PERO PARA GRUPOS, Y SIEMPRE SE EJECUTA DESPÚES DE UNA FUNCION DE ACUMULACIÓN
 wHERE -> CONDICION PARA TODOS LOS REGISTROS DE LA SELECT

 FUNCIONES DE TIPO TABLA (TVf)

	CREATE FUNCTION nombre_function([@par1 tipo,...,@parN tipo]) **LOS PARÁMETOS SON OPCIONALES
		RETURN tipo_de_Dato_de_retorno(funcion escalar) // return Table (funcion de tipo tabla)
		AS
		BEGIN
			DECLARE @Variable_mismo_tipo_de_retorno
		END;

	EJEMPLO

			CREATE FUNCTION Alumnos_Curso (@Cod_Curso int)
			RETURN int
			AS
			BEGIN
				DECLARE @Alumnos int = 0;
				SELECT @Alumnos = COUNT(*)
				FROM Cursos
				WHERE Cod_Curso = @Cod_Curso;
				RETURN @Alumnos
				--aqui no hace falta tener que poner una select...tambien podriamos hacer un set de nuestra variable para realizar alguna operacion y despues retornar el valor.
			END;
	UNA FUNCION PUEDE UTILIZARSE EN CUALQUIER LUGAR COMO UNA EXPRESION, Y PUEDE TENER MULTIPLES PARAMETROS(AUNQUE NO SEAN OBLIGATORIOS):
	SELECT Alumnos_Curso (156);
	
	DECLARE @Alumnos int = 0;
	SET @Alumnos = Alumnos_Curso(384);

	SELECT Cod_Curso,Nombre,Peso
	FROM Cursos
	WHERE Alumnos_Curso (Cod_Curso)>20;

	LAS FUNCIONES DE TIPO TABLA, SE PUEDEN USAR EN CUALQUIER LUGAR DONDE SE PUEDA USAR UNA TABLA, Y SE DIVIDEN EN DOS TIPOS DE FUNCIONES
		1º EL RESULTADO SE PUEDE OBTENER DE UNA SOLA INSTRUCCION SQL , CONOCIDAS COMO FUNCIONES "IN-LINE". Se puede usar como una tabla en cualquier sitio
		2º EL RESULTADO SE OBTIENE DE VARIAS INSTRUCCIONES SQL, CONOCIDAS COMO MULTI-STATMENTS FUNCTIONS
		EJEMPLOS
		1º
		CREATE FUNCTION Facturas_dia(@Dia date)
		RETURN TABLE
		AS
		SELECT Numero,Total,Descuento
		FROM Facturas
		WHERE Fecha >= @Dia AND Fecha < DATEADD(DAY,1,@Dia)

		2º ESQUEMA
		
		CREATE FUNCTION nombre_function(@par1 tipo,...,@parN tipo)
		RETURN @nombre TABLE (col1 tipo,..., coilN tipo) -- definir el esquema que tenemos que retornar
		AS
		BEGIN
		Inserccion de filas en la tabla @nombre
		RETURN; 
		END;

 */
