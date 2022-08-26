/****************************************************************
************************Operadores de compara��o*****************
************************ALTER TABLE******************************
************************UPDATE SET*******************************
************************WHERE************************************
*****************************************************************/


--Operadores de compara��o
-- = igual
-- > Maior que
-- >= Maior ou igual que
-- < Menor que
-- <= Menor ou igual que
-- <> ou != Diferente de/ N�o igual
-- BETWEEN... AND... Entre dois valores(inclusive)
-- IN(list) Igual a um dos valores da lista
-- NOT IN(list) N�o � igual a um dos valores da lista
-- LIKE Igual a um padr�o de caracteres
-- IS NULL Possui valor nulo
-- IS NOT NULL N�o possui valor nulo


--A cl�sula DEFAULT na cria��o de um campo, significa que para aquele campo, todos os novos registros ser�o de acordo com o valor informado
--SINTAXE: ALTER TABLE table_name ADD column_name type DEFAULT default_value;
ALTER TABLE TALUNO ADD ESTADO CHAR(2) DEFAULT 'RS';
ALTER TABLE TALUNO ADD SALARIO NUMBER(8,2) DEFAULT 620;

--OBS: Esta cl�usula tamb�m serve para a execu~��o do comando CREATE TABLE

UPDATE TALUNO SET
ESTADO = 'AC' ,
SALARIO = 250
WHERE COD_ALUNO = 1;

UPDATE TALUNO SET
ESTADO = 'MT',  SALARIO = 2000
WHERE COD_ALUNO = 2;

UPDATE TALUNO SET
ESTADO = 'SP', SALARIO = 800
WHERE COD_ALUNO = 5;

SELECT * FROM TALUNO;

COMMIT;


SELECT * FROM TALUNO
 WHERE ESTADO <> 'RS'
   AND SALARIO <= 800
 ORDER BY SALARIO DESC;

INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)
VALUES (SEQ_ALUNO.NEXTVAL,'VALDO','DOIS IRMAOS');

INSERT INTO TALUNO (COD_ALUNO, NOME,CIDADE)
VALUES (SEQ_ALUNO.NEXTVAL,'ALDO','QUATRO IRMAOS');

SELECT * FROM TALUNO;

UPDATE TALUNO SET
ESTADO = 'SP',
SALARIO = 900,
NOME = 'PEDRO'
WHERE COD_ALUNO = 25;

SELECT ESTADO, SALARIO, NOME FROM TALUNO
ORDER BY ESTADO, SALARIO DESC;

-- 31/12/1899 - DATA Zero
-- 01/01/1900 - DATA 1
--
ALTER TABLE TALUNO ADD NASCIMENTO DATE DEFAULT SYSDATE - 1000;
--

SELECT SYSDATE - SYSDATE - 10 FROM DUAL;


--
SELECT * FROM TALUNO

--
UPDATE TALUNO SET
NASCIMENTO='10/10/2001'
WHERE COD_ALUNO=1;

--
UPDATE TALUNO SET
NASCIMENTO='10/08/2000'
WHERE COD_ALUNO=2;


--
SELECT * FROM TALUNO
--
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO) AS nascimento, NOME
FROM TALUNO
WHERE Trunc(NASCIMENTO) = '25/08/2010';

--
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO), NOME
FROM TALUNO
WHERE NASCIMENTO
 BETWEEN TO_DATE('25/08/2010 22:00','DD/MM/YYYY HH24:MI')
  AND TO_DATE('25/08/2010 23:26','DD/MM/YYYY HH24:MI')


--Operadores de compara��o
-- = igual
-- > Maior que
-- >= Maior ou igual que
-- < Menor que
-- <= Menor ou igual que
-- <> ou != Diferente de/ N�o igual


SELECT COD_CONTRATO, DATA, TOTAL,
       DESCONTO, DESCONTO + 1000 AS CALCULO
FROM TCONTRATO
WHERE TOTAL <= DESCONTO + 1000;

--
SELECT * FROM TCONTRATO;

--
UPDATE TCONTRATO SET
DESCONTO = NULL
WHERE COD_CONTRATO = 2;
--
SELECT * FROM TCONTRATO
WHERE DESCONTO IS NULL;
--
SELECT * FROM TCONTRATO
WHERE DESCONTO IS NOT NULL;
--
SELECT * FROM TCONTRATO
WHERE DESCONTO BETWEEN 0 AND 10;


--Nvl 0> Colunar com valor null
--BETWEEN -> Entre
SELECT COD_CONTRATO, TOTAL, DESCONTO, NVL(DESCONTO,0)
FROM TCONTRATO
WHERE NVL(DESCONTO,0) BETWEEN 0 AND 10;

--mesmo efeito do between

SELECT * FROM TCONTRATO
WHERE DESCONTO >= 0
AND DESCONTO <= 10
OR DESCONTO IS NULL;

--  IN  /// NOT IN
SELECT * FROM TITEM
WHERE COD_CURSO IN (1, 2, 4);

SELECT * FROM TITEM
WHERE COD_CURSO NOT IN (1, 2, 4);

SELECT * FROM tcurso

INSERT INTO TCURSO VALUES (5, 'WINDOWS', 1000, 50 );

--CURSOS NAO VENDIDOS
SELECT * FROM TCURSO
WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)


--CURSOS VENDIDOS
SELECT * FROM TCURSO
WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)


--equivalente ao SELECT IN
SELECT * FROM TITEM
WHERE COD_CURSO = 1
OR COD_CURSO    = 2
OR COD_CURSO    = 4;

--somente onde a segunda letra seja A
SELECT * FROM TCURSO WHERE NOME LIKE 'W%'     --Registros que inicia com W
SELECT * FROM TCURSO WHERE NOME LIKE '%JAVA%'
SELECT * FROM TCURSO WHERE NOME LIKE '%FACES'

SELECT * FROM TCURSO;

COMMIT;

ALTER TABLE TCURSO ADD PRE_REQ INTEGER;

UPDATE TCURSO SET
PRE_REQ = 1
WHERE COD_CURSO = 2;

UPDATE TCURSO SET
PRE_REQ = 3
WHERE COD_CURSO = 4;

--cursos sem pre requisito
SELECT * FROM TCURSO WHERE PRE_REQ IS NULL

--cursos com pre-requisitos
SELECT * FROM TCURSO WHERE PRE_REQ IS NOT NULL
--

--Precedencia de operadores
-- ()
-- AND
-- OR
SELECT * FROM tcurso
WHERE valor > 750
OR valor < 1000
AND carga_horaria = 25
--

SELECT * FROM tcurso
WHERE (valor > 750
or valor < 1000)
and carga_horaria = 25;


-- Ordem de execu��o
-- 1 - Paranteses
-- 2 - AND
-- 3 - OR
