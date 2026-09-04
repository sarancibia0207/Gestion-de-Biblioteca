SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN RECORD
    --1.Estructura RECORD-> Tabla: 'libros'
   TYPE LibroResumenRec IS RECORD (
        libro_id NUMBER,
        titulo_libro VARCHAR2(150),
        stock_actual NUMBER,
        total_veces_prestado NUMBER
    );

    --2.Variable RECORD
    v_datos_libro LibroResumenRec;
BEGIN
    --3.Generamos la consulta y guardamos los datos en RECORD
    SELECT l.id_libro, l.titulo, l.cantidad_disponible, COUNT(p.id_prestamos)
    INTO v_datos_libro
    FROM libros l
    LEFT JOIN prestamos p ON l.id_libro = p.id_libro
    WHERE l.id_libro = 1  -- Filtramos por el libro ID 1 ("Paula")
    GROUP BY l.id_libro, l.titulo, l.cantidad_disponible;

    --4.Imprimir datos obtenidos
    DBMS_OUTPUT.PUT_LINE('--- RESUMEN DEL LIBRO ---');
    DBMS_OUTPUT.PUT_LINE('Título: ' || v_datos_libro.titulo_libro);
    DBMS_OUTPUT.PUT_LINE('Stock disponible: ' || v_datos_libro.stock_actual || ' unidades.');
    DBMS_OUTPUT.PUT_LINE('Historial: Ha sido prestado ' || v_datos_libro.total_veces_prestado || ' vez/veces.');
END;
