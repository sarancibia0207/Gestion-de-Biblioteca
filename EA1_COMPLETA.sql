/*
Equipo: Sofía Arancibia y Martín Sanchez.
Fecha entrega: 06/09/2026
Proyecto:"Sistema de Gestión de Biblioteca"
Tablas: Autores, Usuarios, Libros, Préstamos y Editorial
EA1: RECORD, VARRAY, CURSORES, CICLOS ANIDADOS, EXCEPCIONES PREDEFINIDAS, DEFINIDAS POR EL USUARIO, PROCEDIMIENTOS, FUNCIONES, PACKAGES Y TRIGGERS.
*/

--1. CREACIÓN DE LA BASE DE DATOS => "Sistema de Gestión de Biblioteca"
--ELIMINACION TABLAS
DROP TABLE autores CASCADE CONSTRAINTS;
DROP TABLE usuarios CASCADE CONSTRAINTS;
DROP TABLE libros CASCADE CONSTRAINTS;
DROP TABLE prestamos CASCADE CONSTRAINTS;
DROP TABLE editorial CASCADE CONSTRAINTS;

--CREACIÓN DE TABLAS
--1.Autores
CREATE TABLE autores(
    id_autor NUMBER(6) NOT NULL,
    nombre VARCHAR2(150) NOT NULL,
    nacionalidad VARCHAR2(12) NOT NULL,
    CONSTRAINT pk_autores PRIMARY KEY (id_autor)
);
--2.Usuarios
CREATE TABLE usuarios(
    id_usuario NUMBER(6) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    telefono VARCHAR2(14)  NOT NULL,
    fecha_registro DATE,
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario)
);
--3.Libros
CREATE TABLE libros(
    id_libro NUMBER(6) NOT NULL,
    titulo VARCHAR2(150) NOT NULL,
    isbn VARCHAR2(13) UNIQUE,
    ano_publicacion NUMBER(4)  NOT NULL,
    cantidad_disponible NUMBER(7)  NOT NULL,
    id_autor NUMBER(6) NOT NULL,
    CONSTRAINT pk_libros PRIMARY KEY (id_libro),
    CONSTRAINT fk_libros_autores FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);
--4.Préstamos
CREATE TABLE prestamos(
    id_prestamos NUMBER(6) NOT NULL,
    id_libro NUMBER(6) NOT NULL,
    id_usuario NUMBER(6) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    estado VARCHAR2(8) NOT NULL,
    CONSTRAINT pk_prestamos PRIMARY KEY (id_prestamos),
    CONSTRAINT fk_prestamos_libros FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    CONSTRAINT fk_prestamos_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);
--5.Editorial
CREATE TABLE editorial(
    id_editorial NUMBER(6) NOT NULL,
    nombre VARCHAR2(13) NOT NULL,
    id_libro NUMBER(6) NOT NULL,
    CONSTRAINT pk_editorial PRIMARY KEY (id_editorial),
    CONSTRAINT fk_editorial_libros FOREIGN KEY (id_libro) REFERENCES libros (id_libro)
);

