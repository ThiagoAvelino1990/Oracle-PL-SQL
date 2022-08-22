--ESTRUTURA DE UM BLOCO PL/SQL
--DELCARE --Opcional
--  Vari�vies, cursores, exce��es, definidas pelo usu�rio
--BEGIN --Obrigat�rio
--  Comandos SQL
--  Comando PL/SQL
-- EXCEPTION --Opcional
--  A��es para executar quando ocorrer um erro
--END; --Obrigat�rio

--TIPOS DE BLOCOS
--AN�NIMO, PROCEDURE, FUN��O

--UTILIZA��O DE VARI�VEIS
--Armazenamento tempor�rio de dados
--Manipula��o de valores armazenados
--Reutiliza��o
--Facilidade de manuten��o

--TRATANDO VARI�VEIS EM PL/SQL
--Delcare e inicialize vari�veis dentro da se��o de declara��o;
--Atribua novos valores a vari�veis dentro da se��o execut�vel;
--Voc� declarar uma vari�vel antes de referenciar a outros comandos;
--Passe valores de subprogramas PL/SQL atrav�s de par�metros;
--Visualize resultados do PL/SQL atrav�s de vari�veis de sa�da;

--TIPOS DE VARI�VEIS
--Tipos de dados escalares, armazem um �nico valor;
--Tipos de dados compostos como registros permitem definir e manipular grupos de campos em blocos PL/SQL;
--Tipos de dados de refer�ncia armazenam valores;
--Tipos de dados LOB armazenam valores, chamados de localizadores;

--DECLARANDO VARI�VEIS PL/SQL

--identifier [CONSTANT] datatype [NOT NULL]
--                      [:= |DEFAULT expr];

--identifier � o nome da var�avel
--[CONSTANT] � se o valor da vari�vel ser� constante, n�o ir� mudar;

--DECLARE
--vData     DATE;
--vPreco    NUMBER(2) NOT NULL := 10;
--vCidade   VARCHAR2(13) := 'Novo Hamburgo'
--cDesconto NUMBER := 100;


--REGRAS DE NOMEMCLATURA
--Dois objetos podem possuir o mesmo nome, desde que sejam definidos em blocos diferentes. 
-- Onde eles coexistem, somente objeto declarado no bloco atual deve ser utilizado;
--Voc� n�o deve utilizar o mesmo nome (identificador) para uma vari�vel que o nome de colunas de tabelas utilizadas no bloco. 
-- Por padr�o, deve-se colocar a letra"v" para identificar que � uma vari�vel;

--TIPOS DE DADOS ESCALARES
--VARCHAR2(maximum_length) -> Tipo de dado b�sico, para dados de caractere de tamanho vari�vel de at� 32767 bytes. N�o tem tamanho default;
--NUMBER(precision,scale)  -> Tipo b�sico para n�meros fixo e ponto flutuante;
--DATE                     -> Tipo b�sico para data e hora. Valores tipo DATE incluem a hora do dia em segundos desde a meia-noite;
--CHAR(maximun_length)     -> Tipo b�sico para dados de caracter de tamanho fixo de at� 32767 bytes. Tamanho 1 caso n�o especificado. 
--                         -> Especificando um tamanho do tipo CHAR, caso n�o utilizado, o ORACLE ir� preencher com espa�os;
--LONG                     -> Tipo b�sico de caracter de tamanho vari�vel de at� 32760 bytes. O tamanho m�ximo de uma coluna do tipo LONG do banco de dados � 2GB;
--LONG RAW                 -> Tipo de dado b�sico bin�rios e strings tipo byte  de at� 326770. n�o s�o interpretados por comandos PL/SQL;
--BOOLEAN                  -> Tr�s tipos de dados poss�veis, utilizado para dados l�gicos. TRUE, FALSE ou NULL;  
--BINARY_FLOAT             -> Ponto flutuante com precis�o simples; Parecido com o tipo NUMBER;
--BINARY_DOUBLE            -> Ponto flutuante com precis�o dupla; Capa�icade o dobro do BINARY_FLOAT;
--BINARY_INTEGER           -> tipo b�sico para inteiros;
--PLS_INTEGER              -> Tipo b�sico para inteiros com sinal. S�o mais r�pidos que o tipo NUMBER e BINARY_INTEGER al�m de necessitarem de menos espa�o;


