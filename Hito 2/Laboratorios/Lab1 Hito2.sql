create database funciones_agregacion;

use funciones_agregacion;

CREATE TABLE estudiantes
(
 id_est INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
 nombres VARCHAR(50),
 apellidos VARCHAR(50),
 edad INTEGER,
 fono INTEGER,
 email VARCHAR(100),
 direccion VARCHAR(100),
 sexo VARCHAR(10)
);

INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Miguel' ,'Gonzales Veliz', 20, 2832115, 'miguel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Sandra' ,'Mavir Uria', 25, 2832116, 'sandra@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Joel' ,'Adubiri Mondar', 30, 2832117, 'joel@gmail.com', 'Av. 6 de Agosto', 'masculino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Andrea' ,'Arias Ballesteros', 21, 2832118, 'andrea@gmail.com', 'Av. 6 de Agosto', 'femenino');
INSERT INTO estudiantes (nombres, apellidos, edad, fono, email, direccion, sexo)
  VALUES ('Santos' ,'Montes Valenzuela', 24, 2832119, 'santos@gmail.com', 'Av. 6 de Agosto', 'masculino');

CREATE TABLE materias
(
  id_mat INTEGER AUTO_INCREMENT PRIMARY KEY  NOT NULL,
  nombre_mat VARCHAR(100),
  cod_mat VARCHAR(100)
);

INSERT INTO materias (nombre_mat, cod_mat) VALUES ('Introduccion a la Arquitectura','ARQ-101');
INSERT INTO materias (nombre_mat, cod_mat) VALUES ('Urbanismo y Diseno','ARQ-102');
INSERT INTO materias (nombre_mat, cod_mat) VALUES ('Dibujo y Pintura Arquitectonico','ARQ-103');
INSERT INTO materias (nombre_mat, cod_mat) VALUES ('Matematica discreta','ARQ-104');
INSERT INTO materias (nombre_mat, cod_mat) VALUES ('Fisica Basica','ARQ-105');

CREATE TABLE inscripcion
(
  id_ins INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
  id_est INT NOT NULL,

  id_mat INT NOT NULL,
  semestre VARCHAR(20),
  gestion INTEGER,
  FOREIGN KEY (id_est) REFERENCES estudiantes (id_est),
  FOREIGN KEY (id_mat) REFERENCES materias (id_mat)
);

INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (1, 1, '1er Semestre', 2015);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (1, 2, '2do Semestre', 2015);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (2, 4, '1er Semestre', 2016);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (2, 3, '2do Semestre', 2016);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (3, 3, '2do Semestre', 2017);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (3, 1, '3er Semestre', 2017);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (4, 4, '4to Semestre', 2017);
INSERT INTO inscripcion (id_est, id_mat, semestre, gestion) VALUES (5, 5, '5to Semestre', 2017);

update inscripcion
set gestion = 2022
where id_est >= 0;

select * from inscripcion;

select est.nombres, est.apellidos, m.nombre_mat
from estudiantes as est
inner join inscripcion as ins on est.id_est = ins.id_est
inner join materias m on ins.id_mat = m.id_mat
where cod_mat = 'ARQ-104';



CREATE FUNCTION min_edad_estudianes() RETURNS int
BEGIN
 return
       (
         SELECT min(est.edad)
         FROM estudiantes AS est
       );
END;

SELECT min_edad_estudianes();

CREATE FUNCTION avg_edad_estudianes() RETURNS int
BEGIN
 return
       (
         SELECT avg(est.edad)
         FROM estudiantes AS est
       );
END;

select avg_edad_estudianes();

CREATE FUNCTION max_edad_estudianes(sexo varchar(20)) RETURNS int
BEGIN
 return
       (
         SELECT max(est.edad)
         FROM estudiantes AS est
         where est.sexo = sexo
       );
END;

DROP FUNCTION IF EXISTS max_edad_estudianes;

select max_edad_estudianes('femenino');

select *
from estudiantes;

-- 19. Mostrar el registro de la tabla estudiantes (nombre y apellidos) donde cuyo id_est sea el máximo.

CREATE FUNCTION max_id_estudiantes() RETURNS int
BEGIN
 return
       (
         SELECT max(id_est)
         FROM estudiantes AS est
       );
END;

DROP FUNCTION IF EXISTS max_id_estudiantes;

select max_id_estudiantes();

select nombres,apellidos
from estudiantes
where id_est = max_id_estudiantes();

-- 20
CREATE FUNCTION suma_edad_estudianes(sexo varchar(20)) RETURNS int
BEGIN
 return
       (
         SELECT sum(est.edad)
         FROM estudiantes AS est
         where est.sexo = sexo
       );
END;

DROP FUNCTION IF EXISTS suma_edad_estudianes;

select suma_edad_estudianes('femenino');

select *
from estudiantes
where suma_edad_estudianes('femenino') mod 2=0;

-- 21

CREATE FUNCTION suma_edad_estudianes_fem() RETURNS int
BEGIN
 return
       (
         SELECT sum(est.edad)
         FROM estudiantes AS est
         where est.sexo = 'femenino'
       );
END;

select suma_edad_estudianes_fem();

select *
from estudiantes
where sexo = 'femenino' and edad = suma_edad_estudianes_fem() % 2=0;

-- 22

CREATE FUNCTION sumEdadBySexo(sexoEst VARCHAR(10)) RETURNS INTEGER
BEGIN
   DECLARE sumaEdades INTEGER DEFAULT 0;

   SELECT SUM(est.edad) INTO sumaEdades
   FROM estudiantes AS est
   WHERE est.sexo = sexoEst;

   RETURN sumaEdades;
END;

SELECT est.nombres, est.apellidos
FROM estudiantes AS est
WHERE sumEdadBySexo('masculino') %2 = 0;

-- 23

CREATE FUNCTION avgEstudianesByEdad(sexo varchar(10)) RETURNS INTEGER
BEGIN
    DECLARE promedioEdades INT DEFAULT 0;
    SELECT avg(est.edad) into promedioEdades
    FROM estudiantes AS est
    WHERE est.sexo = sexo;

    RETURN promedioEdades;
END;

select avgEstudianesByEdad('masculino');

-- 24

CREATE FUNCTION sumEdadFem(sexo varchar(10)) RETURNS INTEGER
BEGIN
   DECLARE sumaEdades INTEGER DEFAULT 0;

   SELECT SUM(est.edad) INTO sumaEdades
   FROM estudiantes AS est
   WHERE est.sexo = sexo ;

   RETURN sumaEdades;
END;

create function getNombre(nombre varchar(100),apellidos varchar(100))
returns varchar(200)
begin
   declare nombreCompleto varchar(200);
   set nombreCompleto = CONCAT(nombre, ' ', apellidos);
   return nombreCompleto;
end;

select getNombre(est.nombres, est.apellidos) as persona
from estudiantes as est;

select CONCAT(est.nombres, ' ', est.apellidos) as Persona, sumEdadFem('femenino') as Edad
from estudiantes as est;
