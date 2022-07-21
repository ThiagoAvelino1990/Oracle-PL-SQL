------------------------------PROCEDURES------------------------------
------------------------------SINTAXE DE CRIAR PROCEDURES------------------------------
--CREATE OR REPLACE PROCEDURE nome_procedure
--          [(nome_parâmetro [tipo] datatype,
--            nome_parâmetro [tipo] datatype,...)]
--  IS|AS
--  [Declração de variáveis]
--BEGIN
--  Comandos SQL
--  Comandos PL/SQL
--[EXCEPTION
--  Tratamento de exceções]
--END [nome_procedure];

------------------------------PARÂMETROS------------------------------
--Em subprogramas PL/SQL, declare parâmetros(argumentos) para estabelecer comunicação entre o subprograma e o ambiente que o disparou
--Existem três tipo de parâmetros:
--  °IN[DEFAULT expr] --Parâmetro de entrada
--  °OUT[NOCOPY] --Parâmetro de saída
--  ºIN OUT[NOCOPY] --Parâmetro de entrada e saída
--Parâmetros devem ser declarados como um tipo de dados escalar(VARCHAR2, NUMBER, ,DATE, etc.) sem precisão, ou com um tipo %TYPE ou %ROWTYPE(Tipo record)



CREATE OR REPLACE PROCEDURE aumenta_precocurso(pCod_Curso NUMBER) --Parâmetro pCod_curso criado. Ao criar parâmetros, informar a letra "p" antes
IS
  -- Variaveis
BEGIN
  --Aumenta 50%
  UPDATE TCURSO SET
  VALOR = VALOR * 1.5
  WHERE COD_CURSO = pCod_Curso;
END;

--Teste
SELECT * FROM TCURSO;

--Executar a procedure criada
EXEC AUMENTA_PRECOCURSO(7); --Executa a procedure

--Executar a procedure com bloco anonimo
declare
  vcod INTEGER := &codigo;
begin
  AUMENTA_PRECOCURSO(vcod);
end;


--Mesmo tipo, apenas o parâmetro trocado com o tipo da coluna COD_CURSO da tabela TCURSO
CREATE OR REPLACE PROCEDURE Aumenta_Preco
(pCODIGO IN TCURSO.COD_CURSO%TYPE)
IS
BEGIN
  UPDATE TCURSO
  SET    VALOR = VALOR * 1.1
  WHERE  COD_CURSO = pCodigo;
END;

EXEC Aumenta_Preco(1);




--Criando procedure consulta_aluno
CREATE OR REPLACE PROCEDURE Consulta_Aluno
( pCodigo        IN  TALUNO.Cod_Aluno%TYPE, --Parâmetros do tipo IN(Entrada) É preciso passar algum parâmetro para a execução da PROCEDURE
  pNome          OUT TALUNO.Nome%TYPE,      --Parâmetros do tipo OUT(Saída)
  pCep           OUT TALUNO.Cep%TYPE,       --Parâmetros do tipo OUT(Saída)
  pCidade        OUT TALUNO.Cidade%TYPE)    --Parâmetros do tipo OUT(Saída)
IS
BEGIN
  SELECT nome, Cep, cidade
  INTO   pNome, pCep, pCidade
  FROM   taluno
  WHERE  cod_aluno = pCodigo;
END;


--Teste PROCEDURE Consulta_Aluno
DECLARE
  vnome VARCHAR2(30);
  vcidade VARCHAR(30);
  vcep VARCHAR(10);
  vCod INTEGER := &Codigo;
BEGIN
  --executa a procedure
 -- Consulta_aluno(vcod, vnome, vcep, vcidade);  --Este é um modo para execução da procedure com os parâmetros em ordem

 --Abaixo outra forma de usar uma procedure com os parâmetros, sem necessariamente colocar na ordem
  Consulta_Aluno(pNome => vnome,
                 pCodigo => vcod,
                 pCidade => vcidade,
                 pCep => vcep);

  Dbms_Output.Put_Line(vNome);   --Impressão de dados
  Dbms_Output.Put_Line(vCidade); --Impressão de dados
  Dbms_Output.Put_Line(vcep);    --Impressão de dados
  
END;

--Procedure utilizando cursor e utilizando uma variável apenas do tipo RECORD
CREATE OR REPLACE PROCEDURE Consulta_Aluno2
(pRegistro IN OUT TALUNO%ROWTYPE) --Parâmetro do tipo IN|OUT do tipo RECORD, ou seja, com a mesma estrutura da tabela TALUNO
IS
  CURSOR CSQL IS
    SELECT * FROM TALUNO WHERE cod_aluno = pRegistro.COD_ALUNO; --cod_aluno recebe parâmetro 