--ATRIBUTO %TYPE
--Ao inv�s de codificar o tipo de dado e a precis�o de uma vari�vel, voc� pode utilizar
-- o atributo %TYPE para declarar uma vari�vel de acordo com outra vari�vel previamente declarada, ou uma coluna do banco de dados
--EXEMPLO
-- vNome tclientes.nome%TYPE; -> Ir� assumir o mesmo tipo de dado da coluna NOME da tabela TCLIENTES;

--DECLARANDO VARI�VEIS BOOLEAN
--Com PL/SQL voc� pode comprar vari�veis em comandos SQL e procedurais
--EXEMPLO
-- vPreco1 := 500;
-- vPreco2 := 600;
-- vFlag BOOLEAN := (vPreco1 < vPreco2);

--Exemplo de bloco an�nimo;

DECLARE
    x INTEGER;      --Vari�vel x tipo integer
    y INTEGER;      --Vari�vel y tipo integer
    c INTEGER;      --Vari�vel c tipo integer
BEGIN
    x := 10;
    y := 20;
    c := x + y;
    Dbms_Output.Put_line('Resultado: '|| c); --Comando Dbms_Output.Put_line(); para imprimir resultado de algum bloco 

END;

--
DECLARE
  VDESCONTO NUMBER(6,2) := 0.50;
  VCIDADE VARCHAR(30)   := 'NOVO HAMBURGO';
  VCOD_ALUNO  TALUNO.COD_ALUNO%TYPE := 5;
  VTOTAL NUMBER(8,2) := 1345.89;
BEGIN
  VTOTAL := Round(VTOTAL * VDESCONTO, 2);
  Dbms_Output.Put_Line('Total: '|| vTotal);

  VDESCONTO := 1.20;
  vCIDADE := InitCap(VCIDADE); --Lembrando, o comando InitCap transforma a primeira letra de cada palavra em ma�usculo
  Dbms_Output.Put_Line('Cidade: '||vCidade);
  Dbms_Output.Put_Line('Desconto: '||VDESCONTO);
  Dbms_Output.Put_Line('Aluno: '||VCOD_ALUNO);
END;


--
SELECT * FROM TCurso;
SELECT * FROM TAluno; 

DECLARE
  vPreco1 NUMBER(8,2)   := 10;
  vPreco2 NUMBER(8,2)   := 20;
  vFlag BOOLEAN; --True ou False
BEGIN
  vFlag := (vPreco1>vPreco2);
  IF (vFlag=True) THEN --Se vFlag = True Entao
    Dbms_Output.Put_Line('Verdadeiro');
  ELSE --Senao
    Dbms_Output.Put_Line('Falso');
  END IF; --Fim do If
  IF (VPRECO1>VPRECO2) THEN
    Dbms_Output.Put_Line('vPreco1 � maior');
  ELSE
    Dbms_Output.Put_Line('vPreco2 � maior');
  END IF;
END;


--Bind variable (Vari�vel fora do contexto do bloco an�nimo)
VARIABLE vDESCONTO2 NUMBER

DECLARE
  VCOD_ALUNO NUMBER := 1;
BEGIN
  :vDESCONTO2 := 0.90;
  Dbms_Output.put_line('desconto 2: '||:vDESCONTO2);

  UPDATE TContrato SET
  TOTAL = TOTAL * :vDESCONTO2
  WHERE COD_ALUNO = VCOD_ALUNO;

END;

SELECT * FROM tcontrato




--Aninhamento

--Neste exemplo ser� impresso primeiro o valor XXXX da vari�vel VTESTE dentro do bloco, e depois imprimir o valor
-- TESTE que est� no bloco principal 
DECLARE
  VTESTE VARCHAR(10) := 'TESTE';
BEGIN

  DECLARE
    VTESTE VARCHAR(10) := 'XXXX'; --Comentando esta linha, o bloco ir� imprimir o valor declarado na vari�vel do bloco externo
  BEGIN
    Dbms_Output.Put_Line('Bloco Interno: '||VTESTE);
  END;
  --
  Dbms_Output.Put_Line('Bloco Externo: '||VTESTE);

END;





