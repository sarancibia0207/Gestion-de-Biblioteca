SET SERVEROUTPUT ON;

-- ----------------------------------------------------------------------------
-- 1. TRIGGER BEFORE: trg_calcula_devolucion
--    Al igual que el ejemplo del profesor que calcula el :NEW.subtotal,
--    este trigger calcula automáticamente la fecha de devolución (+10 días)
--    antes de insertar o actualizar la fecha de préstamo.
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_calcula_devolucion
BEFORE INSERT OR UPDATE OF fecha_prestamo ON prestamos
FOR EACH ROW
BEGIN
    -- Se asigna el valor al campo :NEW antes de guardarse en la base de datos[cite: 8]
    :NEW.fecha_devolucion := :NEW.fecha_prestamo + 10;
END;

-- ----------------------------------------------------------------------------
-- 2. TRIGGER AFTER: trg_actualizar_stock_libro
--    Se ejecuta después de insertar un préstamo o actualizar su estado.
--    Descuenta stock al crear un préstamo y lo devuelve al marcarlo como 'Devuelto'[cite: 7].
-- ----------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_actualizar_stock_libro
AFTER INSERT OR UPDATE OF estado ON prestamos
FOR EACH ROW
BEGIN
    -- Si es un registro nuevo (INSERT) o un préstamo activo, restamos 1 del stock[cite: 7]
    IF INSERTING OR :NEW.estado = 'Activo' THEN
        UPDATE libros
           SET cantidad_disponible = cantidad_disponible - 1
         WHERE id_libro = :NEW.id_libro;

    -- Si el estado cambia a 'Devuelto', sumamos 1 de vuelta al stock
    ELSIF UPDATING AND :NEW.estado = 'Devuelto' THEN
        UPDATE libros
           SET cantidad_disponible = cantidad_disponible + 1
         WHERE id_libro = :NEW.id_libro;
    END IF;
END;


-- ============================================================================
-- PRUEBAS Y VERIFICACIÓN DE LOS TRIGGERS
-- ============================================================================

-- Insertamos un préstamo nuevo (no especificamos fecha_devolucion)[cite: 8]:
-- - El trigger BEFORE calculará la fecha_devolucion (+10 días a partir de hoy).
-- - El trigger AFTER restará 1 en cantidad_disponible del libro 1 en la tabla libros[cite: 7, 8].

INSERT INTO prestamos (id_prestamos, id_libro, id_usuario, fecha_prestamo, estado)
VALUES (999, 1, 1, SYSDATE, 'Activo');

COMMIT;

-- Consultar para verificar que se generó la fecha de devolución automáticamente[cite: 8]:
SELECT id_prestamos, id_libro, fecha_prestamo, fecha_devolucion, estado
  FROM prestamos
 WHERE id_prestamos = 999;
