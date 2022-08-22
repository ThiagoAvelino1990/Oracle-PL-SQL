--Criando views

--Tabela l�gica baseada em uma tabela ou em outra vis�o
--As tabelas nas quais uma vis�o � baseada s�o chamadas de tabelas b�sicas
--A vis�o � armazenada como um comando SELECT no dicion�rio de dados
--Uma vis�o � um SELECT armazenado

--View Simples:  Uma Tabela;          N�o cont�m fun��o; N�o possui grupo de dados; � poss�vel fazer DML 
--View Complexa: Uma ou mais tabelas; Cont�m fun��es;    Possui grupo de dados;     Talvez seja poss�vel fazer DML 

--Comando para criar uma VIEW
--CREATE OR REPLACE VIEW [NOME_DA_VIEW]
--AS
--  SELECT [COLUNA_REQ], [COLUNA_REQ], [COLUNA_REQ],
--         [COLUNA_REQ], [COLUNA_REQ]
--    FROM [TABLE_NAME]
--   WHERE [CONDI��O];



CREATE OR REPLACE VIEW V_ALUNO
AS
  SELECT COD_ALUNO AS CODIGO, SALARIO, ESTADO,
         NOME AS ALUNO, CIDADE
  FROM TALUNO
  WHERE ESTADO='RS';


--Usando a view
SELECT * FROM V_ALUNO
ORDER BY ALUNO;



--
CREATE OR REPLACE VIEW V_CONTRATO_TOP
AS
  SELECT COD_CONTRATO, DESCONTO
  FROM   TCONTRATO
  WHERE  DESCONTO >= 10;

SELECT * FROM V_CONTRATO_TOP;




--Ver views existentes do usu�rio logado no banco. 
--USER_VIEWS � uma view do Oracle
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;




--View com parametros de saida
CREATE OR REPLACE VIEW V_ALUNO2(COD, ALUNO, SAL)--Par�metros de Sa�da
AS
  SELECT COD_ALUNO, NOME, SALARIO
  FROM TALUNO;

SELECT * FROM V_ALUNO2;





--Exemplo de VIEW Complexa
-- Esta view � considerada complexa devido as fun��es de agrupamento que existem no selecr para a sua cria��o
CREATE OR REPLACE VIEW V_CONTRATO
AS
  SELECT Trunc(DATA) AS DATA,
         Max(DESCONTO) MAXIMO,
         Avg(DESCONTO) MEDIA,
         Count(*) QTDE
  FROM TCONTRATO
  GROUP BY Trunc(DATA);

--
SELECT * FROM V_CONTRATO;





--View Simples
CREATE OR REPLACE VIEW V_PESSOA_F
AS
  SELECT COD_PESSOA, TIPO, NOME, COD_RUA AS RUA
  FROM TPESSOA
  WHERE TIPO='F';

--
select * from V_PESSOA_F;
---

--Exemplo de consulta usando view e tabela
SELECT PES.COD_PESSOA AS CODIGO,
       PES.NOME AS PESSOA,
       CID.NOME AS CIDADE,
       RUA.NOME AS RUA
FROM V_PESSOA_F PES, TRUA RUA, TCIDADE CID
WHERE PES.RUA = RUA.COD_RUA (+)
AND CID.COD_CIDADE = RUA.COD_CIDADE
ORDER BY PES.NOME;


/////////////////////////////////////


-- OPERACAO DML(Data Manipulation Language) NA VIEW
-- Exemplo de inclus�o de dados na tabela a partir da view com regras
CREATE OR REPLACE VIEW vcursos1000ck
  AS
   SELECT cod_curso, nome, valor
   FROM   TCurso
   WHERE  VALOR = 1000
   WITH CHECK OPTION CONSTRAINT vcursos1000_ck; -- Utilizando a constraint CHECK para que a inser��o de dados na tabela TCURSO atrav�s da view VCURSOS1000CK,
   --seja respeitada de acordo com a condi��o informada, no valor a coluna VALOR = 1000

-- Exemplo do erro ao tentar inserir um valor que n�o condiz com a cla�sula informada no momento da cria��o da view
--  ORA-01402: view WITH CHECK OPTION where-clause violation
INSERT INTO vCursos1000ck
         (cod_curso, nome, valor)
VALUES   (52,'TESTE Y', 999);

--Valor respeitado
INSERT INTO vCursos1000ck
         (cod_curso, nome, valor)
VALUES   (52,'TESTE Y', 1000);


SELECT * FROM tCurso;


--delete em view
SELECT * FROM V_ALUNO;
--
DELETE FROM V_ALUNO WHERE CODIGO = 3

--insert em view
INSERT INTO V_ALUNO
VALUES (50, 500, 'RS','MARIA', 'NH');

COMMIT;

SELECT * FROM TALUNO


--delete em view
--(nao pode fazer DML em view complexa)
DELETE FROM V_CONTRATO;


--View somente leitura (Nao permite DML)
CREATE OR REPLACE VIEW V_ALUNO3
AS
  SELECT COD_ALUNO CODIGO,
         NOME ALUNO, CIDADE
  FROM TALUNO
  WHERE ESTADO='RS'
  WITH READ ONLY;-- Regra para uma view somente de leitura

--Nao pode executar delete em view
--somente leitura.
DELETE FROM V_ALUNO3;


--Excluindo visao
DROP VIEW V_ALUNO3;
