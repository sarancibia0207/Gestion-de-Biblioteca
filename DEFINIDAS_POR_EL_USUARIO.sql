SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN EXECPCIONES PREDEFINIDAS
    --Simulamos que el usuario busca el libro con ID 999
    v_id_buscado NUMBER := 999;
    v_titulo libros.titulo%TYPE;

BEGIN
    --Intentamos buscar el título y guardarlo en la variable
    SELECT titulo INTO v_titulo
    FROM libros
    WHERE id_libro = v_id_buscado;

    --Si el libro existe, se imprime esto
    DBMS_OUTPUT.PUT_LINE('Éxito: El libro encontrado es "' || v_titulo || '"');

EXCEPTION
    --1.Excepción Predefinida: Cuando la consulta no devuelve ninguna fila
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: No se encontró ningún libro con el ID ' || v_id_buscado || '. Verifica el código.');

    --2.Excepción Predefinida: Cuando la consulta devuelve MÁS de una fila y usamos INTO
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: Se encontró más de un libro. Se esperaba solo uno.');

    --3.Excepción General: Atrapa cualquier otro error no contemplado arriba
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado del sistema: ' || SQLERRM);
END;
