-- 1. CREACIÓN DE LA FUNCIÓN
CREATE OR REPLACE FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER IS
  v_total_stock NUMBER;
BEGIN
  --2.Sumamos la cantidad disponible de todos los libros que pertenecen a este autor
    SELECT SUM(cantidad_disponible) INTO v_total_stock
    FROM libros
    WHERE id_autor = p_id_autor;
  --3.Si el autor no tiene libros registrados, la suma dará NULL, así que lo convertimos a 0
    RETURN NVL(v_total_stock, 0);
END;
