--ESTRUTURA DE UM BLOCO PL/SQL
--DELCARE --Opcional
--  Variávies, cursores, exceções, definidas pelo usuário
--BEGIN --Obrigatório
--  Comandos SQL
--  Comando PL/SQL
-- EXCEPTION --Opcional
--  Ações para executar quando ocorrer um erro
--END; --Obrigatório

--TIPOS DE BLOCOS
--ANÔNIMO, PROCEDURE, FUNÇÃO

--UTILIZAÇÃO DE VARIÁVEIS
--Armazenamento temporário de dados
--Manipulação de valores armazenados
--Reutilização
--Facilidade de manutenção

--TRATANDO VARIÁVEIS EM PL/SQL
--Delcare e inicialize variáveis dentro da seção de declaração;
--Atribua novos valores a variáveis dentro da seção executável;
--Você declarar uma variável antes de referenciar a outros comandos;
--Passe valores de subprogramas PL/SQL através de parâmetros;
--Visualize resultados do PL/SQL através de variáveis de saída;

--TIPOS DE VARIÁVEIS
--Tipos de dados escalares, armazem um único valor;
--Tipos de dados compostos como registros permitem definir e manipular grupos de campos em blocos PL/SQL;
--Tipos de dados de referência armazenam valores;
--Tipos de dados LOB armazenam valores, chamados de localizadores;

--DECLARANDO VARIÁVEIS PL/SQL

--identifier [CONSTANT] datatype [NOT NULL]
--                      [:= |DEFAULT expr];

--identifier é o nome da varíavel
--[CONSTANT] é se o valor da variável será constante, não irá mudar;

--DECLARE
--vData     DATE;
--vPreco    NUMBER(2) NOT NULL := 10;
--vCidade   VARCHAR2(13) := 'Novo Hamburgo'
--cDesconto NUMBER := 100;


--REGRAS DE NOMEMCLATURA
--Dois objetos podem possuir o mesmo nome, desde que sejam definidos em blocos diferentes. 
-- Onde eles coexistem, somente objeto declarado no bloco atual deve ser utilizado;
--Você não deve utilizar o mesmo nome (identificador) para uma variável que o nome de colunas de tabelas utilizadas no bloco. 
-- Por padrão, deve-se colocar a letra"v" para identificar que é uma variável;

--TIPOS DE DADOS ESCALARES
--VARCHAR2(maximum_length) -> Tipo de dado básico, para dados de caractere de tamanho variável de até 32767 bytes. Não tem tamanho default;
--NUMBER(precision,scale)  -> Tipo básico para números fixo e ponto flutuante;
--DATE                     -> Tipo básico para data e hora. Valores tipo DATE incluem a hora do dia em segundos desde a meia-noite;
--CHAR(maximun_length)     -> Tipo básico para dados de caracter de tamanho fixo de até 32767 bytes. Tamanho 1 caso não especificado. 
--                         -> Especificando um tamanho do tipo CHAR, caso não utilizado, o ORACLE irá preencher com espaços;
--LONG                     -> Tipo básico de caracter de tamanho variável de até 32760 bytes. O tamanho máximo de uma coluna do tipo LONG do banco de dados é 2GB;
--LONG RAW                 -> Tipo de dado básico binários e strings tipo byte  de até 326770. não são interpretados por comandos PL/SQL;
--BOOLEAN                  -> Três tipos de dados possíveis, utilizado para dados lógicos. TRUE, FALSE ou NULL;  
--BINARY_FLOAT             -> Ponto flutuante com precisão simples; Parecido com o tipo NUMBER;
--BINARY_DOUBLE            -> Ponto flutuante com precisão dupla; Capaçicade o dobro do BINARY_FLOAT;
--BINARY_INTEGER           -> tipo básico para inteiros;
--PLS_INTEGER              -> Tipo básico para inteiros com sinal. São mais rápidos que o tipo NUMBER e BINARY_INTEGER além de necessitarem de menos espaço;


--ATRIBUTO %TYPE
--Ao invés de codificar o tipo de dado e a precisão de uma variável, você pode utilizar
-- o atributo %TYPE para declarar uma variável de acordo com outra variável previamente declarada, ou uma coluna do banco de dados
--EXEMPLO
-- vNome tclientes.nome%TYPE; -> Irá assumir o mesmo tipo de dado da coluna NOME da tabela TCLIENTES;

--DECLARANDO VARIÁVEIS BOOLEAN
--Com PL/SQL você pode comprar variáveis em comandos SQL e procedurais
--EXEMPLO
-- vPreco1 := 500;
-- vPreco2 := 600;
-- vFlag BOOLEAN := (vPreco1 < vPreco2);

--Exemplo de bloco anônimo;

DECLARE
    x INTEGER;      --Variável x tipo integer
    y INTEGER;      --Variável y tipo integer
    c INTEGER;      --Variável c tipo integer
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
  vCIDADE := InitCap(VCIDADE); --Lembrando, o comando InitCap transforma a primeira letra de cada palavra em maíusculo
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
    Dbms_Output.Put_Line('vPreco1 é maior');
  ELSE
    Dbms_Output.Put_Line('vPreco2 é maior');
  END IF;
END;


--Bind variable (Variável fora do contexto do bloco anônimo)
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

--Neste exemplo será impresso primeiro o valor XXXX da variável VTESTE dentro do bloco, e depois imprimir o valor
-- TESTE que está no bloco principal 
DECLARE
  VTESTE VARCHAR(10) := 'TESTE';
BEGIN

  DECLARE
    VTESTE VARCHAR(10) := 'XXXX'; --Comentando esta linha, o bloco irá imprimir o valor declarado na variável do bloco externo
  BEGIN
    Dbms_Output.Put_Line('Bloco Interno: '||VTESTE);
  END;
  --
  Dbms_Output.Put_Line('Bloco Externo: '||VTESTE);

END;





