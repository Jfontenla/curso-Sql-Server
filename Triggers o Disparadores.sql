/***********************************************************************************************************************
TRIGGERS : SON OBJETOS/PROCESOS DE LA BASE DE DATOS QUE SE EJECUTAN AUTOMATICAMENTE AL INSERTAR,MODIFICAR Y/O ELIMINAR
DATOS DE UNA TABLA O VISTA
*************************************************************************************************************************/

/***********************************************************************************************************************
CREATE TRIGGER nombre
ON { tabla | vista }
{ FOR | AFTER | INSTEAD OF}
{[INSERT][,][UPDATE][,][DELETE]}
AS
BEGIN
	Instrucciones a ejecutar
END ;
*************************************************************************************************************************/