--INSERTAR DATOS
--1.Autores
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(1,'Isabel Allende','Chilena');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(2,'Pedro Lemebel','Chileno');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(3,'Julio Cortázar','Argentino');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(4,'Ernesto Sabáto','Argentino');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(5,'Ida Vitale','Uruguaya');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(6,'Carlos Ruiz','Español');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(7,'Pablo Neruda','Chileno');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(8,'Rubén Bareiro','Paraguayo');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(9,'Clarice Lispector','Brasileño');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(10,'Nicanor Parra','Chileno');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(11,'Gabriela Mistral','Chilena');
--2.Usuarios
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(01,'Jordan Nacarate','jo.nacarate@gmail.com','+56920122006', DATE '2026-04-30');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(02,'Gaspar Arancibia','ga.arancibia@gmail.com','+56906102013', DATE '2025-10-06');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(03,'Constanza Tamayo','co.tamayo@gamil.com','+56926062006', DATE '2020-06-26');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(04,'Peter Parker','pe.parker@gmail.com','+56910081962', DATE '2026-07-29');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(05,'Bruce Wayne','br.wayne@gmail.com','+56992847563', DATE '2026-08-30');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(06,'André Santibañez','an.santibañez@gmail.com','+5690186188', DATE '2022-09-15');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(07,'Edo Caroe','ed.caroe@gmail.com','+56977593933', DATE '2023-08-13');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(08,'Augusto Pinto','au.pinto@gmail.com','+56956565656', DATE '2024-12-12');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(09,'Kike Morande','alo.kike@gmail.com','+56915151350', DATE '2025-03-10');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(10,'Eddie Brock','ed.brock@gmail.com','+56900001010', DATE '2025-08-10');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(11,'Michael Jackson','mi.jackson@gmail.com','+5698385753', DATE '2026-08-10');
--3.Libros
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(001,'Paula','2012200630046',1992,99,1);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(002,'Poco Hombre','0202200730046',2013,89, 2);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(003,'Rayuela','0610201306106',1963,78, 3);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(004,'El túnel','2606200620200',1948,69, 4);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(005,'Parvo Reino','0184769276388',1984,96, 5);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(006,'La sombra del viento','2707200720200',2001,80, 6);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(007,'Canto General','2808200820200',1950,50, 7);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(008,'Cuento y Novela','2909200920200',1960,60, 8);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(009,'Cerca del corazón Salvaje','3606300630300',1943,70, 9);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(010,'Cancioneros sin nombre','4606400640400',1937,40, 10);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(011,'Desolación','5606500650500',1922,40, 11);
--4.Préstamos
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0001,001,01,DATE '2025-10-13',DATE '2025-10-24', 'Activo');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0002,002,02,DATE '2024-05-02',DATE '2024-06-01', 'Devuelto');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0003,003,03,DATE '2025-03-27',DATE '2025-04-15', 'Atrasado');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0004,004,04,DATE '2026-03-30',DATE '2026-05-20', 'Atrasado');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0005,005,05,DATE '2023-10-04',DATE '2023-11-03', 'Devuelto');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0006,006,06,DATE '2012-07-17',DATE '2012-08-17', 'Activo');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0007,007,07,DATE '2012-03-15',DATE '2012-04-15', 'Activo');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0008,008,08,DATE '2025-11-02',DATE '2025-11-05', 'Devuelto');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0009,009,09,DATE '2014-12-01',DATE '2015-01-05', 'Atrasado');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0010,010,10,DATE '2017-05-30',DATE '2017-06-14', 'Atrasado');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion, estado)VALUES(0011,011,11,DATE '2026-09-12',DATE '2026-10-01', 'Devuelto');
--5.Editorial
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00001,'Debolsillo',001);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00002,'Ediciones UDP',002);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00003,'Debolsillo',003);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00004,'Cátedra',004);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00005,'Austral',005);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00006,'Planeta',006);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00007,'Cátedra',007);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00008,'Servilibro',008);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00009,'Corregidor',009);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00010,'Nascimento',010);
INSERT INTO editorial(id_editorial, nombre, id_libro)VALUES(00011,'Cátedra',011);

COMMIT;

--2. CREACIÓN DE RECORD
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

--3. CREACIÓN DE VARRAY
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
      --4.Sumamos el valor que está en la posición 'i' a tu variable v_posicion
      v_posicion := v_posicion + v_cantidades(i);
    END LOOP;
    -- 5.Imprimir datos obtenidos
    DBMS_OUTPUT.PUT_LINE('El stock total de este lote de ' || v_cantidades.COUNT || ' libros es: ' || v_posicion || ' unidades.');
END;

--4. CREACIÓN DE CURSORES
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
        --5.Extraemos la fila actual y la guardamos en nuestras variables
        FETCH c_prestamos_estado INTO v_nombre_usuario, v_titulo_libro;
        EXIT WHEN c_prestamos_estado%NOTFOUND;
        --6.Imprimimos los datos obtenidos
        DBMS_OUTPUT.PUT_LINE('Usuario: ' || v_nombre_usuario || ' | Libro: ' || v_titulo_libro);
    END LOOP;
    --7.Cerramos el cursor
    CLOSE c_prestamos_estado;
