/****************************************************************
************************CREATE TABLE*****************************
************************INSERT INTO******************************
************************UPDATE***********************************
************************DELETE***********************************
************************DROP TABLE*******************************
************************SEQUENCE*********************************
************************SELECT***********************************
************************SELECT DISTINCT**************************
************************COMMIT***********************************
************************ROLLBACK*********************************
*****************************************************************/

--Criação de uma tabela
CREATE TABLE TALUNO                                                   --CREATE TABLE table_name
(
COD_ALUNO INTEGER NOT NULL PRIMARY KEY,                               --column_name tipo NULL/NOT NULL PRIMARY KEY/ FOREIGN KEY/ UNIQUE KEY
NOME VARCHAR2(30),
CIDADE VARCHAR2(30),
CEP VARCHAR2(10)
);

--Ou podemos definir os chaves ao fim da criação dos campos de uma tabela
CREATE TABLE TALUNO                                                   --CREATE TABLE table_name
(
COD_ALUNO INTEGER NOT NULL,                                           --column_name tipo NULL/NOT NULL 
NOME VARCHAR2(30),
CIDADE VARCHAR2(30),
CEP VARCHAR2(10),

PRIMARY KEY (COD_ALUNO)                                               --PRIMARY KEY(column_name,...)/ FOREIGN KEY(column_name,...)/ UNIQUE KEY(column_name,...)
);

--Executando consulta para verificar se a tabela foi criada
SELECT * FROM TALUNO
;


--INSERT INTO table_name (column_name, ...) VALUES (value_column, ...)
INSERT INTO TALUNO (COD_ALUNO, NOME, CIDADE, CEP)
VALUES(1, 'ALUNO1', 'CIDADE ALUNO 1','93000000');

INSERT INTO TALUNO (COD_ALUNO, NOME, CIDADE, CEP)
VALUES(2, 'ALUNO2', 'CIDADE ALUNO 2','93000000');

INSERT INTO TALUNO (COD_ALUNO, NOME, CIDADE, CEP)
VALUES(3, 'ALUNO3', 'CIDADE ALUNO 3','93000000');


CREATE TABLE TCURSO
(
COD_CURSO INTEGER NOT NULL PRIMARY KEY,
NOME VARCHAR2(30),
VALOR NUMBER(8,2),
CARGA_HORARIOA INTEGER
);

--
SELECT * FROM TCURSO
;

-- o INSERT INTO pode ser feito sem a descrição das colunas, desde que a ordem da inserção dos valores seja igual a ordem das colunas
INSERT INTO TCURSO VALUES (1,'ORACLE SQL E PL/SQL', 200, 25);
INSERT INTO TCURSO VALUES (2,'CSHARP', 300, 30);
INSERT INTO TCURSO VALUES (3,'FRONT END', 400, 20);
INSERT INTO TCURSO VALUES (4,'DATA BASE ADMINISTRATOR', 500, 50);


--
CREATE TABLE TCONTRATO
(
COD_CONTRADO INTERGER NOT NULL PRIMARY KEY,
DATA DATE,
COD_ALUNO INTEGER,
TOTAL NUMBER(8,2),
DESCONTO NUMBER(5,2)
);

SELECT * FROM TCONTRATO
;

--
INSERT INTO TCONTRATO VALUES (01, SYSDATE, 1, 500 , 10);
INSERT INTO TCONTRATO VALUES (02, SYSDATE, 2, 500 , 10);
INSERT INTO TCONTRATO VALUES (03, SYSDATE, 3, 1500 , 5);
INSERT INTO TCONTRATO VALUES (04, SYSDATE -5, 2, 1600 , 10);
INSERT INTO TCONTRATO VALUES (05, SYSDATE -4, 5, 800 , 10);
INSERT INTO TCONTRATO VALUES (06, SYSDATE -3, 5, 400 , 0);
INSERT INTO TCONTRATO VALUES (07, SYSDATE -2, 5, 445 , 20);


--Alteração da table, para adiocionar uma nova coluna
--ALTER TABLE table_name ADD column_name type_column;
ALTER TABLE TCONTRATO ADD COL_TESTE VARCHAR2(50);

--
SELECT * FROM TCONTRATO;

--Alteração da tabela, para dropar uma coluna
--ALTER TABLE table_name DROP column_name;
ALTER TABLE TCONTRATO DROP COLUMN COL_TESTE;


--alteração da tabela, para alterar o nome de uma coluna
--ALTER TABLE table_name RENAME COLUMN column_name TO new_column_name;
ALTER TABLE TALUNO RENAME COLUMN NOME TO NOME2;
ALTER TABLE TALUNO RENAME COLUMN NOME2 TO NOME;


--Comando para dropar uma tabela
DROP TABLE table_name;

--Criando uma sequencia 
--CREATE SEQUENCE sequence_name STAR WITH number;
--Neste caso a sequencia irá iniciar com o valor 4
CREATE SEQUENCE SEQ_ALUNO STAR WITH 4;

--Função para mostrar próximo valor de uma sequencia
--sequence_name.NEXTVAL
INSERT INTO TALUNO(COD_ALUNO, NOME, CIDADE,CEP)
VALUES (SEQ_ALUNO.NEXTVAL, 'VALDO', 'CANOAS', '11000000');

INSERT INTO TALUNO(COD_ALUNO, NOME, CIDADE,CEP)
VALUES (SEQ_ALUNO.NEXTVAL, 'ANDRE', 'IVOTI', '12000000');


