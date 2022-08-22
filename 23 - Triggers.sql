-----------------------------------------TRIGGERS-----------------------------------------

--Triggers(literalmente, gatilhos) não são disparadas explicitamente, como PROCEDURES ou FUNCTIONS, através de chamadas, mas sim quando ocorrer um evento
--  em uma tabela, ou seja, uma ação DML(INSERT, UPDATE, DELETE) - Data Manipulation Language.
--Uma trigger de banco(database trigger) fica sempre associada á uma tabela ou view.
--A trigger faz parte da mesma transação do comando que a disparou, não podemos executar os comandos COMMIT, ROLLBACK, ou SAVEPOINT.

--Algumas utilizadades
--  °Manter um nível mais elevado de integridade dos dados, sendo muito complexo para a utilização de constrains.
--  ºInformações de auditoria de uma tabela, armazenando que modificações foram realizadas e também quem as realizou.
--  ºAutomaticamente sinalizar para outros programas que ações devem ser realizadas quando são realizadas modificações em uma tabela.

-----------------------------------------CRIANDO DML TRIGGERS-----------------------------------------
--Uma DML Trigger é disprada quando um comando INSER, UPDATE ou DELETE é executado sobre uma tabela do banco de dados
--Pode ser disparada antes ou depois da execução do comando e disparada em nível de comando(bloco de registros) ou linha
--A combindação destes fatores determina o tipo da trigger
--Uma tabela pode ter qualquer número de triggers definida para ela, incluindo várias de um determinado tipo de comando DML

-----------------------------------------ELEMENTROS DE UMA DATABASE TRIGGER-----------------------------------------
--ELEMENTO |DESCRIÇÃO
--TEMPO    |Quando a Trigger é disparada em relação ao evento que disparou a Trigger.
--         |Valores Possíveis: BEFORE(antes do evento), AFTER(depois do evento), INSTEAD OF(substitui o evento): apenas sobre views
--EVENTO   |Que comando(s) DML causa(m) i disparo da Trigger.
--         |Valores Possíveis: INSERT, UPDATE[OF COLUNA], DELETE
--TIPO     |Quantas vezes o corpo da trigger será executado.
--         |Valores Possíveis: Statemente(nível de comando - default) FOR EACH ROW(nível de linha)
--CORPO    |Que ação ou ações a trigger executa. Bloco de comandos PL/SQL

-----------------------------------------TRIGGER EM NÍVEL DE LINHA E EM NÍVEL DE COMANDO-----------------------------------------
--TRIGER EM NÍVEL DE COMANDO                        |TRIGGER EM NÍVEL DE LINHA
--Executa o corpo da Trigger                        |Executa o corpo da Trigger uma
--  uma única vez, sempre que um                    | vez para cada linha afetada pelo
--  determinado comando de manipulação de dados for | comando de manipulaçção que
--  emitido para uma determinada                    | causou o dsiparado da trigger.
--  tabela.                                         |Exemplo: Se eu crio um comando que irá
--Exemplo: Se eu crio um comando que irá alterar    | alterar 200 registro, este comando
--  200 registros, o comando é executado            | será executado 200 vezes,ou seja,
--  uma única vez                                   | linha a linha

-----------------------------------------ORDEM DE DISPARO DAS TRIGGERS-----------------------------------------
--Algoritmo para execução dos comandos:
--  °Executar as BEFORE STATEMENT-LEVEL TRIGGERS, se existirem
--  °Para cada linha afetada pelo comando:
--    -Executar as BEFORE ROW-LEVEL TRIGGERS, se existirem.
--    -Executar o comando da TRIGGER.
--    -Executar as AFTER ROW-LEVEL TRIGGERS, se existirem.
--  °executar as AFTER STATEMENTE-LEVEL TRIGGERS, se existirem

-----------------------------------------VALORES OLD E NEW-----------------------------------------
--Nem sempre se aplica a usar os valores OLD e NEW
--OPERACAÇÃO |OLD value             |NEW value
--INSERT     |NULL                  |Valor inserido
--UPDATE     |Valor antes do UPDATE |Valor atualizado
--DELETE     |Valro antes do DELETE |NULL

--Use os qualificadores OLD e NEW em triggers em nível de linhas apenas
--Prefixe os valores com dois ponto(:)


----------------------------------------- TRIIGER INSTEAD OF -----------------------------------------
--Além dos tempos de execuão BEFORE e AFTER, uma trigger pode ser criada para o tempo INSTEAD OF
--Crie uma trigger INSTEAD OF para substituir o processamento padrão de comandos DML sobre uma visão
--O comando DML que dispara a trigger não é executado, apenas as ações definidas no bloco PL/SQL da trigger


