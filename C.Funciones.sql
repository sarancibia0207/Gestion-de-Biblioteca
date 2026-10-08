-- ----------------------------------------------------------------------------
-- 1. FUNCIÓN: FNC_NIVEL_STOCK
--    Evalúa la cantidad disponible de un libro y clasifica su nivel de stock.
--    (Siguiendo la estructura condicional IF/ELSIF/ELSE del ejemplo del profesor).
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION FNC_NIVEL_STOCK (
    p_cantidad IN NUMBER
) RETURN VARCHAR2 AS                          -- La cabecera declara QUE devuelve
BEGIN
    IF    p_cantidad >= 80 THEN RETURN 'ALTO';
    ELSIF p_cantidad >= 50 THEN RETURN 'MEDIO';
    ELSE                        RETURN 'BAJO';
    END IF;
END;

-- ----------------------------------------------------------------------------
-- 2. FUNCIÓN: StockTotalAutor
--    Calcula el total acumulado de ejemplares disponibles para un autor.
--    (Versión corregida y estandarizada del archivo FUNCIONES.sql).
-- ----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION StockTotalAutor (
    p_id_autor IN NUMBER
) RETURN NUMBER AS
    v_total_stock NUMBER;
BEGIN
    -- Sumamos la cantidad disponible de los libros asignados al autor[cite: 3, 4]
    SELECT SUM(cantidad_disponible) INTO v_total_stock
      FROM libros
     WHERE id_autor = p_id_autor;

    -- Si el autor no tiene registros o da NULL, devolvemos 0[cite: 4]
    RETURN NVL(v_total_stock, 0);
END;

-- ============================================================================
-- CONSULTAS SELECT PARA PROBAR Y DEMOSTRAR LAS FUNCIONES
-- ============================================================================

-- 1. Demostración de FNC_NIVEL_STOCK:
-- Muestra el título, cantidad y genera una columna calculada con el tramo de stock[cite: 3].
SELECT titulo,
       cantidad_disponible,
       FNC_NIVEL_STOCK(cantidad_disponible) AS tramo_stock
  FROM libros
 ORDER BY cantidad_disponible DESC;

-- 2. Demostración de StockTotalAutor:
-- Muestra el nombre de cada autor y calcula su total de ejemplares disponibles[cite: 3].
SELECT id_autor,
       nombre,
       StockTotalAutor(id_autor) AS total_ejemplares
  FROM autores;
