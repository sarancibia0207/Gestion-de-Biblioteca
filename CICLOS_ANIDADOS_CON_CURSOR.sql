SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN CICLOS ANIDADOS CON CURSOR
    --1.Estructura CURSORES (EXTERNO e INTERNO)
    --CURSOR EXTERNO: Obtiene todos los autores
    CURSOR c_autores IS
        SELECT id_autor, nombre FROM autores;
    --CURSOR INTERNO: Obtiene los libros de un autor específico
    CURSOR c_libros (p_id_autor NUMBER) IS
        SELECT titulo, cantidad_disponible 
        FROM libros
        WHERE id_autor = p_id_autor;
        
    --2.Variables CURSORES
    --Variables para el cursor de Autores
    v_autor_id autores.id_autor%TYPE;
    v_autor_nombre autores.nombre%TYPE;   
    --Variables para el cursor de Libros
    v_libro_titulo libros.titulo%TYPE;
    v_libro_stock libros.cantidad_disponible%TYPE;
BEGIN
    -- 3.Abrimos el ciclo EXTERNO (recorriendo autores)
    OPEN c_autores;
        LOOP
            FETCH c_autores INTO v_autor_id, v_autor_nombre;
            EXIT WHEN c_autores%NOTFOUND;
            -- Imprimimos el nombre del autor
            DBMS_OUTPUT.PUT_LINE('-----------------------------------');
            DBMS_OUTPUT.PUT_LINE('Autor: ' || v_autor_nombre);
        
            -- 4. Abrimos el ciclo INTERNO (recorriendo los libros DE ESTE autor)
            OPEN c_libros(v_autor_id);
                LOOP
                    FETCH c_libros INTO v_libro_titulo, v_libro_stock;
                    EXIT WHEN c_libros%NOTFOUND;
                    -- Imprimimos el libro y su stock (con una sangría para que se vea ordenado)
                    DBMS_OUTPUT.PUT_LINE('   -> Libro: ' || v_libro_titulo || ' (Stock: ' || v_libro_stock || ')');
                END LOOP;   
            -- 5.Cerramos el CURSOR INTERNO
            CLOSE c_libros; 
        END LOOP;
    -- 6. Cerramos el CURSOR EXTERNO
    CLOSE c_autores;
END;