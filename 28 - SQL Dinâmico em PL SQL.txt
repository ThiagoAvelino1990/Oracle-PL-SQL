----------------------------SQL Dinâmico em PL/SQL ----------------------------
--Um SQL Dinâmico é um comando SQL ou um bloco PL/SQL válido, codificado dentro de uma string(populada em tempo de execução)
--Disponível a partir da versão 81 do banco de dados ORACLE
--Temos aplicações que necessitam processar comandos SQL que só se completam a tempo de execução
--Possibilidade de execução de comandos DDL ou DCL dentro de blocos PL/SQL

----------------------------Usando SQL Dinâmico----------------------------
--Comandos de SQL dinâmico são armazenados em strings construídas pelo programa em tempo de execução
--Estar strings devem conter um comando SQL ou um bloco de PL/SQL válidos
--Para processarmos comandos de SQL, tais como INSERT,UPDATE, DELETE ou bloco PL/SQL usaremos o comando:
--  EXECUTE IMMEDIATE
--Para processarmos SQL SELECT, usaremos os comandos:
--  OPEN-FOR
--  FETCH
--  CLOSE

----------------------------Porque utilizar SQL Dinâmico?----------------------------
--Executar comandos SQL de definição de dados(como o CREATE), comandos de controle de dados(como o GRANT), ou comandos de controle de sessão(como o ALTER SESSION)
--  Por exemplo, você deseja passar o nome de um usuário(schema) como um parâmetro para um procedimento, você poderá utilizar diferentes condições na cláusula 
--  WHERE do seu comando SELECT.

----------------------------O Comando EXECUTE IMMEDIATE----------------------------
--  EXECUTE IMMEDIATE 'SQL string'
--  [INTO {variáveis[,variável]...|record}]
--  [USING [IN| OUT | IN OUT] bind_argument];
--SQL String é uma string que contém aquilo que se deseja executar
--Cláusula INTO, a especificação de variáveis é opcional e indica uma ou mais variáveis para as quais valores selecionados serão atribuídos
--Cláusula USING, a seção bind_argument(parâmetros) é opcional e designa um valor repassado para bind variables na SQL string

----------------------------Algumas Considerações----------------------------
--EXECUTE IMMEDIATE não realizará automaticamente o COMMIT de uma transação DML anterior
--Consultas que retornem mais de uma linha não são suportadas como valor de retorno
--Para executar comandos DDL através de SQL dinâmico, o usuário deve ter recebido os privilégios de sistema de forma explícita, não pode ser através de roles

CREATE TABLE GRANDES_CONTRATOS
( COD INTEGER,
  DATA DATE,
  TOTAL NUMERIC(12,2)
);
--
CREATE OR REPLACE PROCEDURE insere_grandes_contratos
(pTotal IN tcontrato.total%TYPE)
IS
BEGIN
  EXECUTE IMMEDIATE ' INSERT INTO grandes_contratos    ' ||
                    ' SELECT cod_contrato, data, total ' ||
                    ' FROM tcontrato                   ' ||
                    ' WHERE total >  :1   '
                    USING pTotal;
 COMMIT;
END;
--
EXEC insere_grandes_contratos(1000);
SELECT * FROM GRANDES_CONTRATOS;


SELECT * FROM grandes_contratos;
DELETE FROM grandes_contratos;




CREATE TABLE grandes_contratos
  AS SELECT cod_contrato, data, total
  FROM tcontrato


CREATE OR REPLACE PROCEDURE consulta_generica
(pColunas   IN VARCHAR2,
 pTabelas   IN VARCHAR2,
 pCondicoes IN VARCHAR2     )
IS
  TYPE refCursor IS REF CURSOR;
  cCursor1       refCursor;
  vRetorno VARCHAR2(4000);
  vRet VARCHAR2(4000);
BEGIN
  OPEN cCursor1 FOR ' SELECT '||pColunas||
                    ' FROM '||pTabelas||
                    ' WHERE '||pCondicoes;
  LOOP
    FETCH cCursor1 INTO vRetorno, vret;
    EXIT WHEN cCursor1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(vRetorno||' - '||vret);
  END LOOP;
  CLOSE cCursor1;
END;
--
EXEC Consulta_Generica ('NOME,CIDADE','TALUNO','1=1');
