-- 1. CREACIÓN DE LA FUNCIÓN
CREATE OR REPLACE FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER IS
  v_total_stock NUMBER;
BEGIN
  -- Sumamos la cantidad disponible de todos los libros que pertenecen a este autor
  SELECT SUM(cantidad_disponible) INTO v_total_stock
  FROM libros
  WHERE id_autor = p_id_autor;

  -- Si el autor no tiene libros registrados, la suma dará NULL, así que lo convertimos a 0
  RETURN NVL(v_total_stock, 0);
END;
/

-- 2. USO DE LA FUNCIÓN EN UNA CONSULTA (Igual que en tu clase)
SELECT id_autor,
       nombre,
       StockTotalAutor(id_autor) AS total_libros_disponibles
FROM autores;
