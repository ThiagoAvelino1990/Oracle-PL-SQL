------------------------------TRATAMENTO DE EXCE��ES------------------------------
--Exce��es s�o eventos(normalmente erros), os quais podemos tratar
--Interrup��es de programa com mensagens(comando RAISE_APPLICATION_ERROR)
--Exce��es pr�-definidas Oracle(TOO_MANY_ROWS, NO_DATA_FOUND, etc)
--Exce��es definidas pelo desenvolvedor
--Exce��es disparadas pelo desenvolvedor(comando RAISE)
--Exce��es que interceptam erros Oracle(pragma EXCEPTION_INIT)

------------------------------DIRETRIZES PARA O TRATAMENTO DE EXCE��ES------------------------------
--Inicie a se��o de tratmento de exce��es do bloco com a palavra chave EXCEPTION
--Defina v�rios tratamentos de exce��es para o bloco, cada um com seu pr�prio conjunto de a��es
--Quando uma exce��o ocorrer, o PL/SQL processar� somente um tratamento antes de encerrar o bloco
--Coloque a cl�usula OTHERS ap�s todas as outras cl�usulas de tratamento de exce��es

------------------------------TRATANDO ERROS PR�-DEFINIDOS DO SERVIDOR ORACLE------------------------------
--Nome de Exce��o     |Erro Oracle |Descri��o
--COLLECTION_IS_NULL  |ORA-06531   |Tentativa de aplicar m�tidos que n�o o EXISTS para uma Collection table n�o inicializada.
--CURSOR_ALREADY_OPEN |ORA-06511   |Tentativa de abrir um cursor que j� aberto
--DUP_VAL_ON_INDEX    |ORA-00001   |Tentativa de inserir um valor duplicado
--INVALID_CURSOR      |ORA-01001   |Ocorreu uma opera��o ilegal em um cursor
--INVALID_NUMBER      |ORA-01722   |Falha na convers�o de uma string caractere para num�rica
--LOGIN_DENIED        |ORA-01017   |Conex�o ao Oracle com um nome de usu�rio e/ou senha inv�lida
--NO_DATA_FOUND       |ORA-01403   |SELECT do tipo single-row n�o retornou nenhuma linha            
--NOT_LOGGEND_ON      |ORA-01012   |Programa PL/SQL executou uma chamada ao banco de dados sem estar conectado ao Oracle
--TIMEOUT_ON_RESOURCE |ORA-00051   |Ocorreu um time-out enquanto o Oracle estava aguardando por um recurso
--TOO_MANY_ROWS       |ORA-01422   |SELECT do tipo single-row retornou mais que uma linha
--VALUE_ERROR         |ORA-06502   |Ocorreu um erro de aritm�tica, convers�o ou truncamento
--ZERO_DIVIDE         |ORA-01476   |Tentativa de divis�o por zero
------------------------------EXCE��ES PR�-DEFINICADAS ORACLE------------------------------
--Exce��es pr�-definicadas devem ser tratadas na se��o EXCEPTION de um bloco de c�digo PL/SQL, utilizando-se da cl�usula WHEN
------------------------------SQLCODE e SQLERRM------------------------------
--SQLCODE - retorna o c�digo do erro Oracle disparou a exce��o
--SQLERRM - retorna a mensagem gerada por esse erro
------------------------------EXCE��ES DEFINIDAS PELO DESENVOLVEDOR------------------------------
--O desenvolvedor pode criar suas pr�prias exce��es declarando um identificador do tipo EXCEPTION na se��o de declara��o de vari�veis no bloco PL/SQL
--Esse identificador pode ser usado para desviar o fluxo de exce��o do programa para a se��o de tratamento de exce��es atrav�s do comando RAISE
--Pode-se for�ar o erro devido a uma regra de neg�cio



--EXEMPLO DE EXCEPTIONS
DECLARE
  vCod   taluno.cod_aluno%TYPE := 566;
  vCidade taluno.cidade%TYPE;    
  vNum NUMBER;
BEGIN
  SELECT Cidade INTO vCidade
  FROM TAluno
  --WHERE nome LIKE '%';  --For�ar o exception TOO_MANY_VALUES
  WHERE  cod_aluno = vCod; --For�ar o exception NO_DATA_FOUN para vCod = 566
  --WHERE  cod_aluno = vCod; --For�ar o exception OTHERS para vCod = 1
  vNum := 0 / 0;
  Dbms_Output.Put_Line('Cidade: '||vCidade);
EXCEPTION --Tratamento de EXCEPTION
  WHEN no_data_found THEN
    RAISE_APPLICATION_ERROR(-20001, -- Este c�digo � algo definido pelo programador
           'Aluno Inexistente! '||SQLCODE||' '||SQLERRM);
  WHEN too_many_rows THEN
    RAISE_APPLICATION_ERROR(-20002,
           'Registro Duplicado! '||SQLCODE||' '||SQLERRM);
  WHEN others THEN
    RAISE_APPLICATION_ERROR(-20003,
           'Exce��o Desconhecida! '||SQLCODE||' '||SQLERRM);
END;


--SELECT * FROM taluno

CREATE TABLE CONTAS
(
  Codigo     INTEGER NOT NULL PRIMARY KEY,
  Valor      NUMBER(10, 2),
  Juros      NUMBER(10, 2),
  Vencimento DATE
);

INSERT INTO CONTAS VALUES (100, 550, 50, SYSDATE-10);

SELECT * FROM CONTAS;

COMMIT;




--EXCEPTION por regra de neg�cio
DECLARE
   vDt_vencimento DATE;
   vConta  NUMBER := 100; --codigo da conta
   eConta_vencida EXCEPTION;  --vari�vel do tipo EXCEPTION
BEGIN
  SELECT vencimento INTO vDt_vencimento --SELECT SINGLE ROW
  FROM CONTAS WHERE codigo = vConta;
  IF vDt_vencimento < TRUNC(SYSDATE) THEN
    RAISE eConta_vencida; --RAISE comando para disparar uma mensagem de erro
  END IF;
 EXCEPTION
  WHEN eConta_vencida THEN
    Dbms_Output.Put_Line('Conta vencida');
    UPDATE contas SET valor = valor + juros
    WHERE  codigo = vConta;
END;

--VALOR MUDA PARA 600
SELECT * FROM contas


--Exemplo PRAGMA, para interceptar um erro
DECLARE
   eFk_Erro EXCEPTION; --Vari�vel do tipo exception
   PRAGMA EXCEPTION_INIT(eFk_Erro, -02291);
BEGIN
  INSERT INTO TBAIRRO VALUES ( 100, 100, 'ERRO');
EXCEPTION
   WHEN eFk_erro THEN
     RAISE_APPLICATION_ERROR(-20200, 'Cidade n�o existe!' );
END;
----



SELECT * FROM TBAIRRO;
SELECT * FROM TCIDADE;


