/*
    Proyecto Taller Base de Datos
    "Sistema de Gestión de Biblioteca"
    Grupo: Sofía Arancibia y Martín Sanchez
    Tablas: Autores, Usuarios, Libros, Préstamos y Editorial
*/
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
