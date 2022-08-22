----------------------Comandos DML Avan�ado----------------------

----------------------MULTI TABLE INSERT----------------------
--Permite que a express�o INSERT INTO ... SELECT possa carregar dados em m�ltiplas tabelas
--Os tipos de multi tabe inserts s�o os seguintes:
--  INSERT Incondicional
--  ALL INSERT Condicional
--  FIRST INSERT Condicional

----------------------INSERT Incondicional----------------------
--Insere todas as linhas em todas as tabelas sem nenhum condi��o especial
--Todasa s inser��es executar�o simultaneamente

----------------------ALL INSERT Condicional----------------------
--Verifica cada cl�usula WHEN para verificar em qual tabela a linha vai ser inserida
--Todas as cl�usulas WHEN s�o verificadas
--Algumas linhas podem ser inseridas em mais de um destino enquanto outras podem at� n�o ser inseridas
--A cl�usula ELSE pode ser utilizada
--Podem ser utilizadas v�rias cl�usulas INTO com uma condi��o WHEN

----------------------FIRST INSERT Condicional----------------------
--Verifica cada cl�usula WHEN na ordem em que aparece na express�o
--Executa somente a primeira cl�usula INTO que � verdadeira
--A cl�usula ELSE pode ser utilizada

----------------------Comando MERGE----------------------
--O comando tem a fun��o de obter linhas de uma determinada tabela para atualizar ou incluir linhas em outra tabela
--  INTO: Determina a tabela destino onde faremos a inclus�o ou atualiza��o
--  USING: Determina o dado(origem) que ser� inclu�do ou atualizado
--  WHEN MATCHED/ NOT MATCHED: Determina a condi��o a ser avaliada para inclus�o ou atualiza��o. Quando a condi��o for verdadeira
--    ocorrer� a atualiza��o, caso contr�rio ser� realizada a inclus�o


--Realiza o insert em v�rias tabelas, deve ser a mesma quantidade de colunas e do mesmo tipo

INSERT ALL
  INTO tcurso (cod_curso,nome, valor)
  INTO taluno (cod_aluno,nome, salario)
      SELECT cod_contrato+50,'INSERT ALL', 1013
      FROM TCONTRATO
      WHERE COD_CONTRATO=1;


SELECT * FROM TCURSO;
SELECT * FROM TALUNO;

-----**************


--
CREATE SEQUENCE seq_curso START WITH 100;

--INSERT ALL Condicional
INSERT ALL
   WHEN TOTAL>=1000  THEN
        INTO TCURSO (COD_CURSO, NOME, VALOR)
        VALUES (seq_curso.NEXTVAL, 'CURSO>1000', TOTAL)
   WHEN DESCONTO IS NULL THEN
        INTO TCURSO (COD_CURSO, NOME, VALOR)
        VALUES (seq_curso.NEXTVAL, 'DESCONTO IS NULL', TOTAL)
   SELECT COD_CONTRATO, TOTAL, DESCONTO
   FROM TCONTRATO WHERE COD_CONTRATO = 1;


SELECT * FROM TCURSO;


--Exemplo de MERGE
--Comando MERGE serve para fazer atualiza��o de uma tabela, buscando os registros de v�rias tabelas
--A primeiro momento, se n�o existe registro na tabela alvo, o MERGE faz o insert, caso j� tenha registro, o comando faz a atualiza��o dos dados
CREATE SEQUENCE seq_con START WITH 500; --Cria��o de sequencia

MERGE INTO TCONTRATO 
--Regra definida de acordo com o select abaixo
    USING (SELECT COD_ALUNO AS ALUNO
           FROM   TALUNO
           WHERE  estado = 'RS') --SELECT utilizado como regra
    ON    (TCONTRATO.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --Comando WHEN MATCHED identifica que, se o registro na tabela foi encontrado, ent�o ser� realizado um updade no campo desconto na tabela TCONTRADO
            UPDATE SET desconto = 22
       WHEN NOT MATCHED THEN --Caso n�o encontre o registro na tabela TCONTRADO, ser� realizado a inser��o dos dados
            INSERT(TCONTRATO.COD_CONTRATO, TCONTRATO.DATA, TCONTRATO.COD_ALUNO,
                   TCONTRATO.desconto, TCONTRATO.total)
           VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);

--SELECT * FROM TCONTRATO
--SELECT * FROM TALUNO