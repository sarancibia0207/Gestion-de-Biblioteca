CREATE OR REPLACE PACKAGE BibliotecaPKG IS
  -- Función: Calcula cuántos libros en total tiene un autor
  FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER;

  -- Procedimiento: Registra la devolución de un libro
  PROCEDURE RegistrarDevolucion(p_id_prestamo NUMBER);
END BibliotecaPKG;
/
