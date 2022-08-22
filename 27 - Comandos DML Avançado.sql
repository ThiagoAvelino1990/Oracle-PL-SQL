----------------------Comandos DML Avançado----------------------

----------------------MULTI TABLE INSERT----------------------
--Permite que a expressão INSERT INTO ... SELECT possa carregar dados em múltiplas tabelas
--Os tipos de multi tabe inserts são os seguintes:
--  INSERT Incondicional
--  ALL INSERT Condicional
--  FIRST INSERT Condicional

----------------------INSERT Incondicional----------------------
--Insere todas as linhas em todas as tabelas sem nenhum condição especial
--Todasa s inserções executarão simultaneamente

----------------------ALL INSERT Condicional----------------------
--Verifica cada cláusula WHEN para verificar em qual tabela a linha vai ser inserida
--Todas as cláusulas WHEN são verificadas
--Algumas linhas podem ser inseridas em mais de um destino enquanto outras podem até não ser inseridas
--A cláusula ELSE pode ser utilizada
--Podem ser utilizadas várias cláusulas INTO com uma condição WHEN

----------------------FIRST INSERT Condicional----------------------
--Verifica cada cláusula WHEN na ordem em que aparece na expressão
--Executa somente a primeira cláusula INTO que é verdadeira
--A cláusula ELSE pode ser utilizada

----------------------Comando MERGE----------------------
--O comando tem a função de obter linhas de uma determinada tabela para atualizar ou incluir linhas em outra tabela
--  INTO: Determina a tabela destino onde faremos a inclusão ou atualização
--  USING: Determina o dado(origem) que será incluído ou atualizado
--  WHEN MATCHED/ NOT MATCHED: Determina a condição a ser avaliada para inclusão ou atualização. Quando a condição for verdadeira
--    ocorrerá a atualização, caso contrário será realizada a inclusão


--Realiza o insert em várias tabelas, deve ser a mesma quantidade de colunas e do mesmo tipo

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
--Comando MERGE serve para fazer atualização de uma tabela, buscando os registros de várias tabelas
--A primeiro momento, se não existe registro na tabela alvo, o MERGE faz o insert, caso já tenha registro, o comando faz a atualização dos dados
CREATE SEQUENCE seq_con START WITH 500; --Criação de sequencia

MERGE INTO TCONTRATO 
--Regra definida de acordo com o select abaixo
    USING (SELECT COD_ALUNO AS ALUNO
           FROM   TALUNO
           WHERE  estado = 'RS') --SELECT utilizado como regra
    ON    (TCONTRATO.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --Comando WHEN MATCHED identifica que, se o registro na tabela foi encontrado, então será realizado um updade no campo desconto na tabela TCONTRADO
            UPDATE SET desconto = 22
       WHEN NOT MATCHED THEN --Caso não encontre o registro na tabela TCONTRADO, será realizado a inserção dos dados
            INSERT(TCONTRATO.COD_CONTRATO, TCONTRATO.DATA, TCONTRATO.COD_ALUNO,
                   TCONTRATO.desconto, TCONTRATO.total)
           VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);

--SELECT * FROM TCONTRATO
--SELECT * FROM TALUNO