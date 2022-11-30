
create or replace function fibonacci(numero int)
    returns text
BEGIN
    declare A int default 0;
    declare B int default 1;
    declare aux int default 0;
    declare count int default 0;
    declare chain text default '';
    set chain = CONCAT(A, ',', B);

    if numero = 1 THEN
        set chain = '0';
    elseif numero = 2 THEN
        set chain = '0,1';
    elseif numero <= 0 THEN
        set chain = 'EL NUMERO DEBE SER MAYOR A CERO';
    else
        REPEAT

            set AUX = A + B;
            set chain = CONCAT(chain, ',', AUX);
            set A = B;
            set B = AUX;
            set count = count + 1;
        UNTIL count = numero - 2 END REPEAT;

    END IF;
    RETURN chain;
END;

CREATE OR REPLACE FUNCTION sumifibonacci(serie TEXT)
    RETURNS INTEGER
BEGIN
    DECLARE suma INTEGER DEFAULT 0;
    DECLARE contador INTEGER DEFAULT 1;
    DECLARE fin INTEGER DEFAULT CHAR_LENGTH(serie);

    REPEAT
        SET suma = suma + SUBSTRING(serie, contador, 1);
        SET contador = contador + 2;
    until contador > fin END REPEAT;

    RETURN suma;
end;

SELECT fibonacci(6);
SELECT sumifibonacci(fibonacci(6));