--Blocos anônimos
DECLARE
  --HORA VARCHAR2(2);
  H NUMBER;
  M NUMBER;
BEGIN
  H := TO_NUMBER(To_Char(SYSDATE,'HH24'));  --Recebe hora
  M := To_Number(To_Char(SYSDATE, 'MI'));   --Recebe minutos
  Dbms_Output.Put_Line(H||'H '||M||' MIN - '||TO_CHAR(SYSDATE + 4, 'DAY')); --imprimi o valor de H e M
END;

--
BEGIN
  IF(TO_CHAR(SYSDATE, 'DAY') IN ('DOMINGO') OR
    TO_NUMBER(To_Char(SYSDATE,'HH24')) NOT BETWEEN 9 AND 18)THEN --A hora não estiver entre 8 e 18
    Raise_Application_Error( -20001,'Fora do horário comercial');
  END IF;
END;

SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL;
SELECT To_Number(To_Char(SYSDATE,'HH24')) FROM DUAL;

--Criação da Trigger
CREATE OR REPLACE TRIGGER VALIDA_HORARIO_CURSO
BEFORE INSERT OR DELETE ON TContrato --Trigger será executada antes do insert ou do delete
BEGIN
--Se o dia da semana for 1(sábado) e 7(Domingo) ou não estiver entre 8 e 18 horas
  IF(TO_CHAR(SYSDATE, 'D') IN (1, 7) OR To_Number(To_Char(SYSDATE,'HH24'))NOT BETWEEN 8 AND 18) 
    THEN
    Raise_Application_Error(-20001,'Fora horário comercial');
  END IF;
END;
--

--Comando INSERT validando trigger
INSERT INTO TCONTRATO
VALUES (7665, SYSDATE, 10, 1500, NULL);


--
SELECT * FROM TCONTRATO;


--Criando tabela LOG
CREATE TABLE TLOG
( USUARIO VARCHAR2(30),
  DATA DATE,
  VALOR_ANTIGO VARCHAR2(10),
  VALOR_NOVO VARCHAR2(10)
);

--Criando Trigger
CREATE OR REPLACE TRIGGER gera_log_alt
AFTER UPDATE OF TOTAL ON TContrato   --Após update na tabela contrato na coluna total
DECLARE
--variáveis
BEGIN
  INSERT INTO TLOG(Usuario, DATA) VALUES (USER, SYSDATE);
END;


--
SELECT * FROM TCONTRATO;
UPDATE TCONTRATO SET TOTAL = 5000 WHERE COD_CONTRATO = 1;

SELECT * FROM TLOG;



--Criando trigger
CREATE OR REPLACE TRIGGER valida_horario_curso2
BEFORE INSERT OR UPDATE OR DELETE ON TCONTRATO --ANTES DE REALIZAR O INSERT OU UPDATE OU DELETE
BEGIN
  IF(TO_CHAR(SYSDATE,'D') IN (1, 7) OR
  TO_NUMBER(To_Char(SYSDATE,'HH24'))NOT BETWEEN 8 AND 18)THEN
    IF( INSERTING ) THEN                                    --Se estiver inserindo 
      RAISE_APPLICATION_ERROR(-20001, 'Não pode inserir');
    ELSIF( DELETING ) THEN                                  --Se estiver deletando
      RAISE_APPLICATION_ERROR(-20002, 'Não pode remover');
    ELSIF( UPDATING('TOTAL') ) THEN                         --Se estiver updatando
      RAISE_APPLICATION_ERROR(-20003, 'Não pode alterar total');
    ELSE
      RAISE_APPLICATION_ERROR(-20004, 'Não pode alterar');
    END IF;
  END IF;
END;

--Testes
--Desabilitar trigger
ALTER TRIGGER valida_horario_curso DISABLE;

DELETE FROM TCONTRATO;

UPDATE TCONTRATO SET TOTAL = 5000 WHERE COD_CONTRATO = 1;

INSERT INTO TCONTRATO VALUES (90, SYSDATE, 10, 1500, NULL);

--Desabilitando trigger
ALTER TRIGGER valida_horario_curso2 DISABLE;


--Adicionando dados databela TLOG
ALTER TABLE TLOG ADD OBS VARCHAR(80);
ALTER TABLE TALUNO ADD SALARIO NUMERIC(12,2);           

