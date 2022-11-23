create database hito4;
use hito4;


create table usuarios
(
 id_usuarios integer auto_increment primary key not null ,
 nombre varchar(50) not null,
 apellido varchar(50) not null,
 edad integer not null ,
 email varchar(50) not null
);

alter table  usuarios add column contraseña varchar(50);

insert  into usuarios(nombre, apellido, edad, email)
    values('marco1','calle1',10,'marco1@gmail.com'),
          ('marco2','calle2',20,'marco2@gmail.com'),
          ('marco3','calle3',30,'marco3@gmail.com'),
          ('marco4','calle4',40,'marco4@gmail.com');
 insert into usuarios(nombre, apellido, edad, email)
        values  ('marco4','calle4',50,'marco4@gmail.com');

select*
from usuarios as usuarios;

create or replace  view usuarios_mayor_20 as
select nombre as fullname_persona,
       apellido as lastname_persona,
       edad as age_persona
from usuarios as usuarios
where edad > 10;



select*
from usuarios_mayor_20 as datos;

drop view usuarios_mayor_20;

#new = insert
#old = delete
#new/old= update

 insert into usuarios(nombre, apellido, edad, email)
        values  ('marco8','calle8',70,'marco7@gmail.com');

 insert into usuarios(nombre, apellido, edad, email)
        values  ('loca9','calle9',55,'marco9@gmail.com');

 insert into usuarios(nombre, apellido, edad, email)
        values  ('loca10','calle9',65,'marco9@gmail.com');

 insert into usuarios(nombre, apellido, edad, email)
        values  ('loca11','cal9',85,'marco1234@gmail.com');

create or replace  trigger  contraseña
    before insert  on usuarios
    for each row
    begin
        set NEW.contraseña= concat(substring(NEW.nombre,1,2),substring(NEW.apellido,1,2),substring(NEW.edad,1,2));
    end;


select* from usuarios as usuarios;



CREATE TABLE NUMEROS
(
    NUMERO BIGINT PRIMARY KEY NOT NULL,
    CUADRADO BIGINT,
    CUBO BIGINT,
    RAIZ REAL
);

INSERT INTO NUMEROS (NUMERO, CUADRADO, CUBO, RAIZ) VALUES (4,2,6,8);

SELECT * FROM NUMEROS;


CREATE OR REPLACE  TRIGGER MATEMATICA
    BEFORE INSERT ON NUMEROS
    FOR EACH ROW
    BEGIN
        DECLARE A BIGINT DEFAULT 0;
        DECLARE B BIGINT DEFAULT 0;
        DECLARE C BIGINT DEFAULT 0;
        DECLARE D REAL DEFAULT 0;
        DECLARE TODO INTEGER DEFAULT  0;

        SET A=NEW.NUMERO;
        SET B= POW(NEW.CUADRADO,2);
        SET C= POW(NEW.CUBO,3);
        SET D= SQRT(NEW.RAIZ);

        SET NEW.NUMERO=A;
        SET NEW.CUADRADO=B;
        SET NEW.CUBO=C;
        SET NEW.RAIZ=D;

    end;

INSERT INTO NUMEROS (NUMERO, CUADRADO, CUBO, RAIZ) VALUES (8,4,16,48);
INSERT INTO NUMEROS (NUMERO, CUADRADO, CUBO, RAIZ) VALUES (20,14,20,24);

SELECT* FROM NUMEROS