BEGIN
  OPEN CSQL;      --Abrir CURSOR
  FETCH CSQL INTO pRegistro; --Resultado do cursor e jogo no RECORD pRegistro
  CLOSE CSQL;     --Fechar CURSOR
END;

--Teste PROCEDURE consulta_aluno2
DECLARE
  VREGISTRO TALUNO%ROWTYPE;  --Variável do mesmo tipo da tabela TALUNO
BEGIN
  VREGISTRO.COD_ALUNO := 1;
  CONSULTA_ALUNO2(VREGISTRO);
  DBMS_OUTPUT.PUT_LINE(VREGISTRO.NOME);
  DBMS_OUTPUT.PUT_LINE(VREGISTRO.CIDADE||' CEP: '||VREGISTRO.CEP);
END;


--------------------------------------------
--PROCEDURE que trabalha apenas com variáveis, não utiliza nada de do nosso Banco de dados
CREATE OR REPLACE PROCEDURE formata_numero
(pTelefone IN OUT VARCHAR2) --Parâmetro do tipo entrada e saída
IS
BEGIN
   pTelefone := SUBSTR(pTelefone, 1, 4)||'-'||
                SUBSTR(pTelefone, 5, 4);
END;

---------------------Teste PROCEDURE formata_numero
DECLARE
  vTelefone VARCHAR2(20);
BEGIN
  vTelefone := '12345678';
  formata_numero(vtelefone);
  Dbms_Output.Put_Line(vTelefone); --1234-5678
END;


--Exercicio
1) Criar uma procedure para cadastrar aluno,
usar SEQUENCE, usar bloco anonimo para executar
e imprimir o valor do codigo criado.

  out   in     in
 (pcod, pnome, pcidade)

 CREATE SEQUENCE seq_aluno START WITH 100;

 SELECT Seq_Aluno.NEXTVAL INTO pCod FROM Dual;


2)Criar uma procedure para excluir registros da tabela de
  contrato (TContrato) passar como parametros de entrada
  o codigo do contrato a ser excluido e receber a quantidade
  de registros excluidos como saida e imprimir esta informaçao.

DELETE FROM TABELA WHERE COD_CONTRATO = pCod; --param tipo in
pQtde := SQL%ROWCOUNT; --parametro do tipo out







CREATE SEQUENCE seq_alu START WITH 999

2)Criar uma procedure para excluir registros da tabela de
contrato (TContrato) passar como parametros de entrada
o codigo do contrato a ser excluido e receber a quantidade
de registros excluidos como saida e imprimir esta informaçao.




--vCod NUMBER;
--Pcod := Seq_Alu.NEXTVAL;

CREATE SEQUENCE seq_alu START WITH 500;
-------------------------------------------------------
CREATE OR REPLACE PROCEDURE cad_aluno
(pcod OUT NUMBER,
 pnome IN VARCHAR,
 pcidade IN VARCHAR)
IS
BEGIN
  SELECT SEQ_ALU.NEXTVAL INTO PCOD FROM DUAL;
  INSERT INTO taluno(cod_Aluno,Nome,Cidade)
  VALUES (pCod,pNome,pCidade);
END;
-----------------------------------------------------
DECLARE
  vcod NUMBER;
  vnome VARCHAR(20)   := '&nome';
  vcidade VARCHAR(20) := '&cidade';
BEGIN
  cad_aluno(vcod,vnome,vcidade);
  Dbms_Output.Put_Line('Aluno cadastrado, Codigo->'||vcod);
END;


2)Criar uma procedure para excluir registros da tabela de
contrato (TContrato) passar como parametros de entrada
o codigo do contrato a ser excluido e receber a quantidade
de registros excluidos como saida e imprimir esta informaçao.




  ex:
  exclui_contrato(cod,mensagem);

  impressao: 0 contrato excluido

  vmsg := SQL%ROWCOUNT ||' contrato excluido';


----
CREATE OR REPLACE PROCEDURE exclui_contrato
  (pCod IN NUMBER, pMsg OUT VARCHAR)
AS
BEGIN
  DELETE FROM TCONTRATO
  WHERE COD_CONTRATO = pCod;
  pMsg := SQL%ROWCOUNT ||' Contrato Excluido ';
END;

----Teste
DECLARE
  vMsg VARCHAR(40);
BEGIN
  Exclui_Contrato(&codigo, vMsg);
  Dbms_Output.Put_Line(vMsg);
END;

