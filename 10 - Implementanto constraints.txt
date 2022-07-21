-- Oque são Constraints(restrição)
-- Garantem regras a nível de tabela;
-- Deve ser satisfeita para a operação para ter sucesso;
-- Previnem a exclusão de uma tabela se existem dependências;

--            TIPOS DE CONSTRAINSTS
-- NOT NULL -> Especifica que a coluna não pode conter valores nuloes;
-- UNIQUE KEY -> Especifica uma coluna ou combinação  de colunas cujos valores devem ser únicos para todas as linhas da tabela;(Chave única)
-- PRIMARY KEY -> Identifica de forma única cada linha;(Chave primária - Interliga entre tabelas; Relaciona primary key de uma tabela com outra primary key de outra tabela)
-- FOREIGN KEY -> Estabelece e garante um relacionamento de chave estrangeira entre a coluna e uma coluna da tabela referenciada;(Chave estrangeira - Interliga entre tabelas; Interliga com primary key de outra tabela)
-- CHECK -> Especifica uma condição que deve ser verdadeira a nível de coluna;
-- Forneça um nome para a constraint ou o Servidor Oracle gerará um nome utilizado o formato SYS_Cn

-- CREATE TABLE [schema.]table
--              (column datatype [DEFAULT expr]
--              [column_constraint],
--              ...
--              [table_constraint]);

-- CREATE TABLE tclientes(
--        id    NUMBER(6),
--        nome  VARCHAR2(35),
--        ...
--        comentarios NUMBER(1000) NOT NULL,
--        CONSTRAINT tclientes_id_pk PRIMARY KEY(id));
-- Normalmente constraints são criadas na criação de uma tabela, mas podem ser criadas após a criação da tabela;
-- Podem ser temporariamente desabilitadas;


TALUNO
  COD_ALUNO - PK -> Chave Primaria -> PRIMARY KEY

TCONTRATO
  COD_CONTRATO - PK -> Chave Primaria -> PRIMARY KEY
  COD_ALUNO - FK -> FOREIGN KEY -> Chave primaria que vem de outra tabela

--Constraints do usuário
SELECT * FROM USER_CONSTRAINTS
  WHERE TABLE_NAME = 'TPESSOA';

--Todas as constraints do banco 
SELECT * FROM ALL_CONSTRAINTS;


-- Ao criar uma constraint ao lado da coluna desejada, o Oracle irá criar com o nome padrão
-- SYS_Cn. Caso, queira dar um nome para a constraint, deve-se declarar ao final do comando,
-- conforme exemplo abaixo


CREATE TABLE tcidade (
  cod_cidade INTEGER NOT NULL,
  nome VARCHAR2(40),
  CONSTRAINT pk_cidade PRIMARY KEY(cod_cidade)
);

-- Constraint para duas colunas
CREATE TABLE tbairro (
  cod_cidade INTEGER NOT NULL,
  cod_bairro INTEGER NOT NULL,
  nome       VARCHAR2(40),
  CONSTRAINT pk_bairro PRIMARY KEY(cod_cidade,cod_bairro)
);

      1 - 1
      1 - 2
      2 - 1
      2 - 2

--Adicionando uma chave estrangeira FOREIGN KEY
ALTER TABLE tbairro ADD CONSTRAINT fk_cod_cidade   --Adicionando a constraint e o nome
FOREIGN KEY (COD_CIDADE)   -- tipo de chave, no caso FOREIGN KEY
REFERENCES tcidade(COD_CIDADE); --Referenciando essa chave, a uma PRIMAKY KEY de outra tabela




CREATE TABLE trua(
  cod_rua INTEGER NOT NULL,
  cod_cidade INTEGER ,
  cod_bairro INTEGER ,
  nome VARCHAR(40),
  CONSTRAINT pk_rua PRIMARY KEY(cod_rua)
);


ALTER TABLE TRUA ADD CONSTRAINT fk_cidadebairro
FOREIGN KEY(cod_cidade, cod_bairro)
REFERENCES tbairro(cod_cidade, cod_bairro);



--DROP TABLE tpessoa  (Fornec ou Cliente)
CREATE TABLE tpessoa (
  cod_pessoa INTEGER      NOT NULL,
  tipo       VARCHAR2(1)  NOT NULL,
  nome       VARCHAR2(30) NOT NULL,
  pessoa     VARCHAR2(1)  NOT NULL,
  cod_rua    INTEGER      NOT NULL,
  cpf        VARCHAR2(15) ,
  CONSTRAINT pk_pessoa PRIMARY KEY (cod_pessoa)
);

