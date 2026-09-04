SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN VARRAY
    --1.Estructura VARRAY-> Tabla: 'libros'
    TYPE LoteStock IS VARRAY(5) OF NUMBER;

    --2.Variables VARRAY
    --Declaramos la variable y la inicializamos con las cantidades de tus libros
    v_cantidades LoteStock := LoteStock(99, 89, 78, 69, 96);

    --Variable para ir guardando la suma (aquí usaste v_posicion)
    v_posicion NUMBER := 0;

BEGIN
    --3.Recorremos el VARRAY usando un bucle FOR
    FOR i IN 1..v_cantidades.COUNT LOOP
      -- Sumamos el valor que está en la posición 'i' a tu variable v_posicion
      v_posicion := v_posicion + v_cantidades(i);
    END LOOP;

    -- 5.Imprimir datos obtenidos
    DBMS_OUTPUT.PUT_LINE('El stock total de este lote de ' || v_cantidades.COUNT || ' libros es: ' || v_posicion || ' unidades.');
END;