--Table DUAL não tem registro algum. É uma tabela do Oracle utilizada para visualização de algums resultados, por exemplo:
--Horário atual do servidor de banco(SYSDATE)
SELECT SYDATE FROM DUAL;

--Função para verificar o valor atual de uma sequencia
--sequence_name.CURVAL
SELECT SEQ_ALUNO.CURVAL FROM DUAL;


--comando COMMIT utilizado para confirmar alguma operação DML
COMMIT;

--comando ROLLBACK utilizado para voltar alguma operação DML(Este processo só pode ser revertido caso não tenha executado COMMIT antes)
ROLLBACK;


--comando DELETE para exclusão de dados de uma tabela
--DELETE FROM table_name WHERE column_name = value;
DELETE FROM ALUNO
 WHERE COD_ALUNO = 5;

 --
 SELECT * FROM TALUNO
  WHERE NOME = 'VALDO';


--
CREATE TABLE TITEM
(
COD_ITEM INTERGER NOT NUL PRIMARY KEY,
COD_CURSO INTEGER,
COD_CONTRADO INTEGER,
VALOR NUMBER(5,2)
);

INSERT INTO TITEM VALUES (1, 1, 1, 500);
INSERT INTO TITEM VALUES (2, 1, 2, 500);
INSERT INTO TITEM VALUES (3, 3, 3, 1500);
INSERT INTO TITEM VALUES (4, 4, 4, 1600);
INSERT INTO TITEM VALUES (5, 1, 5, 500);
INSERT INTO TITEM VALUES (6, 1, 6, 500);
INSERT INTO TITEM VALUES (7, 2 ,6, 500);
INSERT INTO TITEM VALUES (8, 3, 7, 500);


--comando UPDATE para alteração de dados de uma tabela
--UPDATE table_name SET column_name = new_value WHERE column_name = value;
UPDATE TCONTRATO SET DESCONTO = 18
 WHERE COD_CONTRADO = 2;

UPDATE TCONTRATO SET DESCONTO = 20,
                     DATA = SYSDATE,
                     TOTAL = 750
 WHERE COD_CONTRADO = 2;

--Função UPPER utilizada para que os caracteres fiquem com letra maíuscula
UPDATE TALUNO SET CIDADE = 'CANOAS'
 WHERE CIDADE = UPPER('ivoti')
;

UPDATE TCURSO SET VALOR = 499.99
 WHERE COD_CURSO = 1
;


/************************************************************************************
Comandos SQL não fazem distinção entre maísucla e minúscula
Comandos SQL podem, estar em uma ou mais linhas
Palavras chaves(keywords) não podem ser abreviadas ou divididas em mais de umal inha
cláusulas são normalmente colocadas em linhas separadas
Tabulações e identações são utilizadas para melhorar a visualização do comando
************************************************************************************/

--
SELECT COD_ALUNO, NOME, CIDADE
FROM TALUNO;


--Alias
SELECT COD_ALUNO AS "Código", NOME AS "Nome do Aluno"
FROM TALUNO;

SELECT COD_ALUNO "Código", NOME "Nome do Aluno"
FROM TALUNO;

SELECT COD_ALUNO AS CODIGO, NOME AS NOME_ALUNO
FROM TALUNO;

--Distinct retira linhas duplicadas
SELECT CIDADE FROM TALUNO;


SELECT DISTINCT CIDADE FROM TALUNO;


--Nao agrupa pois cod_aluno diferente
--para cada linha
SELECT DISTINCT CIDADE, COD_ALUNO
FROM TALUNO
ORDER BY CIDADE;


--Apelido de coluna só funciona em ORDER BY
SELECT NOME AS CURSO,
       VALOR,
       VALOR/CARGA_HORARIA,
       Round(VALOR/CARGA_HORARIA,2) AS VALOR_HORA
FROM TCURSO
ORDER BY VALOR_HORA;



/*Nulo é um valor que é indisponível, não atribuído, desconhecido ou invaplicável
um nulo não é o mesmo que zero ou um espaço em branco
um nulo em um cálculo anulo todo o cálculo*/
--calculo com coluna = NULL
--resultado = NULL
SELECT COD_CONTRATO,
       TOTAL,
       DESCONTO,
       TOTAL+DESCONTO
FROM TCONTRATO;


--NVL função para trocar valores nulos
SELECT COD_CONTRATO,
       DESCONTO,
       Nvl(DESCONTO,0),
       TOTAL,
       TOTAL + Nvl(DESCONTO,0) AS TOTAL_MAIS_DESCONTO
FROM TCONTRATO;


-- CONCATENAÇÃO (PIPE)
SELECT COD_ALUNO || ' - ' || NOME || ' // ' || CIDADE AS ALUNO
FROM TALUNO
ORDER BY COD_ALUNO;



--INTEGER é um apelido para number(38) -38 dígitos
--INTEGER       - 1, 2 -- numero inteiro -> number(38)

--   NUMBER(5,2)  - 999,99 --os decimais ele pega da parte do número inteiro
--   NUMBER(4,2)  - 99,99  --os decimais ele pega da parte do número inteiro
--   NUMERIC(5,2) - 999,99 --os decimais ele pega da parte do número inteiro

--Date sempre traz a hora junto
--   DATE         - '10/03/2011 00:00:00'

--Não tem diferença entre VARCHAR ou VARCHAR2
--   VARCHAR(10)  -- Sinonimo para o VARCHAR2
--   VARCHAR2(10) - 'MARCIO' -- Irá ocupar somente os caracteres

--   CHAR(10)     - 'MARCIO    ' --Irá ocupar os caracteres com espaços







