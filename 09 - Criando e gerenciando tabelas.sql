-- Devem come�ar com uma letra;
-- Podem possuir de 1 at� 30 caracteres de tamanho;
-- Devem conter somente letras de A - Z(Padr�o - Recomend�vel); a - z(N�o � aconselh�vel min�sculo); 0 - 9; _; $; #
-- N�o possuir o mesmo nome de um objeto criado pelo mesmo usu�rio de banco(Trigger; Procedures; Jobs; etc)
-- Palavra reservada do banco ORACLE

--CREATE TABLE [SCHEMA].TABLE (COLUMN datatype [DEFAULT expr]);

-- Visualizar Tabelas criadas pelo usu�rio -> SELECT * FROM USER_TABLES;
-- Visualizar os tipos de objetos distintos criados pelo usu�rio -> SELECT * FROM USER_OBJECTS;
-- Visualizar as tabelas , vis�es, sin�nimos e sequences criadas pelo usu�rio -> SELECT * FROM USER_CATALOG;

CREATE TABLE TESTE
(
  CODIGO INTEGER NOT NULL PRIMARY KEY,
  DATA DATE DEFAULT SYSDATE
);


INSERT INTO TESTE (CODIGO) VALUES (1);

INSERT INTO TESTE (CODIGO,DATA) VALUES (2,'03/08/2013');

SELECT * FROM TESTE;


--Tipos de Dados

-- VARCHAR2(size) -> Dados caractere de tamanho vari�vel, um tamanho(size) deve ser especficiado. Tamanho default m�nimo � 1 enquanto o m�ximo � 4000;
-- CHAR(size) -> Dados caracter de tamanho fixo de tamanho(size) bytes. Tamanho default m�nimo � 1 enquanto o m�ximo � 2000. 
--Lembrando que ao definir o tamanho, se o valor n�o comportar o tamanho do CHAR, o restante ser� preenchido com espa�o;
-- NUMBER(precis�o,escala) -> N�mero possuindo numa presi�o(p) e escala(s), a precis�o � o n�mero total de d�gitos decimais, e a escala � o n�mero de d�gitos a direita do,
--ponto decimal(a precis�o deve estar na faixa de 1 a 38) 
-- BINARY_FLOAT -> N�meros de precis�o simples com 32 bits e ponto flutuante;
-- BINARY_DOUBLE -> N�meros de precis�o duplas com 64 bits e ponto flutuante;
-- DATE -> Valores de data e hora entre 1 de Janeiro de 4712 A.C e 31 de dezembro de 999 D.C.
-- LONG -> Dados de caracteres de tamanho vari�vel at� 2 GIGABYTES;
-- CLOB -> Dados de caracter single-bytede at� 4 gigabytes* tamanho do bloco de dados;
-- RAW(size) -> Dados bin�rios de tamanho espeficiado por (size). Tamanho m�ximo � 2000(um tamanho m�ximo deve ser espec�ficado);
-- LONG RAW -> Dados bin�rios de tamanho vari�vel de at� 2 gigabytes;
-- BLOB -> Dados bin�rios de at� 4 gigabytes* tamanho do bloco de dados;
-- BFILE -> Ponteiro para um arquivo externo;
 
VARCHAR2(10) -> 'MARCIO'
CHAR(10);    -> 'MARCIO    '

NUMBER(5,2)  -> 999.99


--tabelas criadas pelo usuario - USER_TABLES (View)
SELECT * FROM USER_TABLES;

SELECT * FROM ALL_TABLES;


CREATE TABLE TCONTRATO_VIP
AS
 SELECT * FROM TCONTRATO WHERE TOTAL > 500;


SELECT * FROM TCONTRATO_VIP;

--add coluna na TABELA
ALTER TABLE TCONTRATO_VIP ADD VALOR NUMBER(5,2); -- 999,99

--alterar coluna
ALTER TABLE TCONTRATO_VIP MODIFY VALOR NUMBER(8,2); -- 999999,99

--alterar coluna
ALTER TABLE TCONTRATO_VIP MODIFY VALOR NUMBER(12,2) DEFAULT 0; -- 9999999999,99

--renomear coluna
ALTER TABLE TCONTRATO_VIP RENAME COLUMN VALOR TO VALOR2;

--excluir coluna
ALTER TABLE TCONTRATO_VIP DROP COLUMN VALOR2;

--excluir tabela
DROP TABLE TCONTRATO_VIP;


--Renomear tabela
RENAME TCONTRATO TO TCONTRATO_TOP;

SELECT * FROM TCONTRATO_TOP;

RENAME TCONTRATO_TOP TO TCONTRATO;

SELECT * FROM TCONTRATO;




-- Colocando coment�rio em tabelas e coment�rio em colunas
COMMENT ON TABLE TCONTRATO IS 'Informa��es de Contratos';

--comentario na coluna da tabela
COMMENT ON COLUMN TCONTRATO.COD_CONTRATO IS 'C�digo do Contrato';

COMMENT ON COLUMN TCONTRATO.DATA IS 'Data de emiss�o do Contrato';

COMMENT ON COLUMN TCONTRATO.COD_ALUNO IS 'C�digo do Aluno';

COMMENT ON COLUMN TCONTRATO.TOTAL IS 'Total do Contrato';

-- Visualizar coment�rio das colunas
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME='TCONTRATO'

-- Visualizar coment�rio das tabelas
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME='TCONTRATO'




--Desabilita a coluna
ALTER TABLE TCONTRATO ADD TOTAL2 NUMERIC(8,2);

-- Comando UNUSED desabilita uma coluna da tabela. N�o � poss�vel habilitar a coluna novamente;
ALTER TABLE TCONTRATO SET UNUSED (TOTAL2)

SELECT * FROM TCONTRATO

--Excluir colunas nao usadas
ALTER TABLE TCONTRATO DROP UNUSED COLUMNS;



--TRUNCATE TABLE EXCLUI TODOS REGISTROS DA TABELA
--NAO TEM WHERE E NAO TEM COMMIT/ROLLBACK
TRUNCATE TABLE TABELA;

