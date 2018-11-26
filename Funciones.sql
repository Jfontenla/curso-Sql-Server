/*******************************************************************************************************************
CONJUNTO DE INSTRUCCIONES SQL QUE DADOS UNOS VALORES DE EMTRADA, EJECUTA ALGUNAS OPERACIONES Y RETORNA UN RESULTADO
*******************************************************************************************************************/

/* DOS TIPOS DE FUNCIONES GRANDES : DE SISTEMA O DEFINIDAS POR EL USUARIO
 DENTRO DE LAS FUNCIONES DEL SISTEMA
 1�ESCALARES
 Cogen un valor de entrada, ejecutan operaciones y devuelven un valor
 2� ACUMULACION
 Conjunto de valores de entrada, realizan unas operaciones y devuelven un valor

UNA FUNCION ESCALAR ES IGUAL A UNA EXPRESION Y SE PUEDEN USAR COMO TALES
 TODOS LOS GESTORES DE BD OFRECEN FUNCIONES COMUNES
 funciones de conversion : CAST, CONVERT Y PARSE
 funciones matem�ticas : ABS, SQRT, LOG, RADIANS, EXP, SIN,COS FLOOR....
 funciones de cadenas de caracteres : ASCII, CONCAT, FORMAT, LEFT, RIGHT, TRIM, STUGG, SUBSTRING, CHAR....
 funciones de fechas : GETDATE, DATEPART, DAY, MONTH, YEAR, DATEADD, DATEDIFF, EOMONTH.....
 funciones del sistema : @@ERROR, @@ROWCOUNT, @@ IDENTITY, CHECKSUM....

 TODAS ESTAS FUNCIONES SON FUNCIONES DETERMINISTAS : ES DECIR, PARA EL MISMO CONJUNTO DE DATOS DE ENTRADA, DEVUELVEN SIEMPRE EL MISMO RESULTADO
 FUNCIONES NO DETERMINISTAS : PARA EL MISMO CONJUNTO DE DATOS DE ENTRADA, PUEDEN DEVOLVER RESULTADOS DIFERENTES

 UNA FUNCION ACUMULADA SON UNA CARACTERISTICA ESPECIAL DE LOS LENGUAJES QUE TRABAJAN CON CONJUNTOS DE DATOS. 
 */