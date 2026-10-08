SET SERVEROUTPUT ON;

-- ============================================================================
-- 1. PROCEDIMIENTO: RegistrarDevolucion (Corregido y estructurado)
--    Actualiza el estado de un préstamo a 'Devuelto' e incrementa el stock.
-- ============================================================================
CREATE OR REPLACE PROCEDURE RegistrarDevolucion (
    p_id_prestamo IN NUMBER
) AS
    v_id_libro prestamos.id_libro%TYPE;
BEGIN
    -- Buscamos el ID del libro asociado al préstamo
    SELECT id_libro INTO v_id_libro
      FROM prestamos
     WHERE id_prestamos = p_id_prestamo;

    -- Actualizamos el estado del préstamo a 'Devuelto'
    UPDATE prestamos
       SET estado = 'Devuelto'
     WHERE id_prestamos = p_id_prestamo;

    -- Sumamos 1 a la cantidad disponible de ese libro
    UPDATE libros
       SET cantidad_disponible = cantidad_disponible + 1
     WHERE id_libro = v_id_libro;

    -- Guardamos los cambios permanentemente
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Devolucion registrada con exito para el prestamo: ' || p_id_prestamo);
END;

-- ============================================================================
-- 2. PROCEDIMIENTO: PRC_RESUMEN_USUARIO
--    Muestra el nombre del usuario y el total de préstamos asociados.
-- ============================================================================
CREATE OR REPLACE PROCEDURE PRC_RESUMEN_USUARIO (
    p_id_usuario IN NUMBER
) AS
    v_nombre  usuarios.nombre%TYPE;
    v_total   NUMBER;
BEGIN
    -- Obtener nombre del usuario
    SELECT nombre INTO v_nombre
      FROM usuarios
     WHERE id_usuario = p_id_usuario;

    -- Contar la cantidad de préstamos realizados
    SELECT COUNT(*) INTO v_total
      FROM prestamos
     WHERE id_usuario = p_id_usuario;

    -- Imprimir resultado por pantalla
    DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Prestamos realizados: ' || v_total || ' prestamo(s)');
END;

-- ============================================================================
-- 3. PROCEDIMIENTO: PRC_RESUMEN_AUTOR
--    Muestra el nombre del autor y el total de libros en catálogo.
-- ============================================================================
CREATE OR REPLACE PROCEDURE PRC_RESUMEN_AUTOR (
    p_id_autor IN NUMBER
) AS
    v_nombre  autores.nombre%TYPE;
    v_total   NUMBER;
BEGIN
    -- Obtener nombre del autor[cite: 1]
    SELECT nombre INTO v_nombre
      FROM autores
     WHERE id_autor = p_id_autor;

    -- Contar total de libros registrados de ese autor
    SELECT COUNT(*) INTO v_total
      FROM libros
     WHERE id_autor = p_id_autor;

    -- Imprimir resultado por pantalla
    DBMS_OUTPUT.PUT_LINE('Autor: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Total de libros: ' || v_total || ' libro(s)');
END;


-- ============================================================================
-- EJECUCIÓN / PRUEBAS DE LOS PROCEDIMIENTOS
-- ============================================================================
EXEC RegistrarDevolucion(1);
EXEC PRC_RESUMEN_USUARIO(1);
EXEC PRC_RESUMEN_AUTOR(1);
