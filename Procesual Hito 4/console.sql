create database EvaluacionHito4;

use EvaluacionHito4;

-- Pregunta 9

create table departamento
(
        id_dep int primary key auto_increment not null,
        nombre varchar(50) not null
);

insert into departamento(nombre) values
('La Paz'),
('Cochabamba'),
('El Alto');

create table proyecto
(
    id_proyecto int primary key auto_increment not null,
    nombre_Proy varchar (100) not null,
    tipo_Proy varchar(30) not null
);

insert into proyecto(nombre_Proy, tipo_Proy) values
('Proyecto1','Tipo1'),
('Proyecto2','Tipo2'),
('Proyecto3','Tipo3'),
('Proyecto4','Tipo4');

create table provincia
(
    id_prov int primary key auto_increment not null,
    nombre varchar(30),
    id_dep int not null,
    foreign key (id_dep) references departamento(id_dep)
);

insert into provincia(nombre, id_dep) values
('Provincia1', 1),
('Provincia2', 2),
('Provinvia3', 3),
('Provinvia4', 3);

create table persona
(
    id_per int primary key auto_increment not null,
    nombre varchar(20) not null,
    apellido varchar(50) not null,
    fecha_nac date not null,
    edad varchar(11) not null,
    email varchar(50) not null,
    id_dep int not null,
    id_prov int not null,
    sexo char(1) not null,
    foreign key (id_dep) references departamento(id_dep),
    foreign key (id_prov) references provincia(id_prov)
);

insert into persona(nombre, apellido, fecha_nac, edad, email, id_dep, id_prov, sexo) values
('Persona1','Apellido1','2001-11-13','21','Persona1@gmail.com',1,1,'M'),
('Persona2','Apellido2','2003-08-17','19','Persona2@gmail.com',2,2,'F'),
('Carol','Calle Vargas','2000-10-10',22,'Carol@gmail.COM',3,3,'F'),
('Araceli','Casas Perez','2000-10-10',22,'Araceli@gmail.COM',3,4,'F');

create table detalle_proyecto
(
    id_dp int primary key auto_increment not null,
    id_per int not null,
    id_proy int not null,
    foreign key (id_per) references persona(id_per),
    foreign key (id_proy) references proyecto(id_proyecto)
);

insert into detalle_proyecto(id_per, id_proy) values
(1,1),
(2,2),
(3,3),
(4,4);

-- Pregunta 11
create or replace view busqueda as
select CONCAT(p.nombre,' ',p.apellido) AS Nombres_Y_Apellidos,
           p.EDAD AS EDAD,
           p.FECHA_NAC AS Fecha_De_Nacimiento,
        PROYECTO.NOMBRE_PROY AS NOMBRE_DEL_PROYECTO
FROM PERSONA as p
INNER JOIN DEPARTAMENTO as d ON P.ID_DEP = d.ID_DEP
INNER JOIN DETALLE_PROYECTO as DP ON P.ID_PER = dp.ID_PER
INNER JOIN PROYECTO ON dp.ID_PROY = PROYECTO.ID_PROYECTO
WHERE P.SEXO='F' and  d.NOMBRE='EL ALTO' and P.FECHA_NAC='2000-10-10' ;

SELECT *
FROM Busqueda;

-- Pregunta 12
/*○ Crear TRIGGERS Before or After para INSERT y UPDATE aplicado a la tabla
PROYECTO
■ Debera de crear 2 triggers minimamente.
○ Agregar un nuevo campo a la tabla PROYECTO.
■ El campo debe llamarse ESTADO
6
○ Actualmente solo se tiene habilitados ciertos tipos de proyectos.
■ EDUCACION, FORESTACION y CULTURA
○ Si al hacer insert o update en el campo tipoProy llega los valores
  EDUCACION, FORESTACIÓN o CULTURA, en el campo ESTADO colocar el valor
  ACTIVO. Sin embargo se llegat un tipo de proyecto distinto colocar INACTIVO
○ Adjuntar el código SQL generado y una imagen de su correcto funcionamiento*/

ALTER TABLE PROYECTO ADD (ESTADO VARCHAR(30));

INSERT INTO PROYECTO(NOMBRE_PROY, TIPO_PROY)
VALUES ('EDUCACION PERSONAS ESPECIALES','EDUCACION'),
       ('PLANTACION DE ARBOLES','FORESTACION'),
       ('LOS AZTECAS','CULTURA');

CREATE OR REPLACE TRIGGER UPDATE_TIP_PROY
BEFORE UPDATE ON PROYECTO
FOR EACH ROW
    BEGIN
        IF  NEW.TIPO_PROY='EDUCACION'OR  NEW.TIPO_PROY ='FORESTACION' OR  NEW.TIPO_PROY= 'CULTURA'
            THEN SET NEW.ESTADO='ACTIVO';
        ELSE
            SET NEW.ESTADO='INACTIVO';
        END IF;
    END;

