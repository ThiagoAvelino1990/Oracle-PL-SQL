--Um RECORD é um grupo de itens de dados relacionados armazenados em campos, cada um com seu proprio nome e tipo de dado;

--DECLARE
--TYPE name_record is RECORD 
--(field_declaration[,
-- field_declaration]...);
--
--variáel record_type;

---------------------------------------Atributo %ROWTYPE---------------------------------------
--Para declarar um RECORD baseado em uma coleção de colunas de uma tabela ou visão do banco de dados, você utiliza o atributo %ROWTYPE;
-- Vantagens: O número e tipos de dados das colunas referenciadas do banco de dados não precisam ser conhecidos;
-- O número e tipos de dados das colunas referenciadas do banco de dados podem modificar-se em tempo de execução;
-- Bastante útil quando recupera-se toda uma linha com o comando SELECT
-- Declare uma variável para armazenar a mesma informação de um cliente como ela é armazenada na tabela TCLIENTES
--    cliente_record tclientes%ROWTYPE;

---------------------------------------OQUE É UMA COLLECTON---------------------------------------
--Collections são estuturas utilizadas para gerenciamento de m[ultiplas linhas de dados;
--Collections são listas(vetores) de dados:
---------------------------------------ASSOCIATIVE ARRAYS(index-by-tables)---------------------------------------
--           Pode ser indexada por valores numéricos ou caracter permitindo buracos na definição; Tamanho: Variável
--           Não necessita da utilização do método EXTEND para a alocação de novos elementos;
--           Pode ser indexado com qualquer valor numérico, o que significa valores negativos, positivos ou também o zero, e também valores caracter
--           Obrigatória a cláusula INDEX BY
---------------------------------------Criando um ASSOCIATIVE ARRAY---------------------------------------
--Declare o tipo de dado da tabela PL/SQL(associative array)
--Declare uma variável com este tipo de dado
--TYPE tyep_name is TABLE OF {column_type |
--                            variable%TYPE |
--                            table.column%TYPE}
--                            [NOT NULL]
--[INDEX BY BINARY_INTEGER | VARCHAR2(size)];
--identifier type_name;
---------------------------------------Utilizando um ASSOCIATIVE ARRAY---------------------------------------
--DECLARE
--  TYPE nome_tabela_type IS TABLE OF tclientes.nome%TYPE
--    INDEX BY BINARY_INTEGER;
--  TYPE dt_nascimento_table_type IS TABLE OF DATE
--    INDEX BY BINARY_INTENER;
--
--  nome_table            nome_table_type;
--  dt_nascimento_table   dt_nascimento_table_type;
--BEGIN
--  nome_table(1) := 'Marcio';
--  dt_nascimento_Table(8) := SYSDATE + 7;
--     ...
--END;
---------------------------------------ASSOCIATIVE ARRAYS com Registros---------------------------------------
--Declare uma variável PL/SQL para armazenar informações de clientes
--DECLARE
--  TYPE cliente_table_type IS TABLE OF tclientes%ROWTYPE
--    INDEX BY BINARY_INTEGER;
--
--  cliente_table     cliente_Table_type;
--Cada elemento de cliente_Table é um registro
---------------------------------------------------------------------------------------------------------------------
---------------------------------------NESTED TABLES---------------------------------------
---------------------------------------------------------------------------------------------------------------------
--Inicialmente definiada como sendo um vetor sem buracos nadefinição, mas pode se tornar esparsa quando registros forem removidos.
--Também pode ser dinamicamente estendida. Tamanho: Variável
--Elementos precisam ser alocados com o método EXTEND para serem definidos;
--Indexada com valores positivos(de1 até N)
--Deve ser incializada, se não for inicializada seu valor é NULL
--Sem ca cláusula INDEX BY

--------------------------------------Criando um NESTED TABLES--------------------------------------
--Declare o tipo de dados da tabela PL/SQL(nested table)
--Declare uma variável com este tipo de dados
--TYPE type_name IS TABLE OF {column_type |
--                            variable%TYPE |
--                            table.column%TYPE};
--identifier    type_name := type_name();

--------------------------------------Utilizando NESTED TABLES--------------------------------------
--DECLARE
--  TYPE nome_table_type IS TABLE OF tclientes.nome%TYPE;
--  TYPE dt_nascimento_table_type IS TABLE OF DATE;
--declarando e inicializando com um valor nulo de linhas
--  nome_table nome _table_type := nome_table_type();

--declarando e inicializando com uma linha
--  dt_nascimento_table dt_nascimento_table_type :=
--                      dt_nascimento_table_type(NULL);
--BEGIN
--  nome_table.EXTEND; -- alocando uma nova linha
--  nome_table(1) := 'Marcio';
--
--  dt_nascimento_table(1) := SYSDATE + 7;
--...
--END;

------------------------------------------------------------------------------------------------------------------
--------------------------------------VARRAYS--------------------------------------
------------------------------------------------------------------------------------------------------------------
--Semelhante a programação tradicional de vetor. Na criação, definimos um tamanho não modificável;
--Conjunto ordenado de elementos de dados;
--Cada elemento possui um índice, o qual é o número correspondente a posição do elemento array;
--O Oracle permite que arrays sejam de tamanho variável, por isso são chamados de VARRAYS, mas o tamanho máximo deve ser especificado na declaração do tipo;

--------------------------------------Criando um VARRAY--------------------------------------
--Declare o tipo de dado varray;
--Declare uma variável com este tipo de dado
--TYPE type_name {IS VARRAY | VARYING ARRAY}
--               (size_limit)OF
--               element_type []NOT NULL];
--identifier type_name := type_name();

