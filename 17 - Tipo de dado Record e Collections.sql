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

DECLARE
  reg TAluno%ROWTYPE;  --Record do mesmo tipo da tabela TALUNO

BEGIN
  SELECT COD_ALUNO, NOME, CIDADE, CEP, SALARIO
  INTO Reg.cod_aluno, Reg.nome, Reg.cidade, Reg.cep, reg.salario
  FROM TALUNO
  WHERE COD_ALUNO = 1;                    

  Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
  Dbms_Output.Put_Line('Nome  : ' ||reg.nome);
  Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
  Dbms_Output.Put_Line('Cep   : ' ||reg.cep);
  dbms_output.Put_line('Salario: '||reg.salario);
END;


            

--
DECLARE
  TYPE T_ALUNO IS TABLE OF TALUNO.NOME%TYPE --IS TABLE OF indica que será uma matriz. Record do tio nome da tabela TALUNO
  INDEX BY BINARY_INTEGER; --O acesso ao elementos será através de um número inteiro

  REGISTRO T_ALUNO; --Record
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




--
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
  TYPE sigla IS TABLE OF VARCHAR2(30) INDEX BY VARCHAR2(2); --O acesso será através de um VARCHAR2 com (2) caracteres;
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
  nome_vetor.EXTEND; --Posso fazer a extensão apenas até o limite de 5
  nome_vetor(1) := 'Master';
  Dbms_Output.Put_Line(nome_vetor(1));
END;




