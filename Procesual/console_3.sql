create database TareaHito2;

use TareaHito2;

create table estudiantes(
  id_est int primary key auto_increment not null,
  nombres varchar(50) not null,
  apellidos varchar(50) not null,
  edad int not null,
  fono int not null,
  email varchar(100) not null,
  dirrecion varchar (100) not null,
  sexo varchar(20) not null
);
insert into estudiantes(nombres,apellidos,edad,fono,email,dirrecion,sexo)
values('Miguel','Gonzales Veliz',20,2832115,'Miguel@gmail.com','Av. 6 de agosto','masculino'),
      ('Sandra','Mavir Uria',25,2832116,'Sandra@gmail.com','Av. 6 de agosto','femenino'),
      ('Joel','Aduburi Mondar',30,2832117,'Joel@gmail.com','Av. 6 de agosto','masculino'),
      ('Andrea','Arias Ballesteros',21,2832118,'Andrea@gmail.com','Av. 6 de agosto','femenino'),
      ('Santos','Montes Valenzuela',24,2832119,'Santos@gmail.com','Av. 6 de agosto','masculino');

create table materias(
  id_mat int primary key auto_increment not null,
  nombre_mat varchar(100) not null,
  cod_mat varchar(100) not null
  );
insert into materias (nombre_mat,cod_mat)
values ('introduccion a la arquitectura','ARQ-101'),
('Urbanismo y diseño','ARQ-102'),
('Dibujo y pintura arquitectonico','ARQ-103'),
('Matematica discreta','ARQ-104'),
('Fisica basica','ARQ-105');
create or replace table inscripcion(
  id_ins int primary key auto_increment not null,
  semestre varchar(20) not null,
  gestion int not null,
  id_est int not null,
  id_mat int not null,
  foreign key(id_est) references estudiantes(id_est),
  foreign key(id_mat) references materias(id_mat)
  );
insert into inscripcion(id_est,id_mat,semestre,gestion)
values(1,1,'1er Semestre',2018),
(1,2,'2do Semestre',2018),
(2,4,'1er Semestre',2019),
(2,3,'2do Semestre',2019),
(3,3,'2do Semestre',2020),
(3,1,'3er Semestre',2020),
(4,4,'4to Semestre',2021),
(5,5,'5to Semestre',2021);

-- 1

select est.nombres, est.apellidos, mat.nombre_mat
from estudiantes as est
inner join inscripcion as ins on ins.id_est=est.id_est
inner join materias as mat on mat.id_mat=ins.id_mat
where cod_mat = 'ARQ-105';

create function Comparamaterias(cod_mat varchar(50), nombre_mat varchar(50)) returns boolean
begin
    declare answer boolean;

    if cod_mat = nombre_mat
        then
        set answer = 1;
    end if;
    return answer;
end;

select e.id_est, e.nombres, e.apellidos, m.nombre_mat, m.cod_mat
from inscripcion
inner join estudiantes e on inscripcion.id_est = e.id_est
inner join materias m on inscripcion.id_mat = m.id_mat
where Comparamaterias(m.cod_mat, 'ARQ-105');

-- 2

create function promedio(genero varchar(50), codmat varchar(50)) returns int
begin
    declare promedio int default 0;
    select avg(e.edad) into promedio
    from inscripcion
    inner join estudiantes as e on inscripcion.id_est = e.id_est
    inner join materias as m on inscripcion.id_mat = m.id_mat
    where e.sexo = genero and m.cod_mat = codmat;
    return promedio;
end;

select promedio('femenino','ARQ-104') as Promedio;

-- 3
create function concatcadenas(c1 varchar(40), c2 varchar(40), c3 varchar(40) ) returns varchar(200)
begin
    declare chain varchar(70) default '';
    set chain = concat('(',c1,') (',c2,') (',c3,')');
    return chain;
end;

select concatcadenas('Pepito','Pep','50') as Datos;

-- 4
create or replace function nombre(sexo varchar(50),edad int) returns boolean
begin
    declare suma int default 0;
    declare YN boolean default 0;

    select sum(est.edad) into suma
    from estudiantes as est
    where est.sexo = sexo;
    if  suma >= edad and suma % 2=0
        then
            set YN = 1;
        end if;
    return YN;
end;

select sum(e.edad)
from estudiantes as e
where sexo = 'masculino'
group by (e.sexo);


select e.nombres, e.apellidos, e.edad, i.semestre
from inscripcion as i
inner join estudiantes e on i.id_est = e.id_est
where nombre('Masculino' ,22) and e.edad > 22;

-- 5
create or replace function nombreCompleto(nombre varchar(100), nombre2 varchar(100), apellido varchar(100),  apellido2 varchar(100)) returns varchar(500)
begin
    declare comparador boolean;
    if nombre = nombre2 and apellido = apellido2
        then set comparador = 1;
        end if;
    return comparador;
end;

select *
from estudiantes as e
where nombreCompleto(e.nombres,'Andrea',e.apellidos,'Arias Ballesteros')