-- Devem começar com uma letra;
-- Podem possuir de 1 até 30 caracteres de tamanho;
-- Devem conter somente letras de A - Z(Padrão - Recomendável); a - z(Não é aconselhável minúsculo); 0 - 9; _; $; #
-- Não possuir o mesmo nome de um objeto criado pelo mesmo usuário de banco(Trigger; Procedures; Jobs; etc)
-- Palavra reservada do banco ORACLE

--CREATE TABLE [SCHEMA].TABLE (COLUMN datatype [DEFAULT expr]);

-- Visualizar Tabelas criadas pelo usuário -> SELECT * FROM USER_TABLES;
-- Visualizar os tipos de objetos distintos criados pelo usuário -> SELECT * FROM USER_OBJECTS;
-- Visualizar as tabelas , visões, sinônimos e sequences criadas pelo usuário -> SELECT * FROM USER_CATALOG;

CREATE TABLE TESTE
(
  CODIGO INTEGER NOT NULL PRIMARY KEY,
  DATA DATE DEFAULT SYSDATE
);


INSERT INTO TESTE (CODIGO) VALUES (1);

INSERT INTO TESTE (CODIGO,DATA) VALUES (2,'03/08/2013');

SELECT * FROM TESTE;


--Tipos de Dados

-- VARCHAR2(size) -> Dados caractere de tamanho variável, um tamanho(size) deve ser especficiado. Tamanho default mínimo é 1 enquanto o máximo é 4000;
-- CHAR(size) -> Dados caracter de tamanho fixo de tamanho(size) bytes. Tamanho default mínimo é 1 enquanto o máximo é 2000. 
--Lembrando que ao definir o tamanho, se o valor não comportar o tamanho do CHAR, o restante será preenchido com espaço;
-- NUMBER(precisão,escala) -> Número possuindo numa presião(p) e escala(s), a precisão é o número total de dígitos decimais, e a escala é o número de dígitos a direita do,
--ponto decimal(a precisão deve estar na faixa de 1 a 38) 
-- BINARY_FLOAT -> Números de precisão simples com 32 bits e ponto flutuante;
-- BINARY_DOUBLE -> Números de precisão duplas com 64 bits e ponto flutuante;
-- DATE -> Valores de data e hora entre 1 de Janeiro de 4712 A.C e 31 de dezembro de 999 D.C.
-- LONG -> Dados de caracteres de tamanho variável até 2 GIGABYTES;
-- CLOB -> Dados de caracter single-bytede até 4 gigabytes* tamanho do bloco de dados;
-- RAW(size) -> Dados binários de tamanho espeficiado por (size). Tamanho máximo é 2000(um tamanho máximo deve ser específicado);
-- LONG RAW -> Dados binários de tamanho variável de até 2 gigabytes;
-- BLOB -> Dados binários de até 4 gigabytes* tamanho do bloco de dados;
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




-- Colocando comentário em tabelas e comentário em colunas
COMMENT ON TABLE TCONTRATO IS 'Informações de Contratos';

--comentario na coluna da tabela
COMMENT ON COLUMN TCONTRATO.COD_CONTRATO IS 'Código do Contrato';

COMMENT ON COLUMN TCONTRATO.DATA IS 'Data de emissão do Contrato';

COMMENT ON COLUMN TCONTRATO.COD_ALUNO IS 'Código do Aluno';

COMMENT ON COLUMN TCONTRATO.TOTAL IS 'Total do Contrato';

-- Visualizar comentário das colunas
SELECT * FROM USER_COL_COMMENTS WHERE TABLE_NAME='TCONTRATO'

-- Visualizar comentário das tabelas
SELECT * FROM USER_TAB_COMMENTS WHERE TABLE_NAME='TCONTRATO'




--Desabilita a coluna
ALTER TABLE TCONTRATO ADD TOTAL2 NUMERIC(8,2);

-- Comando UNUSED desabilita uma coluna da tabela. Não é possível habilitar a coluna novamente;
ALTER TABLE TCONTRATO SET UNUSED (TOTAL2)

SELECT * FROM TCONTRATO

--Excluir colunas nao usadas
ALTER TABLE TCONTRATO DROP UNUSED COLUMNS;



--TRUNCATE TABLE EXCLUI TODOS REGISTROS DA TABELA
--NAO TEM WHERE E NAO TEM COMMIT/ROLLBACK
TRUNCATE TABLE TABELA;

