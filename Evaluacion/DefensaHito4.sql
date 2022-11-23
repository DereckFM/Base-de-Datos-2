create database Defensa_Hito4;

use Defensa_Hito4;

create table departamento
(
        id_dep int primary key auto_increment not null,
        nombre varchar(50) not null
);

insert into departamento(nombre) values
('La Paz'),
('Cochabamba');

create table proyecto
(
    id_proyecto int primary key auto_increment not null,
    nombre_Proy varchar (100) not null,
    tipo_Proy varchar(30) not null
);

insert into proyecto(nombre_Proy, tipo_Proy) values
('Proyecto1','Tipo1'),
('Proyecto2','Tipo2');

create table provincia
(
    id_prov int primary key auto_increment not null,
    nombre varchar(30),
    id_dep int not null,
    foreign key (id_dep) references departamento(id_dep)
);

insert into provincia(nombre, id_dep) values
('Provincia1', 1),
('Provincia2', 2);

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
('Persona2','Apellido2','2003-08-17','19','Persona2@gmail.com',2,2,'F');

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
(2,2);

-- Ejercicio 1

CREATE TABLE auditoria_proyectos
(
    #columnas de auditoría
    nombre_proy_anterior varchar(30),
    nombre_proy_posterior varchar(30),
    tipo_proy_anterior varchar(30),
    tipo_proy_posterior varchar(30),
    operation varchar(30),
    userid varchar(30),
    hostname varchar(30)
);

CREATE OR REPLACE TRIGGER auditoria_proyectos
    BEFORE UPDATE
    ON proyecto
    FOR EACH ROW
BEGIN
    DECLARE nom_proy_A text default '';
    DECLARE nom_proy_B text default '';
    DECLARE tipo_proy_A text default '';
    DECLARE tipo_proy_B text default '';

    SET nom_proy_A =NEW.nombre_Proy;
    SET nom_proy_B =OLD.nombre_Proy;
    SET tipo_proy_A =NEW.tipo_Proy;
    SET tipo_proy_B =OLD.tipo_Proy;

    insert into auditoria_proyectos(operation, userid, hostname, nombre_proy_posterior, tipo_proy_posterior, nombre_proy_anterior, tipo_proy_anterior)
    SELECT 'Update', user(), @@hostname, nom_proy_A, tipo_proy_A,nom_proy_B, tipo_proy_B;
END;

select *
from proyecto;

-- Ejercicio 2

create or replace view Reporte_Proyecto as
select concat(per.nombre, ' ', per.apellido) as fullname ,
       concat(p.nombre_Proy, ':', p.tipo_Proy) as desc_proyecto,
       d.nombre as departamento,
       (case
        when d.nombre = 'La Paz' then 'LPZ'
        when d.nombre = 'Cochabamba' then 'CBB'
        when d.nombre = 'Santa Cruz' then 'SCZ'
        end) as Codigo
from detalle_proyecto as dp
inner join proyecto p on dp.id_proy = p.id_proyecto
inner join persona per on dp.id_per = per.id_per
inner join departamento d on per.id_dep = d.id_dep;

select *
from Reporte_Proyecto

