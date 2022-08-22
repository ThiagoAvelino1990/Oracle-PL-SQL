--Data Manipulation LANGUAGE -> DML (INSERT, UPDATE, DELETE) - Transação (COMMIT; ROLLBACK)
--INSERT - Insere novas linhas de tabela;
  --INSERT INTO TABLE ([COLUMN], [COLUMN], [...]) VALUES ([VALUE], [VALUE], [...])

--DELETE - Remove linhas de uma tabela;
  --DELETE

--UPDATE - Altera linhas de uma tabela;

CREATE TABLE TDESCONTO
( CLASSE VARCHAR(2),
  INFERIOR INTEGER,
  SUPERIOR INTEGER );


A 00 10
B 11 20
C 21 30

SELECT * FROM TDESCONTO;

--VARIÁVES DE SUBSTIUIÇÃO -> Deve-se ser ativada na ferramenta
--INFORMAR UM &( E COMERCIAL) E UM NOME PARA A VARIÁVEL. pODE SER UTILIZADA TANTO EM INSERT, UPDATE, DELETE, SELECT;
INSERT INTO TDESCONTO(CLASSE, INFERIOR, SUPERIOR)
VALUES ('&cla', &inf, &sup);

SELECT * FROM TDESCONTO
WHERE CLASSE = '&cla';

UPDATE TDESCONTO SET
INFERIOR = &inf ,
SUPERIOR = &sup
WHERE CLASSE = '&cla';

DELETE FROM TDESCONTO
WHERE CLASSE = '&cla';

--COMMIT;
----------------------------------------
--Criar uma nova tabela a partir de uma tabela ja existente;
CREATE TABLE TDESCONTO2
  AS SELECT * FROM TDESCONTO

SELECT * FROM TDESCONTO2;

COMMIT;


--Transação (Commit/Rollback)

--DELETE deleta os registros da tabela
DELETE FROM TDESCONTO2 ;

--ROLLBACK retorna a ação realizada, entretando, os valores só serão retornados caso o comando COMMIT não tenha sido executado;
ROLLBACK;

--Delete todos os registros da tabela sem a clausua WHERE. Este comando não tem volta, ou seja, não é possível utilizar o comando ROLLBACK para voltar;
TRUNCATE TABLE TDESCONTO2;


SELECT * FROM TDESCONTO2;


--Deleta todos os registros nao tem volta/
--nao funciona (Commit/Rollback)

ROLLBACK;



COMMIT;

--Comando SAVEPOINT é similar ao (COMMIT e ROLLBACK), ele trabalha para criar um ponto de restauração;
--Criando a partir da última ação no banco de dados;
--Pode-se ser criando inúmeros SAVEPOINTS e retornar utilizando o comando ROLLBACK
-- ROLLBACK TO SAVEPOINT [Nome Savepoint];



SELECT * FROM TDESCONTO        

--Criando ponto de restauração
SAVEPOINT upd_b;

UPDATE TDESCONTO SET
SUPERIOR = 88
WHERE CLASSE = 'B';

--Criando ponto de restauração
SAVEPOINT upd_a;

UPDATE TDESCONTO SET
SUPERIOR = 99
WHERE CLASSE = 'A';

--Criando ponto de restauração
SAVEPOINT ins_Ok;
--
INSERT INTO tdesconto(classe, inferior, superior)
VALUES ('&cla', &inf, &sup);

SELECT * FROM TDESCONTO;

--Retornar o SAVEPOINT com o comando ROLLBACK;
ROLLBACK TO SAVEPOINT ins_Ok;
SELECT * FROM TDESCONTO;

ROLLBACK TO SAVEPOINT upd_a;
SELECT * FROM TDESCONTO;

ROLLBACK TO SAVEPOINT upd_b;
SELECT * FROM TDESCONTO;

--excluir tabela
DROP TABLE TDESCONTO2;