CREATE OR REPLACE TRIGGER ADD_TIP_PROY
BEFORE  INSERT ON PROYECTO
FOR EACH ROW
    BEGIN
        IF  NEW.TIPO_PROY='EDUCACION'OR  NEW.TIPO_PROY ='FORESTACION' OR  NEW.TIPO_PROY= 'CULTURA'
            THEN SET NEW.ESTADO='ACTIVO';
        ELSE
            SET NEW.ESTADO='INACTIVO';
        END IF;
    end;

INSERT INTO PROYECTO(NOMBRE_PROY, TIPO_PROY)
VALUES ('ARBOLESS','EDUCACION');

select *
from proyecto;

-- Pregunta 13 El trigger debe de llamarse calculaEdad.
-- El evento debe de ejecutarse en un BEFORE INSERT.
-- Cada vez que se inserta un registro en la tabla PERSONA, el trigger debe de calcular la edad en función a la fecha de nacimiento.
-- Adjuntar el código SQL generado y una imagen de su correcto funcionamiento.

CREATE OR REPLACE TRIGGER calculaEdad
BEFORE INSERT ON persona
FOR EACH ROW
    BEGIN
        SET NEW.EDAD= TIMESTAMPDIFF(YEAR,NEW.FECHA_NAC,CURDATE());
    end;

INSERT INTO  persona(NOMBRE, APELLIDO, FECHA_NAC, EMAIL, ID_DEP, ID_PROV, SEXO)
VALUES  ('Maria','Galarza Ortega','1992-12-15','Maria@gmail.com',2,2,'F');



-- Pregunta 14 jo de TRIGGERS III.
-- Crear otra tabla con los mismos campos de la tabla persona(Excepto el primary key id_per).
-- Cada vez que se haga un INSERT a la tabla persona estos mismos valores deben insertarse a la tabla copia.
-- Para resolver esto deberá de crear un trigger before insert para la tabla PERSONA.
-- Adjuntar el código SQL generado y una imagen de su correcto funcionamiento


CREATE TABLE COPIA_PERSONA
(
  NOMBRE VARCHAR(20),
  APELLIDOS VARCHAR(50),
  FECHA_NAC DATE,
  EDAD INT,
  EMAIL VARCHAR(50),
  ID_DEP INT NOT NULL ,
  ID_PROV INT NOT NULL,
  GENERO VARCHAR(1),
  FOREIGN KEY (ID_PROV) REFERENCES  PROVINCIA(ID_PROV),
  FOREIGN KEY (ID_DEP) REFERENCES DEPARTAMENTO(ID_DEP)
);

CREATE OR REPLACE TRIGGER COPIAR_PERSONA
BEFORE INSERT ON PERSONA
FOR EACH ROW
    BEGIN
        INSERT INTO COPIA_PERSONA(NOMBRE, APELLIDOS, FECHA_NAC, EDAD, EMAIL, ID_DEP, ID_PROV, GENERO)
        VALUES(NEW.NOMBRE,NEW.APELLIDO,NEW.FECHA_NAC,NEW.EDAD,NEW.EMAIL,NEW.ID_DEP,NEW.ID_PROV,NEW.SEXO);
    end;

INSERT INTO PERSONA(NOMBRE, APELLIDO, FECHA_NAC, EDAD, EMAIL, ID_DEP, ID_PROV, SEXO)
VALUES ('Pedro','Aliaga Caceres','2000-12-15',22,'Pedro@gmail.com',1,1,'M');


select *
from COPIA_PERSONA;

-- Pregunta 15
-- La consulta generada convertirlo a VISTA

CREATE OR REPLACE VIEW TODAS_LAS_TABLAS AS
SELECT CONCAT(P.NOMBRE, ' ', P.APELLIDO) AS NOMBRE_Y_APELLIDOS,
       P.EDAD AS EDAD,
       D.NOMBRE AS DEPARTAMENTO,
       PR.NOMBRE AS PROVINCIA,
       CONCAT(PROY.NOMBRE_PROY, ': ', TIPO_PROY) AS PROYECTO
FROM PERSONA as P
         INNER JOIN DEPARTAMENTO as D ON P.ID_DEP = D.ID_DEP
         INNER JOIN PROVINCIA as PR ON P.ID_PROV = P.ID_PROV
         INNER JOIN DETALLE_PROYECTO as DP ON P.ID_PER = DP.ID_PER
         INNER JOIN PROYECTO as PROY ON DP.ID_PROY = PROY.ID_PROYECTO;

SELECT * FROM (TODAS_LAS_TABLAS);

drop database EvaluacionHito4