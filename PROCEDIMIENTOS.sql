CREATE OR REPLACE PROCEDURE RegistrarDevolucion(p_id_prestamo NUMBER) IS
  -- Variable para guardar el ID del libro asociado a este préstamo
  v_id_libro prestamos.id_libro%TYPE;
BEGIN
  -- 1. Buscamos qué libro se está devolviendo
  SELECT id_libro INTO v_id_libro
  FROM prestamos
  WHERE id_prestamos = p_id_prestamo;

  -- 2. Actualizamos el estado del préstamo
  UPDATE prestamos
  SET estado = 'Devuelto'
  WHERE id_prestamos = p_id_prestamo;

  -- 3. Sumamos 1 a la cantidad disponible de ese libro
  UPDATE libros
  SET cantidad_disponible = cantidad_disponible + 1
  WHERE id_libro = v_id_libro;

  -- 4. Guardamos los cambios permanentemente
  COMMIT;

  DBMS_OUTPUT.PUT_LINE('Devolución registrada con éxito para el préstamo: ' || p_id_prestamo);
END;
/
