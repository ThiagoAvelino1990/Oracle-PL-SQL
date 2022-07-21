------------------------------TRATAMENTO DE EXCEÇÕES------------------------------
--Exceções são eventos(normalmente erros), os quais podemos tratar
--Interrupções de programa com mensagens(comando RAISE_APPLICATION_ERROR)
--Exceções pré-definidas Oracle(TOO_MANY_ROWS, NO_DATA_FOUND, etc)
--Exceções definidas pelo desenvolvedor
--Exceções disparadas pelo desenvolvedor(comando RAISE)
--Exceções que interceptam erros Oracle(pragma EXCEPTION_INIT)

------------------------------DIRETRIZES PARA O TRATAMENTO DE EXCEÇÕES------------------------------
--Inicie a seção de tratmento de exceções do bloco com a palavra chave EXCEPTION
--Defina vários tratamentos de exceções para o bloco, cada um com seu próprio conjunto de ações
--Quando uma exceção ocorrer, o PL/SQL processará somente um tratamento antes de encerrar o bloco
--Coloque a cláusula OTHERS após todas as outras cláusulas de tratamento de exceções

------------------------------TRATANDO ERROS PRÉ-DEFINIDOS DO SERVIDOR ORACLE------------------------------
--Nome de Exceção     |Erro Oracle |Descrição
--COLLECTION_IS_NULL  |ORA-06531   |Tentativa de aplicar métidos que não o EXISTS para uma Collection table não inicializada.
--CURSOR_ALREADY_OPEN |ORA-06511   |Tentativa de abrir um cursor que já aberto
--DUP_VAL_ON_INDEX    |ORA-00001   |Tentativa de inserir um valor duplicado
--INVALID_CURSOR      |ORA-01001   |Ocorreu uma operação ilegal em um cursor
--INVALID_NUMBER      |ORA-01722   |Falha na conversão de uma string caractere para numérica
--LOGIN_DENIED        |ORA-01017   |Conexão ao Oracle com um nome de usuário e/ou senha inválida
--NO_DATA_FOUND       |ORA-01403   |SELECT do tipo single-row não retornou nenhuma linha            
--NOT_LOGGEND_ON      |ORA-01012   |Programa PL/SQL executou uma chamada ao banco de dados sem estar conectado ao Oracle
--TIMEOUT_ON_RESOURCE |ORA-00051   |Ocorreu um time-out enquanto o Oracle estava aguardando por um recurso
--TOO_MANY_ROWS       |ORA-01422   |SELECT do tipo single-row retornou mais que uma linha
--VALUE_ERROR         |ORA-06502   |Ocorreu um erro de aritmética, conversão ou truncamento
--ZERO_DIVIDE         |ORA-01476   |Tentativa de divisão por zero
------------------------------EXCEÇÕES PRÉ-DEFINICADAS ORACLE------------------------------
--Exceções pré-definicadas devem ser tratadas na seção EXCEPTION de um bloco de código PL/SQL, utilizando-se da cláusula WHEN
------------------------------SQLCODE e SQLERRM------------------------------
--SQLCODE - retorna o código do erro Oracle disparou a exceção
--SQLERRM - retorna a mensagem gerada por esse erro
------------------------------EXCEÇÕES DEFINIDAS PELO DESENVOLVEDOR------------------------------
--O desenvolvedor pode criar suas próprias exceções declarando um identificador do tipo EXCEPTION na seção de declaração de variáveis no bloco PL/SQL
--Esse identificador pode ser usado para desviar o fluxo de exceção do programa para a seção de tratamento de exceções através do comando RAISE
--Pode-se forçar o erro devido a uma regra de negócio



--EXEMPLO DE EXCEPTIONS
DECLARE
  vCod   taluno.cod_aluno%TYPE := 566;
  vCidade taluno.cidade%TYPE;    
  vNum NUMBER;
BEGIN
  SELECT Cidade INTO vCidade
  FROM TAluno
  --WHERE nome LIKE '%';  --Forçar o exception TOO_MANY_VALUES
  WHERE  cod_aluno = vCod; --Forçar o exception NO_DATA_FOUN para vCod = 566
  --WHERE  cod_aluno = vCod; --Forçar o exception OTHERS para vCod = 1
  vNum := 0 / 0;
  Dbms_Output.Put_Line('Cidade: '||vCidade);
EXCEPTION --Tratamento de EXCEPTION
  WHEN no_data_found THEN
    RAISE_APPLICATION_ERROR(-20001, -- Este código é algo definido pelo programador
           'Aluno Inexistente! '||SQLCODE||' '||SQLERRM);
  WHEN too_many_rows THEN
    RAISE_APPLICATION_ERROR(-20002,
           'Registro Duplicado! '||SQLCODE||' '||SQLERRM);
  WHEN others THEN
    RAISE_APPLICATION_ERROR(-20003,
           'Exceção Desconhecida! '||SQLCODE||' '||SQLERRM);
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




--EXCEPTION por regra de negócio
DECLARE
   vDt_vencimento DATE;
   vConta  NUMBER := 100; --codigo da conta
   eConta_vencida EXCEPTION;  --variável do tipo EXCEPTION
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
   eFk_Erro EXCEPTION; --Variável do tipo exception
   PRAGMA EXCEPTION_INIT(eFk_Erro, -02291);
BEGIN
  INSERT INTO TBAIRRO VALUES ( 100, 100, 'ERRO');
EXCEPTION
   WHEN eFk_erro THEN
     RAISE_APPLICATION_ERROR(-20200, 'Cidade não existe!' );
END;
----



SELECT * FROM TBAIRRO;
SELECT * FROM TCIDADE;


