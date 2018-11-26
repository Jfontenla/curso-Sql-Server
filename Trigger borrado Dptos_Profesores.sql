CREATE TRIGGER trg_Borrar_Dptos_Profesores
	ON Departamentos
	FOR DELETE
	AS
	BEGIN
		DELETE Dptos_Profesores
		WHERE Cod_Dpto IN 
				(SELECT Cod_Dpto
				FROM Deleted
				);
	END;

CREATE TRIGGER trg_Modificar_Dptos_Profesores
	ON Departamentos
	FOR UPDATE
	AS
	BEGIN
		UPDATE Dptos_Profesores
		SET Cod_Dpto = A.Cod_Nuevo
		FROM (
			SELECT  D.Cod_Dpto AS Cod_Anterior,
					I.Cod_Dpto AS Cod_Nuevo
			FROM	DELETED D
					JOIN
					INSERTED I
					ON D.Cod_Dpto = I.Cod_Dpto
			WHERE	D.Cod_Dpto <> I.Cod_Dpto --> aqui sabremos que el código se modifico
				-- Esta condicion se puede manejar de otra forma. 
				-- Muchos gestores de bases de datos tienen instrucciones para notificarnos que campos han cambiado en el registro.
			) A
		WHERE Cod_Dpto = A.Cod_Anterior;
	END;