--Criando trigger
CREATE OR REPLACE TRIGGER audita_aluno
AFTER INSERT OR DELETE OR UPDATE ON TALUNO  --Depois de inserir ou deletar ou updatar a tabela TALUNO, executar a trigger
FOR EACH ROW --Executa para cada linha afetada
             --Sem o FOR EACH ROW executa uma vez só
BEGIN
  IF( DELETING )THEN       --Se estiver deletando
    INSERT INTO TLOG( usuario, data, valor_antigo,OBS )
    VALUES ( :OLD.NOME, SYSDATE,:OLD.SALARIO,'Linhas deletadas.');
  ELSIF( INSERTING )THEN   --Se estiver inserindo
    INSERT INTO TLOG( usuario, data, valor_novo,OBS )
    VALUES ( :NEW.NOME, SYSDATE, :NEW.SALARIO,'Linhas inseridas.' );
  ELSIF( UPDATING('SALARIO') )THEN      --Se estiver alterando
    INSERT INTO TLOG
    VALUES ( :OLD.NOME, SYSDATE,:OLD.SALARIO,:NEW.SALARIO,
    'Alterado Salario');
  ELSE
    INSERT INTO TLOG( usuario, data, OBS )
    VALUES ( USER, SYSDATE, 'Atualização Aluno.' );
  END IF;
END;

--TESTES
SELECT * FROM TALUNO;
UPDATE TALUNO SET SALARIO = 4000;

SELECT * FROM TLOG;
--

                          
CREATE OR REPLACE TRIGGER gera_Log_CURSO
BEFORE UPDATE OF VALOR ON TCURSO
FOR EACH ROW
BEGIN
  INSERT INTO TLOG( Usuario, data, obs,Valor_antigo, Valor_novo)
  --OLD, NEW função Oracle que busca os valores anteriores e novos refente a ação executada
           VALUES ( USER||' DB', SYSDATE,'Curso Alterado: '||:OLD.NOME,:OLD.VALOR, :NEW.VALOR );
END;


--ALTER TRIGGER VALIDA_HORARIO_CURSO DISABLE;

SELECT * FROM TCURSO;

UPDATE TCURSO SET VALOR = 3000
WHERE valor > 1000

SELECT * FROM TLog;




ALTER TABLE tcontrato ADD valor_comissao NUMERIC(8,2);
SELECT * FROM TCONTRATO;

CREATE OR REPLACE TRIGGER calc_comissao
BEFORE INSERT OR UPDATE OF total ON TContrato --Executar antes do INSERT ou quando o UPDATE for na coluna total da tabela TCONTRATO
REFERENCING OLD AS antigo  --Referencia para OLD e NEW, apena para renomear os comandos :OLD e :NEW
            NEW AS novo
FOR EACH ROW --Executar para cada linha alterada
WHEN(Novo.Total >= 5000)   --Irá executar somente quando o total for maior que 5000
DECLARE
  vComissao NUMERIC(6,2) := 0.15; --Variável vComissao
BEGIN
  IF(:novo.Total <= 10000) THEN
    :novo.valor_comissao := :novo.Total*(vComissao);
  ELSE
    :novo.valor_comissao := :novo.Total*(vComissao+0.01);
  END IF;
END;
--
INSERT INTO TCONTRATO(COD_CONTRATO, TOTAL)VALUES(666,6000);
INSERT INTO TCONTRATO(COD_CONTRATO, TOTAL)VALUES(667,12000);


--ALTER TABLE tcontrato MODIFY desconto NUMERIC(12,2);

--INSERT INTO TCONTRATO VALUES (18, SYSDATE, 5, 7500 , NULL);
SELECT * FROM TCONTRATO;


--
--Exemplo de view com trigger e dml
CREATE OR REPLACE VIEW vcontratos_pares
AS SELECT COD_CONTRATO, DATA, COD_ALUNO, DESCONTO, TOTAL
   FROM   tcontrato
   WHERE  MOD( COD_CONTRATO, 2 ) = 0;  --View que traz apenas o resto da divisão da coluna COD_CONTRATO  por 2, com resultado 0
----------------
SELECT * FROM vcontratos_pares;
----------------
CREATE OR REPLACE TRIGGER tri_contratos_pares
INSTEAD OF INSERT OR DELETE OR UPDATE ON vcontratos_pares  --INSTEAD OF em INSERT ou DELETE ou UPDATE
DECLARE
BEGIN
  INSERT INTO TLOG( usuario, data, obs )
  VALUES (USER||' DB', SYSDATE, 'DML da view VCONTRATOS_PARES.' );
END;
----------------
INSERT INTO vContratos_pares VALUES(90,SYSDATE,10, NULL, 5000);

SELECT * FROM TLog;