--UNIQUE KEY -> Restrição de chave única, esta restrição fica apenas dentro da tabela
ALTER TABLE TPESSOA ADD CONSTRAINT UK_CPF UNIQUE (CPF);

--ALTER TABLE TPESSOA DROP CONSTRAINT NOME_CONSTRAINT
ALTER TABLE TPESSOA ADD CONSTRAINT FK_PESSOA_RUA FOREIGN KEY (COD_RUA)
REFERENCES TRUA(COD_RUA);


-----Cidade
INSERT INTO TCIDADE VALUES(1,'NOVO HAMBURGO');
INSERT INTO TCIDADE VALUES(2,'IVOTI');
INSERT INTO TCIDADE VALUES(3,'SAPIRANGA');
INSERT INTO TCIDADE VALUES(4,'TAQUARA');

SELECT * FROM TCIDADE

-----Bairro
INSERT INTO TBAIRRO VALUES(1,1,'CENTRO');
INSERT INTO TBAIRRO VALUES(2,1,'RIO BRANCO');
INSERT INTO TBAIRRO VALUES(3,1,'CENTRO');
INSERT INTO TBAIRRO VALUES(4,1,'FRITZ');
INSERT INTO TBAIRRO VALUES(5,1,'AMARAL');  --Registro não inserido pois não existe uma PK na tabela CIDADE
INSERT INTO TBAIRRO VALUES(6,1,'EMPRESA'); --Registro não inserido pois não existe uma PK na tabela CIDADE




-----Rua
INSERT INTO TRUA VALUES (1,1,1,'MARCILIO DIAS');
INSERT INTO TRUA VALUES (2,2,1,'FRITZ');
INSERT INTO TRUA VALUES (3,3,1,'JACOBINA');
INSERT INTO TRUA VALUES (4,3,1,'JOAO DA SILVA');


--Adicionando a constraint(restrição) Check
ALTER TABLE TPESSOA ADD CONSTRAINT CK_PESSOA_TIPO
CHECK (TIPO IN ('C','F'));


ALTER TABLE TPESSOA ADD CONSTRAINT CK_PESSOA_JF
CHECK (PESSOA IN ('J','F'));


--Excluir constraint
ALTER TABLE TPESSOA DROP CONSTRAINT UK_CPF;

--Unique Key
ALTER TABLE TPESSOA ADD CONSTRAINT UK_CPF UNIQUE(CPF);

DELETE FROM TPESSOA;

INSERT INTO TPESSOA VALUES(1,'C','MARCIO','F',1,'1234');
INSERT INTO TPESSOA VALUES(2,'F','BEATRIZ','F',2,'123');
INSERT INTO TPESSOA VALUES(3,'F','PEDRO','F',4,'1238');
INSERT INTO TPESSOA VALUES(4,'C','MARIA','J',3,'1239');

SELECT * FROM TPESSOA


--ALTER TABLE TPESSOA DROP CONSTRAINT NOME_DA_CONSTRAINT -> Comando para apagar uma constraint;
--ALTER TABLE TPESSOA DROP CASCADE CONSTRAINT; -> Este comando é necessário a apagar constraints que estão relacionadas;

--Criando uma constraint(restrição) Check
ALTER TABLE TCONTRATO
ADD CONSTRAINT CK_CONTRATO_DESCONTO
CHECK (DESCONTO BETWEEN 0 AND 30);

SELECT * FROM TCONTRATO

--Desabilitando/Habilitando constraint
--ALTER TABLE [TABLE_NAME] DISABLE/ ENABLE CONSTRAINT [NOME_CONSTRAINT]
ALTER TABLE TPESSOA DISABLE CONSTRAINT uk_cpf;
ALTER TABLE TPESSOA ENABLE CONSTRAINT uk_cpf;

--Excluir Constraint
ALTER TABLE TPESSOA DROP CONSTRAINT uk_cpf;

SELECT * FROM user_constraints
WHERE table_name = 'TPESSOA';

--Constraint e as colunas associadas
SELECT constraint_name, column_name
FROM user_cons_columns
WHERE table_name = 'TPESSOA';

--
SELECT OBJECT_NAME, OBJECT_TYPE
FROM USER_OBJECTS
WHERE OBJECT_NAME IN ('TPESSOA')


SELECT * FROM TPESSOA


COMMIT;



/*
Type of constraint definition:
C (check constraint on a table)

P (primary key)

U (unique key)

R (referential integrity)

V (with check option, on a view)

O (with read only, on a view)
*/
