SET SERVEROUTPUT ON;

-- ----------------------------------------------------------------------------
-- 1. ESPECIFICACIÓN DEL PAQUETE (Cabecera)
-- Declara los elementos PÚBLICOS que se podrán invocar desde afuera.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BibliotecaPKG AS

  -- Procedimiento original: Registra la devolución de un préstamo[cite: 6]
  PROCEDURE RegistrarDevolucion(p_id_prestamo IN NUMBER);

  -- Función original: Calcula la cantidad de ejemplares disponibles de un autor[cite: 6]
  FUNCTION StockTotalAutor(p_id_autor IN NUMBER) RETURN NUMBER;

  -- Procedimiento nuevo: Recorre y muestra préstamos según su estado
  PROCEDURE PRC_INFORME_PRESTAMOS(p_estado IN VARCHAR2);

  -- Función nueva: Expone el contador de préstamos procesados de forma segura
  FUNCTION FNC_PRESTAMOS_PROCESADOS RETURN NUMBER;

END BibliotecaPKG;

-- ----------------------------------------------------------------------------
-- 2. CUERPO DEL PAQUETE (Body)
-- Contiene la lógica interna, además de los elementos PRIVADOS (ocultos).
-- ----------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY BibliotecaPKG AS

  -- =========================================================================
  -- ELEMENTOS PRIVADOS: NO están en la cabecera, son invisibles desde afuera
  -- =========================================================================

  -- Variable privada (Contador global del paquete)
  v_prestamos_procesados NUMBER := 0;

  -- Función privada 1: Valida si el préstamo sigue vigente[cite: 5]
  FUNCTION FNC_PRESTAMO_VIGENTE(p_prestamo_id IN NUMBER) RETURN BOOLEAN IS
    v_estado prestamos.estado%TYPE;
  BEGIN
    SELECT estado INTO v_estado
      FROM prestamos WHERE id_prestamos = p_prestamo_id;
    RETURN v_estado != 'Devuelto';
  END FNC_PRESTAMO_VIGENTE;

  -- Función privada 2: Obtiene el título del libro[cite: 5]
  FUNCTION FNC_TITULO_LIBRO(p_libro_id IN NUMBER) RETURN VARCHAR2 IS
    v_titulo libros.titulo%TYPE;
  BEGIN
    SELECT titulo INTO v_titulo
      FROM libros WHERE id_libro = p_libro_id;
    RETURN v_titulo;
  END FNC_TITULO_LIBRO;

  -- =========================================================================
  -- IMPLEMENTACIÓN DE ELEMENTOS PÚBLICOS (Declarados en la cabecera)
  -- =========================================================================

  -- Implementación: RegistrarDevolucion[cite: 5]
  PROCEDURE RegistrarDevolucion(p_id_prestamo IN NUMBER) IS
    v_id_libro prestamos.id_libro%TYPE;
  BEGIN
    SELECT id_libro INTO v_id_libro FROM prestamos WHERE id_prestamos = p_id_prestamo;
    UPDATE prestamos SET estado = 'Devuelto' WHERE id_prestamos = p_id_prestamo;
    UPDATE libros SET cantidad_disponible = cantidad_disponible + 1 WHERE id_libro = v_id_libro;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Devolucion registrada con exito para el prestamo: ' || p_id_prestamo);
  END RegistrarDevolucion;

  -- Implementación: StockTotalAutor[cite: 5]
  FUNCTION StockTotalAutor(p_id_autor IN NUMBER) RETURN NUMBER IS
    v_total_stock NUMBER;
  BEGIN
    SELECT SUM(cantidad_disponible) INTO v_total_stock FROM libros WHERE id_autor = p_id_autor;
    RETURN NVL(v_total_stock, 0);
  END StockTotalAutor;

  -- Implementación: PRC_INFORME_PRESTAMOS[cite: 5]
  PROCEDURE PRC_INFORME_PRESTAMOS(p_estado IN VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('--- INFORME DE PRESTAMOS EN ESTADO: ' || p_estado || ' ---');
    FOR r IN (SELECT id_prestamos, id_libro FROM prestamos WHERE estado = p_estado) LOOP

      -- Usamos la función privada para validar
      IF FNC_PRESTAMO_VIGENTE(r.id_prestamos) THEN
        v_prestamos_procesados := v_prestamos_procesados + 1; -- Aumentamos el contador privado

        -- Imprimimos usando la otra función privada
        DBMS_OUTPUT.PUT_LINE('Prestamo ' || r.id_prestamos ||
          ' | Libro: ' || FNC_TITULO_LIBRO(r.id_libro));
      END IF;

    END LOOP;
  END PRC_INFORME_PRESTAMOS;

  -- Implementación: FNC_PRESTAMOS_PROCESADOS
  -- Solo sirve para leer el contador de manera segura
  FUNCTION FNC_PRESTAMOS_PROCESADOS RETURN NUMBER IS
  BEGIN
    RETURN v_prestamos_procesados;
  END FNC_PRESTAMOS_PROCESADOS;

END BibliotecaPKG;

-- ============================================================================
-- EJEMPLOS DE EJECUCIÓN (Bloque de pruebas para validar con el profesor)
-- ============================================================================

-- 1. Consultamos el contador ANTES de hacer nada (Debería ser 0)
BEGIN
  DBMS_OUTPUT.PUT_LINE('Contador inicial: ' || BibliotecaPKG.FNC_PRESTAMOS_PROCESADOS);
END;
/

-- 2. Ejecutamos el informe de préstamos 'Activo' e 'Atrasado'
EXEC BibliotecaPKG.PRC_INFORME_PRESTAMOS('Activo');
EXEC BibliotecaPKG.PRC_INFORME_PRESTAMOS('Atrasado');

-- 3. Consultamos el contador DESPUÉS de haber procesado los registros
BEGIN
  DBMS_OUTPUT.PUT_LINE('Total de prestamos procesados (vigentes): ' || BibliotecaPKG.FNC_PRESTAMOS_PROCESADOS);
END;
