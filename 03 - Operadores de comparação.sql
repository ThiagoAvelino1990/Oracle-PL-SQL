/****************************************************************
************************Operadores de compara��o*****************
************************ALTER TABLE******************************
************************UPDATE SET*******************************
************************WHERE************************************
************************TRUNC************************************
************************TO_DATE**********************************
************************DESC*************************************
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
--OBS: Esta cl�usula tamb�m serve para a execu��o do comando CREATE TABLE, para par�metros de uma PROCEDURE, FUNCTION, CURSOR...

--Altera��es nos dados da tabela realizadas atrav�s do operador SET
--
UPDATE TALUNO SET 
              ESTADO = 'AC' , 
              SALARIO = 250
 WHERE COD_ALUNO = 1;

--
UPDATE TALUNO SET
              ESTADO = 'MT',  
              SALARIO = 2000
 WHERE COD_ALUNO = 2;

--
UPDATE TALUNO SET
              ESTADO = 'SP', 
              SALARIO = 800
 WHERE COD_ALUNO = 5;

--
SELECT * FROM TALUNO;

--COMMIT para confirmar altera��es realizadas pelos UPDATES
COMMIT;


--Utilizando operadores de compara��o
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

--Cl�usula DESC utilizada para buscar resultados em ordem descrescente.
/* No exemplo abaixo, a consulta ir� ordenar primeiramente pela coluna ESTADO, e depois pela coluna SALARIO, ou seja,
   o grupo da coluna ESTADO ser� ordenado e em seguida a coluna SALARIO de acordo com o grupo ESTADO
*/
SELECT ESTADO, SALARIO, NOME 
  FROM TALUNO
 ORDER BY ESTADO, SALARIO DESC;


--Incluindo o campo NASCIMENTO na tabela TALUNO com as cl�usulas DEFAULT e SYSDATE
ALTER TABLE TALUNO ADD NASCIMENTO DATE DEFAULT SYSDATE - 1000;


--
UPDATE TALUNO SET
              NASCIMENTO='10/10/2001'
 WHERE COD_ALUNO=1;

--
UPDATE TALUNO SET
              NASCIMENTO='10/08/2000'
 WHERE COD_ALUNO=2;

--COMMIT;

--
SELECT * FROM TALUNO


--TRUNC � uma fun��o para arredondar n�meros. Utilizando em campos do tipo data, est� fun��o retira  as horas
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO) AS nascimento, NOME
FROM TALUNO
WHERE TRUNC(NASCIMENTO) = '25/08/2010';


--Fun��o TO_DATE transforma um campo em data de acordo com a formata��o 
SELECT COD_ALUNO, NASCIMENTO, Trunc(NASCIMENTO), NOME
FROM TALUNO
WHERE NASCIMENTO
 BETWEEN TO_DATE('25/08/2010 22:00','DD/MM/YYYY HH24:MI')
  AND TO_DATE('25/08/2010 23:26','DD/MM/YYYY HH24:MI')


--Realizando c�lculos com os valores das tabelas, sem alterar
SELECT COD_CONTRATO, DATA, TOTAL,
       DESCONTO, (DESCONTO + 1000) AS CALCULO
  FROM TCONTRATO
 WHERE TOTAL <= (DESCONTO + 1000);

--
SELECT * FROM TCONTRATO;

--Operadores NULL
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


--Utilizando a fun��o NVL para trazer colunas aonde os valores s�o nulos.
--Operador BETTWEEN aonde busca resultados entre dois valores.
SELECT COD_CONTRATO, TOTAL, DESCONTO, NVL(DESCONTO,0)
  FROM TCONTRATO
 WHERE NVL(DESCONTO,0) BETWEEN 0 AND 10;


--Utilizando o SELECT abaixo com as cl�usulas/ operadores OR >= e <=, temos o mesmo efeito do BETWEEN
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

SELECT * FROM TCURSO
WHERE COD_CURSO NOT IN (SELECT COD_CURSO FROM TITEM)

SELECT * FROM TCURSO
WHERE COD_CURSO IN (SELECT COD_CURSO FROM TITEM)


--SELECT utilizando a cl�usula OR ao qual o mesmo tem equival�ncia a lista IN
SELECT * FROM TITEM
 WHERE COD_CURSO = 1
    OR COD_CURSO    = 2
    OR COD_CURSO    = 4;

--Utilizando o operador LIKE
--Neste exemplo a consulta ir� retornar todos os cursos que comecem com o nome 'W'
SELECT * FROM TCURSO WHERE NOME LIKE 'W%'     
--Neste exemplo a consulta ir� retornar todos os cursos que contenham o nome 'JAVA'
SELECT * FROM TCURSO WHERE NOME LIKE '%JAVA%'
--Neste exemplo a consulta ir� retornar todos os cursos que terminam com o nome 'FACES'
SELECT * FROM TCURSO WHERE NOME LIKE '%FACES'

SELECT * FROM TCURSO;

COMMIT;

--INTEGER
ALTER TABLE TCURSO ADD PRE_REQ INTEGER;

UPDATE TCURSO SET
PRE_REQ = 1
WHERE COD_CURSO = 2;

UPDATE TCURSO SET
PRE_REQ = 3
WHERE COD_CURSO = 4;

SELECT * FROM TCURSO WHERE PRE_REQ IS NULL

SELECT * FROM TCURSO WHERE PRE_REQ IS NOT NULL

--Precedencia de execu��o dos operadores
-- 1� ()
-- 2� AND
-- 3� OR
SELECT * FROM tcurso
WHERE valor > 750
OR valor < 1000
AND carga_horaria = 25

--
SELECT * FROM tcurso
WHERE (valor > 750
or valor < 1000)
and carga_horaria = 25;

