-- 1. CREACIÓN DE PACKAGE
CREATE OR REPLACE PACKAGE BibliotecaPKG IS
  --2.Función: Calcula cuántos libros en total tiene un autor
  FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER;
  --3.Procedimiento: Registra la devolución de un libro
  PROCEDURE RegistrarDevolucion(p_id_prestamo NUMBER);
END BibliotecaPKG;