END;

--5.CREACIÓN DE CICLOS ANIDADOS
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

--6. CREACIÓN DE EXCEPCIONES PREDEFINIDAS
SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN EXECPCIONES PREDEFINIDAS
    --1.Simulamos que el usuario busca el libro con ID 999
    v_id_buscado NUMBER := 999;
    v_titulo libros.titulo%TYPE;

BEGIN
    --2.Intentamos buscar el título y guardarlo en la variable
    SELECT titulo INTO v_titulo
    FROM libros
    WHERE id_libro = v_id_buscado;
    --3.Si el libro existe, se imprime esto
    DBMS_OUTPUT.PUT_LINE('Éxito: El libro encontrado es "' || v_titulo || '"');

EXCEPTION

    --4.Excepción Predefinida: Cuando la consulta no devuelve ninguna fila
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: No se encontró ningún libro con el ID ' || v_id_buscado || '. Verifica el código.');
    --5.Excepción Predefinida: Cuando la consulta devuelve MÁS de una fila y usamos INTO
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: Se encontró más de un libro. Se esperaba solo uno.');
    --6.Excepción General: Atrapa cualquier otro error no contemplado arriba
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado del sistema: ' || SQLERRM);
END;

--7. CREACIÓN DE EXCEPCIONES DEFINIDAS POR EL USUARIO
SET SERVEROUTPUT ON;
DECLARE
    --DECLARACIÓN EXECPCIONES PREDEFINIDAS
    --1.Simulamos que el usuario busca el libro con ID 999
    v_id_buscado NUMBER := 999;
    v_titulo libros.titulo%TYPE;

BEGIN
    --2.Intentamos buscar el título y guardarlo en la variable
    SELECT titulo INTO v_titulo
    FROM libros
    WHERE id_libro = v_id_buscado;

    --3.Si el libro existe, se imprime esto
    DBMS_OUTPUT.PUT_LINE('Éxito: El libro encontrado es "' || v_titulo || '"');

EXCEPTION

    --4.Excepción Predefinida: Cuando la consulta no devuelve ninguna fila
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: No se encontró ningún libro con el ID ' || v_id_buscado || '. Verifica el código.');
    --5.Excepción Predefinida: Cuando la consulta devuelve MÁS de una fila y usamos INTO
    WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE('ALERTA: Se encontró más de un libro. Se esperaba solo uno.');
    --6.Excepción General: Atrapa cualquier otro error no contemplado arriba
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inesperado del sistema: ' || SQLERRM);
END;

--8. CREACIÓN DE PROCEDIMIENTOS
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

--9. CREACIÓN DE FUNCIONES
CREATE OR REPLACE FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER IS
    v_total_stock NUMBER;
BEGIN
    --1.Sumamos la cantidad disponible de todos los libros que pertenecen a este autor
    SELECT SUM(cantidad_disponible) INTO v_total_stock
    FROM libros
    WHERE id_autor = p_id_autor;
    --2.Si el autor no tiene libros registrados, la suma dará NULL, así que lo convertimos a 0
    RETURN NVL(v_total_stock, 0);
END;

--10. CREACIÓN DE PACKAGES
CREATE OR REPLACE PACKAGE BibliotecaPKG IS
    --1.deleteFunción: Calcula cuántos libros en total tiene un autor
    FUNCTION StockTotalAutor(p_id_autor NUMBER) RETURN NUMBER;
    --2.Procedimiento: Registra la devolución de un libro
    PROCEDURE RegistrarDevolucion(p_id_prestamo NUMBER);
END BibliotecaPKG;

--11. CREACIÓN DE TRIGGERS
CREATE OR REPLACE TRIGGER trg_descontar_stock_libro
AFTER INSERT ON prestamos
FOR EACH ROW
BEGIN
    --1.Actualizamos la tabla libros restando 1 a la cantidad disponible
    UPDATE libros
    SET cantidad_disponible = cantidad_disponible - 1
    WHERE id_libro = :NEW.id_libro;
END;
