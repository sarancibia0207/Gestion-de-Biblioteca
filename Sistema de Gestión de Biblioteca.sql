/*
    Proyecto Taller Base de Datos
    "Sistema de Gestión de Biblioteca"
    Grupo: Sofía Arancibia y Martín Sanchez
    
    Tablas: Autores, Usuarios, Libros y Préstamos  
*/
--ELIMINACION TABLAS
DROP TABLE autores CASCADE CONSTRAINTS;
DROP TABLE usuarios CASCADE CONSTRAINTS;
DROP TABLE libros CASCADE CONSTRAINTS;
DROP TABLE prestamos CASCADE CONSTRAINTS;

--CREACIÓN DE TABLAS
--1.Autores
CREATE TABLE autores(
    id_autor NUMBER(6) NOT NULL,
    nombre VARCHAR2(150) NOT NULL,
    nacionalidad VARCHAR2(12),
    CONSTRAINT pk_autores PRIMARY KEY (id_autor)
);
--2.Usuarios
CREATE TABLE usuarios(
    id_usuario NUMBER(6) NOT NULL,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    telefono VARCHAR2(14),
    fecha_registro DATE,
    CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario)
);
--3.Libros
CREATE TABLE libros(
    id_libro NUMBER(6) NOT NULL,
    titulo VARCHAR2(150) NOT NULL,
    isbn VARCHAR2(13) UNIQUE,
    ano_publicacion NUMBER(4),
    cantidad_disponible NUMBER(7),
    id_autor NUMBER(6) NOT NULL,
    CONSTRAINT pk_libros PRIMARY KEY (id_libro),
    CONSTRAINT fk_bib_autores FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);


--4.Préstamos
CREATE TABLE prestamos(
    id_prestamos NUMBER(6) NOT NULL,
    id_libro NUMBER(6) NOT NULL,
    id_usuario NUMBER(6) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NOT NULL,
    CONSTRAINT pk_prestamos PRIMARY KEY (id_prestamos),
    CONSTRAINT fk_bib_libros FOREIGN KEY (id_libro) REFERENCES libros (id_libro),
    CONSTRAINT fk_bib_usuarios FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario)
);

--INSERTAR DATOS
--1.Autores
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(1,'Isabel Allende','Chilena');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(2,'Pedro Lemebel','Chileno');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(3,'Julio Cortázar','Argentino');
INSERT INTO autores(id_autor,nombre,nacionalidad)VALUES(4,'Ernesto Sabáto','Argentino');
--2.Usuarios
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(01,'Jordan Nacarate','jo.nacarate@gmail.com','+56920122006', DATE '2026-04-30');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(02,'Gaspar Arancibia','ga.arancibia@gmail.com','+56906102013', DATE '2025-10-06');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(03,'Constanza Tamayo','co.tamayo@gamil.com','+56926062006', DATE '2020-06-26');
INSERT INTO usuarios(id_usuario,nombre,email,telefono,fecha_registro)VALUES(04,'Peter Parker','pe.parker@gmail.com','+56910081962', DATE '2026-07-29');
--3.Libros
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(001,'Paula','2012200630046',1992,99,1);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(002,'Poco Hombre','0202200730046',2013,89, 2);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(003,'Rayuela','0610201306106',1963,78, 3);
INSERT INTO libros(id_libro, titulo, isbn, ano_publicacion, cantidad_disponible, id_autor)VALUES(004,'El túnel','2606200620200',1948,69, 4);
--4.Préstamos
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion)VALUES(0001,001,01,DATE '2025-10-13',DATE '2025-10-24');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion)VALUES(0002,002,02,DATE '2024-05-02',DATE '2024-06-01');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion)VALUES(0003,003,03,DATE '2025-03-27',DATE '2025-04-15');
INSERT INTO prestamos(id_prestamos,id_libro, id_usuario,fecha_prestamo, fecha_devolucion)VALUES(0004,004,04,DATE '2026-03-30',DATE '2026-05-20');

COMMIT;