--------------------------------------Utilizando VARRAYS--------------------------------------
--DECLARE
--  TYPE nome_varray IS VARRAY(5) OF tclientes.nome%TYPE;
--  TYPE dt_nascimento_varray IS VARRAY(5) OF DATE;
--
--declarando e inicializando com um valor nulo de linhas
--  nome_vetor nome_array := nome_varray();
--
--declarando e inicializando com um valor nulo de linhas
--  dt_nascimento_vetor dt_nascimento_varray := dt_nascimento_varray();
--
--BEGIN
--  nome_vetor.EXTEND; --alocando uma nova linha;
--  nome_vetor(1) :- 'Marcio';
--  dt_nascimento_vetor.EXTEND; --alocando uma nova linha;
--  dt_nascimento_vetor(1) :=SYSDATE + 7;
--...
--END;

------------------------------------------------------------------------------------------------------------------
--------------------------------------Utilizando COLLECTIONS--------------------------------------
------------------------------------------------------------------------------------------------------------------
--Método:     |Descrição                                                           |Collections que suportam
--EXISTS(n)   |Retorna TRUE se o elemento (n) não existe                           |Todas
--COUNT       |Retorna o número de elementos                                       |Todas
--FIRST/ LAST |Retorna o primeiro e o último (menor e maior) números do índice.    |Todas
--            |Retorna NULL se a Collection está vazia.                            |
--PRIOR(n)    |Retorna o número do índice anterior a n.                            |Todas
--NEXT(n)     |Retorna o número do índice posterior a n.                           |Todas
--EXTEND(n,i) |Para aumentar o tamanho:                                            |Nested Table ou Array
--            |EXTEND adiciona um elemento nulo                                    |
--            |EXTEND(n)adiciona n elementos nulos                                 |
--            |EXTEND(n,i)adiciona n cópias do elementos i                         |
--TRIM        |TRIM remove um elemento do final da Collection.                     |Nested Table ou Array
--            |TRIM(n) remove n elementos do final da Collection                   |
--DELETE      |DELETE remove todos os elementos de uma Collecton                   |Todas
--            |DELETE(n) remove o elemento n da Collection                         |
--            |DELETE(m, n)remove todos os elementos na baixa m...n da Collection. |



------------------------------------------------------------------------------------------------------------------

--Exemplo de Record Simples
DECLARE
   --Estrutura de declaração do record
   TYPE Rec_aluno IS RECORD
   ( cod_aluno NUMBER NOT NULL := 0, --registro cod_aluno do tipo NUMBER, NOT NULL
     nome    TALUNO.Nome%TYPE, --registro nome do mesmo tipo da coluna NOME da tabela TALUNO
     cidade TALUNO.Cidade%TYPE ); --registro cidade do mesmo tipo da coluna CIDADE da tabela TALUNO
   --Variável registro do tipo rec_aluno
   registro rec_aluno;
BEGIN
--Usando os dados do record
   registro.cod_aluno := 50;
   registro.nome      := 'Master';
   registro.cidade    := 'Novo Hamburgo';
   ---
   Dbms_Output.Put_Line('Codigo: '||registro.cod_aluno);
   Dbms_Output.Put_Line('  Nome: '||registro.nome);
   Dbms_Output.Put_Line('Cidade: '||registro.cidade);
   ---
END;


        
------
--Exemplo de RECORD com estrutura de uma tabela
DECLARE
  reg TAluno%ROWTYPE;  --Record do mesmo tipo da tabela TALUNO( reg receberá a estrutura da tabela TALUNO)
  vcep  VARCHAR2(10) := '93000000'  ;
