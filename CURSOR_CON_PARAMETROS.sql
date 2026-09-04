SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN DEL CURSOR CON PARÁMETRO
    --1.Estructura CURSOR CON PARÁMETRO-> Tabla: 'prestamos'
    CURSOR c_prestamos_estado (p_estado VARCHAR2) IS
    SELECT u.nombre, l.titulo
    FROM prestamos p
    JOIN usuarios u ON p.id_usuario = u.id_usuario
    JOIN libros l ON p.id_libro = l.id_libro
    WHERE p.estado = p_estado;

    --2.Variables CURSOR CON PARÁMETRO
    v_nombre_usuario usuarios.nombre%TYPE;
    v_titulo_libro libros.titulo%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- LISTA DE PRÉSTAMOS ATRASADOS ---');
    --3.Abrimos el CURSOR
    OPEN c_prestamos_estado('Atrasado');

    --4.Bucle para leer fila
    LOOP
        -- Extraemos la fila actual y la guardamos en nuestras variables
        FETCH c_prestamos_estado INTO v_nombre_usuario, v_titulo_libro;
        EXIT WHEN c_prestamos_estado%NOTFOUND;

        --5.Imprimimos los datos obtenidos
        DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_nombre_usuario || ' | Libro: ' || v_titulo_libro);
    END LOOP;

    -- 6.Cerramos el cursor
    CLOSE c_prestamos_estado;
END;
