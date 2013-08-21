DROP TABLE Unidades CASCADE CONSTRAINTS;
DROP TABLE Colonias CASCADE CONSTRAINTS;
DROP TABLE Continentes CASCADE CONSTRAINTS;
DROP TABLE Juegos CASCADE CONSTRAINTS;
DROP TABLE Turnos CASCADE CONSTRAINTS;
DROP TABLE Equipos CASCADE CONSTRAINTS;
DROP TABLE Tipos_Unidades CASCADE CONSTRAINTS;
DROP TABLE Bitacora CASCADE CONSTRAINTS;

PURGE RECYCLEBIN;

CREATE TABLE Continentes
(
id_continente NUMBER(3),
nombre VARCHAR2(20),
valor NUMBER(3),
PRIMARY KEY (id_continente)
);

CREATE TABLE Equipos
(
id_equipo NUMBER(3),
color VARCHAR2(10),
energia NUMBER(3),
fase_actual NUMBER(1),
orden NUMBER(1),
PRIMARY KEY (id_equipo)
);

CREATE TABLE Colonias
(
id_colonia NUMBER(3),
id_continente NUMBER(3),
codigo VARCHAR2(3),
nombre VARCHAR2(25),
x NUMBER(2),
y NUMBER(2),
id_equipo NUMBER(3),
PRIMARY KEY (id_colonia)
);

CREATE TABLE Turnos
(
id_turno NUMBER(3),
id_equipo NUMBER(3),
puntaje NUMBER(3),
num_era NUMBER(1),
PRIMARY KEY (id_turno)
);

CREATE TABLE Tipos_Unidades
(
id_tipo_unidad NUMBER(3),
nombre VARCHAR2(20),
costo NUMBER(3),
poder_max NUMBER(3),
valor NUMBER(3),
PRIMARY KEY (id_tipo_unidad)
);

CREATE TABLE Unidades
(
id_unidad NUMBER(3),
id_colonia NUMBER(3),
id_tipo_unidad NUMBER(3),
PRIMARY KEY (id_unidad)
);

CREATE TABLE Juegos
(
equipo_actual NUMBER(3),
era_actual NUMBER(1),
cant_eras NUMBER(1) DEFAULT '5'
);

CREATE TABLE Bitacora
(
id_bitacora NUMBER(3),
id_turno NUMBER(3),
descripcion VARCHAR2(500)
);

ALTER TABLE Colonias ADD FOREIGN KEY (id_continente) REFERENCES Continentes (id_continente);

ALTER TABLE Colonias ADD FOREIGN KEY (id_equipo) REFERENCES Equipos (id_equipo);

ALTER TABLE Turnos ADD FOREIGN KEY (id_equipo) REFERENCES Equipos (id_equipo);

ALTER TABLE Unidades ADD FOREIGN KEY (id_colonia) REFERENCES Colonias (id_colonia);

ALTER TABLE Unidades ADD FOREIGN KEY (id_tipo_unidad) REFERENCES Tipos_Unidades (id_tipo_unidad);

ALTER TABLE Juegos ADD FOREIGN KEY (equipo_actual) REFERENCES Equipos (id_equipo);

ALTER TABLE Bitacora ADD FOREIGN KEY (id_turno) REFERENCES Turnos (id_turno);