BEGIN
  SELECT COD_ALUNO, NOME, CIDADE, SALARIO
  INTO Reg.cod_aluno, Reg.nome, Reg.cidade, reg.salario
  FROM TALUNO
  WHERE COD_ALUNO = 1;    
  
  reg.CEP := vcep; --Campo CEP do RECORD reg receve o valor da variável VCEP

  Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
  Dbms_Output.Put_Line('Nome  : ' ||reg.nome);
  Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
  Dbms_Output.Put_Line('Cep   : ' ||reg.cep);
  dbms_output.Put_line('Salario: '||reg.salario);
END;


            

--Exemplo RECORD matriz
DECLARE
  TYPE T_ALUNO IS TABLE OF TALUNO.NOME%TYPE --IS TABLE OF indica que será uma matriz. Record do tipo NOME da tabela TALUNO
  INDEX BY BINARY_INTEGER; --O acesso ao elementos será através de um número inteiro

  REGISTRO T_ALUNO; --Declarando o Record
BEGIN
  REGISTRO(1) := 'MARCIO'; --record REGISTRO do tipo T_ALUNO, recebe o valor de 'MARCIO' na posição (1) da matriz
  REGISTRO(2) := 'JOSE';
  REGISTRO(3) := 'PEDRO';
  --
  Dbms_Output.Put_Line('Nome 1: '||registro(1));
  Dbms_Output.Put_Line('Nome 2: '||registro(2));
  Dbms_Output.Put_Line('Nome 3: '||registro(3));
END;




--
    SELECT cod_aluno, NOME
    FROM tALUNO WHERE COD_ALUNO = 1;

--




--Utilizando IS TABLE OF e EXTEND para criação de linhas novas
DECLARE
  TYPE nome_type IS TABLE OF taluno.nome%TYPE; --Matriz que será do mesmo tipo da coluna NOME da tabela TALUNO
  nome_table nome_type := nome_type();  --Criando Instancia -> nome_table do tipo nome_type, que recebe os valores de nome_type()
BEGIN
  nome_table.EXTEND; -- alocando uma nova linha
  nome_table(1) := 'Marcelo';
  nome_table.EXTEND; -- alocando uma nova linha
  nome_table(2) := 'Marcio';
  nome_table.EXTEND; -- para passar um valor para um campo na matriz, deve-se sempre inserir um novo registro com o comando EXTEND;
  nome_table(3) := 'Doidin';
  Dbms_Output.Put_Line('Nome 1: '||nome_table(1));
  Dbms_Output.Put_Line('Nome 2: '||nome_table(2));
  Dbms_Output.Put_Line('Nome 3: '||nome_table(3));
END;



--
DECLARE
  TYPE sigla IS TABLE OF VARCHAR2(40) 
  INDEX BY VARCHAR2(2); --O acesso será através de um VARCHAR2 com o valor de 2 caracteres;
  --uf_capital do tipo sigla
  uf_capital sigla;
BEGIN
  uf_capital('RS') := 'PORTO ALEGRE';      --A "posição" RS recebe o valor de 'PORTO ALEGRE'
  uf_capital('RJ') := 'RIO DE JANEIRO';    --A "posição" RJ recebe o valor de 'RIO DE JANEIRO'
  uf_capital('PR') := 'CURITIBA';          --A "posição" PR recebe o valor de 'CURITIBA'
  uf_capital('MT') := 'CUIABA';            --A "posição" MT recebe o valor de 'CUIABA'
  dbms_output.put_line(uf_capital('RS'));  --Impressão do valor que está na "posição" RS
  dbms_output.put_line(uf_capital('RJ'));  --Impressão do valor que está na "posição" RJ
  dbms_output.put_line(uf_capital('PR'));  --Impressão do valor que está na "posição" PR
  dbms_output.put_line(uf_capital('MT'));  --Impressão do valor que está na "posição" MT
END;




--  VARRAY
DECLARE
  TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;   --Limite máximo de 5 do VARRAY
  nome_vetor nome_varray := nome_varray();
BEGIN
  nome_vetor.EXTEND; --Extendendo uma linha. Posso fazer a extensão apenas até o limite de 5
  nome_vetor(1) := 'MasterTraining';
  Dbms_Output.Put_Line(nome_vetor(1));
END;



------FUNÇÃO PIPELINED------

create or replace FUNCTION CONSULTA_PRECO
(pCod_Curso NUMBER) RETURN NUMBER
AS
  vValor NUMBER;
BEGIN
  SELECT valor 
    INTO vValor FROM TCurso
   WHERE cod_curso = pCod_Curso;
     
  RETURN(vValor);

EXCEPTION
  WHEN OTHERS THEN
  RETURN (0);
  
END;


--TESTE FUNCTION CONSULTA_PRECO
DECLARE
    VCOD NUMBER := &CODIGO;
    VVALOR NUMBER;
BEGIN
    VVALOR := CONSULTA_PRECO(VCOD);
    DBMS_OUTPUT.PUT_LINE('PRECO DO CURSO '||VCOD||' : '||VVALOR);
