create database hito3_lenguaje_procedural;

use hito3_lenguaje_procedural;

set @admin = 'ADMIN';

select @admin;

set @admin = 'GUEST';

set @admin = 'Dereck';

create or replace function ejemplo1() returns varchar(30)
begin
    declare response varchar(30) default '';
    if @admin = 'ADMIN'
    then
        set response = 'Usuario admin';
    else
        set response = 'Usuario invitado';
    end if;
    return response;
end;

select ejemplo1();

create function ejemplo2() returns varchar(30)
begin
    declare response varchar(30) default '';
    case
        when @admin = 'ADMIN' then set response = 'Usuario admin';
        when @admin = 'GUEST' then set response = 'Usuario invitado';
        else set response = 'Usuario nuevo';
        end case;
    return response;
end;

select ejemplo2();

-- crear variable global precio (numero)
-- si el precio es mayor a 10 y menor igual a 20 retornar Basico
-- si el precio es mayor a 20 y menor igual a 30 retornar Intermedio
-- si el precio es mayor a 30 y menor igual a 50 retornar Superior
-- si el precio es mayor a 50 retornar Desconocido

set @precio = 5;
set @precio = 15;
set @precio = 20;
set @precio = 25;
set @precio = 35;
set @precio = 45;
set @precio = 55;

select @precio;

create or replace function ejemplo3() returns varchar(50)
begin
    declare response varchar(50) default '';
    case
        when @precio > 10 and @precio <= 20 then set response = 'Basico';
        when @precio > 20 and @precio <= 30 then set response = 'Intermedio';
        when @precio > 30 and @precio <= 50 then set response = 'Superior';
        when @precio > 50 then set response = 'Desconocido';
        else set response = 'error';
        end case;
    return response;
end;

select ejemplo3();

-- ejemplo 4

create or replace function ejemplo4() returns varchar(50)
begin
    declare response varchar(50) default '';
    case
        when @credit_number > 50000 then set response = 'PLATINUM';
        when @credit_number >= 10000 and @credit_number <= 50000 then set response = 'GOLD';
        when @credit_number < 10000 then set response = 'SILVER';
        else set response = 'error';
        end case;
    return response;
end;

set @credit_number = 50000;
set @credit_number = 50001;
set @credit_number = 15000;
set @credit_number = 1000;

select ejemplo4();

-- Bucles

create or replace function ejemplo5(limitWhile int) returns text
    begin
        declare x int default 2;
        declare str text default '';
        while x <= limitWhile DO
        set str = CONCAT(str, x, ',');
        set x = x + 2;
    end while;
    return str;
end;

select ejemplo5(10);

-- Ejercicio 1
-- Crear una funcion WHILE recibe INT, si es par generar los pares hasta ese numero INT, si es impar generar impar

create or replace function ejercicio1(limitWhile int) returns text
    begin
        declare x int default 0;
        declare response text default '';
        if limitWhile mod 2 = 0
        then
        set x = 2;
        while x <= limitWhile DO
        set response = CONCAT(response, x, ',');
        set x = x + 2;
        end while;
        else
        set x = 1;
        while x <= limitWhile DO
        set response = CONCAT(response, x,',');
        set x = x + 2;
        end while;
    end if;
    return response;
end;

select ejercicio1(10);

-- Ejercicio 2 Ascendente con un WHILE

create or replace function ejercicio2(limitWhile int) returns text
begin
    declare x int default 0;
    declare response text default '';
    if limitWhile mod 2 = 0 then
        set x = 2;
    else
        set x = 1;
    end if;
    while x <= limitWhile
        DO
            set response = CONCAT(response, x, ',');
            set x = x + 2;
        end while;

    return response;
end;


select ejercicio2(14);

-- Ejercicio 3 Descendentes con un WHILE

create or replace function ejercicio3(limitWhile int) returns text
begin
    declare x int default 1;
    declare response text default '';

    while limitWhile >= x
        DO
            set response = CONCAT(response, limitWhile, ',');
            set limitWhile = limitWhile - 2 ;
        end while;
    return response;
end;

select ejercicio3(12);


-- Ejercicio 4 REPEAT

create or replace function ejercicio4(limite int) returns text
begin
    declare response text default '';

    repeat
        set response = CONCAT(response, limite,',');
        set limite = limite - 1;
    until 1 > limite end repeat;

    return response;
end;

select ejercicio4(10);

-- Ejercicio 5 REPEAT

create or replace function ejercicio5(limite int) returns text
begin
    declare response text default '';
    repeat
        if limite mod 2 = 0 then
        set response = CONCAT(response, limite,' -AA- ');
        set limite = limite - 1;
        else
        SET response = CONCAT(response, limite,' -BB- ');
        SET limite = limite - 1;
        end if;
    until 1 > limite end repeat;
    return response;
end;

select ejercicio5(10);




