create database pollos_copa;

use pollos_copa;

create table cliente(
    id_cliente int primary key auto_increment not null,
    fullname varchar(100) not null,
    lastname varchar(100) not null,
    edad int not null,
    domicilio varchar(200) not null
);

insert into cliente(fullname, lastname, edad, domicilio)
values ('Juan','Perez',24,'Av Bolivia'),
 ('Pepito','Garcia',34,'Av 6 de agosto');

create or replace table pedido(
    id_pedido int primary key auto_increment not null,
    articulo varchar(100) not null,
    costo varchar(100) not null,
    fecha varchar(100) not null
);

insert into pedido(articulo, costo, fecha)
values ('Cubeta de pollo','50 Bs','2022-9-14'),
 ('Hamburguesa','15 Bs','2022-9-10');

create or replace table detalle_pedido(
    id_detalle_pedido int primary key auto_increment not null,
    id_cliente int not null,
    id_pedido int not null,
    foreign key(id_cliente) references cliente(id_cliente),
    foreign key(id_pedido) references pedido(id_pedido)
);

insert into detalle_pedido(id_cliente, id_pedido)
values(1,1),
      (2,2);

select c.lastname, c.fullname, c.domicilio, p.costo, p.fecha
from detalle_pedido as dp
inner join cliente c on dp.id_cliente = c.id_cliente
inner join pedido p on dp.id_pedido = p.id_pedido
where p.articulo = 'Hamburguesa'
