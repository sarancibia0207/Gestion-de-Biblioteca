-- 1. CREACIÓN DE TRIGGER
CREATE OR REPLACE TRIGGER trg_descontar_stock_libro
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN
  --2.Actualizamos la tabla libros restando 1 a la cantidad disponible
  UPDATE libros
  SET cantidad_disponible = cantidad_disponible - 1
  WHERE id_libro = :NEW.id_libro;
END;
