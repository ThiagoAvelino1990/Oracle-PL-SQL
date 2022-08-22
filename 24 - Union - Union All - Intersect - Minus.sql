----------------------------------OPERADORES SET----------------------------------
--Todos os SELECTs envolvidos devem possuir o mesmo número de colunas;
--As colunas correspondentes em cada um dos comandos devem ser do mesmo tipo;
--A Cláusula ORDER BY só se aplica ao resultado geral da união e deve utilizar indicação posicional em vez de expressões;
--As demais cláusulas que compõem um comando SELECT são tratadas individualmente nos comandos a que se aplicam;
--Todos os operadores (UNION, UNION ALL,INTERSECT, MINUS) possuim igual procedência
--A operação de união efetua uma soma de conuntos eliminando as duplocidades
--UNION elimina do resultado todas as linhas duplicadas. Esta operação pode realizar SORT para garantir a retirada das duplicadas;
--UNION ALL apresenta no resultado todas as linhas produzidas no processo de união, independente de serem duplicadas ou não;
--A operação de interseção restringe o conjunto resultante ás linhas presente em todos os conjutos participantes da operação;
--A cláusula INTERSECT elimina do resultado todas as linhas não duplicadas. O resultado mostra somente as linhas que são comuns em todos os conjuntos.
--  Esta operação pode realizar SORT para garantir a retirada das duplicadas
--A operação de diferença efetua uma subtração de conjuntos eliminando as duplicidades
--As regras já apresentadas na UNION e INTERSECT devem ser obedecidas na diferença



----  UNION ALL - UNION -  INTERSECT - MINUS

  SELECT COD_ALUNO, TOTAL , DESCONTO
  FROM TCONTRATO
  WHERE COD_ALUNO = 1

  UNION ALL       ---Nao agrupa registros iguais
  --UNION         ---Agrupa registros iguais

  SELECT COD_ALUNO, TOTAL, DESCONTO
  FROM TCONTRATO
  WHERE TOTAL >= 1000;


--  UNION ALL e UNION com 3 SELECT's

SELECT COD_CONTRATO, DATA, total, 'UNION 1' AS QUERY
FROM   tcontrato
WHERE  TOTAL >= 1000 AND TOTAL < 2000

UNION  ALL      -- Traz todos os registros

SELECT COD_CONTRATO, DATA, total, 'UNION 2' AS QUERY
FROM   tcontrato
WHERE  desconto IS NOT NULL

UNION      --Agrupa os registros

SELECT COD_CONTRATO, DATA, total, 'UNION 3' AS QUERY
FROM   tcontrato
WHERE  total > 2000

ORDER  BY 1;




-- Exemplo de INTERSECT  (Traz somente os registros iguais, ou seja, que estão nas duas consultas)
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  DESCONTO IS NOT NULL

INTERSECT
--Registros estao presentes em todos os conjuntos.

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  TOTAL > 1000

ORDER  BY COD_CONTRATO;


--Exemplo de MINUS(Traz os registros que NÃO estão nas duas consultas, ou seja, "exclui" da consulta registros IGUAIS)
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  DESCONTO IS NOT NULL

MINUS  -- traz todos os registros da primeira consulta
       -- menos os da segunda consulta ( ignora repetido )

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  TOTAL > 2000

ORDER  BY 1;