END;


--Uma function pipelined pode retornar mais de um valor. Ela pode retornar uma coleção, 
--  que seria um objeto e ele retornar mais de um valor

--Criando um ARRAY
CREATE OR REPLACE TYPE REG_ALUNO AS OBJECT
(CODIGO INTEGER,
NOME VARCHAR2(30),
CIDADE VARCHAR2(30));

--Criando uma MATRIZ a partir do ARRAY
CREATE OR REPLACE TYPE TABLE_REG_ALUNO AS TABLE OF REG_ALUNO;


--Function que retorna registros
CREATE OR REPLACE FUNCTION GET_ALUNO(pCODIGO NUMBER)
RETURN TABLE_REG_ALUNO PIPELINED --retorna a matriz criada
IS
 outLista REG_ALUNO; --variável criada do tipo da matriz
 CURSOR CSQL IS
   SELECT ALU.COD_ALUNO, ALU.NOME, ALU.CIDADE
   FROM TALUNO ALU
   WHERE ALU.COD_ALUNO = pCODIGO;
 REG CSQL%ROWTYPE; --Variável REG do mesmo tipo do CURSOR CSQL criado
BEGIN
  OPEN CSQL; --Abrir o cursor
  FETCH CSQL INTO REG; --Pegar o resultado e passar para a variável REG
  outLista := REG_ALUNO(REG.COD_ALUNO, REG.NOME, REG.CIDADE);
  PIPE ROW(outLista); --Escreve a linha
  CLOSE CSQL;
  RETURN;
END;

--Utilizando a função GET_ALUNO
SELECT * FROM TABLE(GET_ALUNO(1));--Informando o TABLE para fazer uma conversão no SELECT


--Utilizando a função GET_ALUNO com JOIN em outra tabela
SELECT ALU.*, CON.total
FROM TABLE(GET_ALUNO(1)) ALU, TCONTRATO CON
WHERE CON.COD_ALUNO = ALU.CODIGO;

--Criando outra função para retornar todos os alunos
CREATE OR REPLACE FUNCTION GET_ALUNOS
RETURN TABLE_REG_ALUNO PIPELINED
IS
 outLista REG_ALUNO;
 CURSOR CSQL IS
   SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO;
 REG CSQL%ROWTYPE;
BEGIN
 FOR REG IN CSQL
 LOOP   ----------.......
   outLista := REG_ALUNO(REG.COD_ALUNO,REG.NOME,REG.CIDADE);
   PIPE ROW(outLista);
 END LOOP; ------........
 RETURN;
END;

--Usando
SELECT * FROM TABLE(GET_ALUNOS);



----------BULK COLLECT----------
--O uso do Bulk Collect é aplicado para a manipulação de grande massa de dados. 
--  Com seu uso correto, podemos ter vários tipos de ganhos.
--Podemos ter: Aplicações mais rápidas, alocação dos dados na memória, sem a necessidade de refazer a busca no banco. 
--  Porem temos um risco também, pois se não aplicarmos corretamente as diretrizes na PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na memória.
--Para estes problemas temos a claúsula LIMIT, que limita os dados que foram para a memória.

--Exemplo:

CREATE TABLE TPRODUTO (
  COD_PRODUTO NUMBER(5),
  DESCRICAO VARCHAR2(40),
  CONSTRAINT PRODUTO_PK PRIMARY KEY (COD_PRODUTO));
--Inserindo os dados na tabela:

BEGIN
  INSERT INTO TPRODUTO
  SELECT LEVEL, DBMS_RANDOM.STRING('A', 40) FROM DUAL CONNECT BY LEVEL <= 100;
  COMMIT;
END;
--Vamos agora usar o Bulk Collect com limite de 50 registros. 
--Vamos colocar a cada loop apenas 50 registros na memória.

DECLARE
  CURSOR CUR_PRODUTO IS
  SELECT COD_PRODUTO, DESCRICAO FROM TPRODUTO;
  TYPE TROW_PRODUTO IS TABLE OF CUR_PRODUTO%ROWTYPE INDEX BY PLS_INTEGER;
  ROW_PRODUTO TROW_PRODUTO;
BEGIN
  OPEN CUR_PRODUTO;
  LOOP
    FETCH CUR_PRODUTO BULK COLLECT INTO ROW_PRODUTO LIMIT 50;
    EXIT WHEN ROW_PRODUTO.COUNT = 0;
    FOR I IN 1 .. ROW_PRODUTO.Count LOOP
      DBMS_OUTPUT.PUT_LINE('Código: ' || ROW_PRODUTO(I).COD_PRODUTO || ' Descrição: ' || ROW_PRODUTO(I).DESCRICAO);
    END LOOP;
  END LOOP;
  CLOSE CUR_PRODUTO;
END;
