-----------------Manipulando XML-----------------
-----------------PL/SQL E XML-----------------

--A XML (Extensible Markup Language) � uma linguagem de marca��o de prop�sito geral. 
--  Ela permite compartilhar dados estruturados na Internet e pode ser usada para codificar dados e outros documentos. A XML apresenta as seguintes vantagens: 
-- Pode ser lida por seres humanos e computadores e � armazenada como texto puro
-- � independente de plataforma
-- Suporta Unicode, o que significa que ela pode armazenar informa��es escritas em muitos idiomas
-- Usa um formato autodocumentado que cont�m a estrutura do documento, nomes de elemento e valores de elemento. Por causa dessas vantagens, a XML � muito usada para armazenamento e processamento de documentos, sendo aplicada por muitas organiza��es para o envio de dados entre seus sistemas de computador. 
--  Por exemplo, muitos fornecedores permitem que seus clientes enviem pedidos de compra como arquivos XML pela Internet.

-----------------GERANDO C�DIGO XML A PARTIR DE DADOS RELACIONAIS-----------------

--O banco de dados Oracle cont�m v�rias fun��es SQL que podem ser usadas para gerar c�digo XML e, nesta se��o, voc� vai ver como gerar c�digo XML a partir de dados relacionais utilizando algumas dessas fun��es.
--A fun��o XMLELEMENT() � usada para gerar elementos XML a partir de dados relacionais. Voc� fornece um nome para o elemento e a coluna que deseja recuperar para a fun��o XMLELEMENT() e ela retorna os elementos como objetos XMLType. 
--  XMLType � um tipo interno do banco de dados Oracle utilizado para representar dados XML. Por padr�o, um objeto XMLType armazena os dados XML como texto em um CLOB (Character Large Object). O exemplo a seguir se conecta no SQL Developer com usu�rio de desenvolvimento e usa objetos XMLType. 

--CONNECT store/store_password 
SELECT XMLELEMENT("cod_aluno", cod_aluno)
AS aluno
FROM taluno;
----------------------------
ALUNO
----------------------------
<cod_aluno>1</cod_aluno>
<cod_aluno>2</cod_aluno>
<cod_aluno>3</cod_aluno>
<cod_aluno>4</cod_aluno>
<cod_aluno>5</cod_aluno>

--Conforme voc� pode ver a partir desses resultados, XMLELEMENT ("cod_aluno", cod_aluno) retorna os valores de cod_aluno dentro de uma tag cod_aluno. Voc� pode usar o
--  nome de tag que desejar, como mostrado no exemplo a seguir, que utiliza a tag "cod_alu":
SELECT XMLELEMENT("cod_alu", cod_aluno)
AS aluno
FROM TAluno;
----------------------------
ALUNO
----------------------------
<cod_alu>1</cod_alu>
<cod_alu>2</cod_alu>
<cod_alu>3</cod_alu>
<cod_alu>4</cod_alu>
<cod_alu>5</cod_alu>

--O exemplo a seguir obt�m os valores de nome e cidade do aluno n� 2: 
SELECT XMLELEMENT("nome", nome) || XMLELEMENT("cidade", cidade)
AS alunos
FROM taluno
WHERE cod_aluno = 2;
-----------------------------------------------------
ALUNOS
-----------------------------------------------------
<nome>Paula</nome><cidade>CANOAS</cidade>


--O exemplo a seguir incorpora duas chamadas de XMLELEMENT() dentro de uma chamada externa de XMLELEMENT(). Observe que os elementos cod_aluno e nome retornados est�o contidos dentro de um elemento customer externo: 
SELECT XMLELEMENT("aluno",XMLELEMENT("cod_aluno", cod_aluno),XMLELEMENT("nome", nome))AS alunos 
 FROM TAluno
WHERE cod_aluno IN (1, 2);
------------------------------
ALUNOS
------------------------------
<aluno>
<cod_aluno>1</cod_aluno>
<nome>PEDRO</nome>
</aluno>
<aluno>
<cod_aluno>2</cod_aluno>
<nome>MARCIO</nome>
</aluno >
--OBS: Algumas quebras de linhas e espa�os foram adicionados no c�digo XML retornado por essa consulta para torn�-lo mais f�cil de ler. 
--  O mesmo foi feito em alguns dos outros exemplos deste cap�tulo. 

--  Voc� pode recuperar dados relacionais normais, assim como c�digo XML, conforme mostrado no exemplo a seguir, que recupera a coluna cod_aluno como um resultado relacional normal e as colunas nome e cidade concatenadas como elementos XML:
SELECT cod_aluno, XMLELEMENT("aluno", nome) AS aluno
FROM TAluno;
COD_ALUNO ALUNO
----------- ----------------------------------
1 <aluno>PEDRO</aluno>
2 <aluno>MARCIO</aluno>


--Voc� usa XMLFOREST() para gerar uma �floresta� de elementos XML. 
--  XMLFOREST() concatena elementos XML sem que voc� precise usar o operador de concatena��o || com v�rias chamadas de XMLELEMENT(). 
--  O exemplo a seguir usa XMLFOREST() para obter cod_aluno, nome e cidade dos alunos n� 1 e 2:

SELECT 
    XMLELEMENT("aluno", XMLFOREST( cod_aluno AS "cod", nome AS "nomealuno",cidade AS "dob") ) AS aluno
FROM taluno
WHERE cod_aluno IN (1, 2);
ALUNO
-----------------------------
<aluno>
<id>1</id>
<nome>PEDRO</nome>
<cidade>PORTO ALEGRE</cidade>
</aluno>
<aluno>
<id>2</id>
<nome>MARCIO</nome>
<cidade>NOVO HAMBURGO</cidade>
</aluno>


--A consulta a seguir coloca o nome do cliente dentro da tag de elemento aluno usado
--XMLATTRIBUTES():

SELECT 
    XMLELEMENT("aluno", XMLATTRIBUTES(nome AS "nome"), 
                XMLFOREST(cidade AS "cidade", estado as "estado"))AS xml_aluno
FROM TAluno
WHERE cod_aluno IN (1, 2);
XML_ALUNO
-------------------------------
<aluno nome="PEDRO">
<cidade>PORTO ALEGRE</cidade>
<estado>RS</estado>
</aluno>
<aluno nome="MARCIO">
<cidade>NOVO HAMBURGO</cidade>
<estado>02/05/1968</estado>
</aluno>

-------------------------------------------
--------------------XML--------------------
-------------------------------------------
--XMLELEMENT(TAG,COLUNA_REQUERIDA)
--XMLTYPE
SELECT XMLELEMENT("cod_aluno", cod_aluno) AS Aluno
FROM taluno;

--XMLELEMENT concatenado
--XMLELEMENT(TAG,COLUNA_REQUERIDA)||XMLELEMENT(TAG,COLUNA_REQUERIDA)
SELECT XMLELEMENT("Nome", Nome) || XMLELEMENT("Cidade", cidade)AS Aluno
FROM taluno;

--XMLELEMENT
--Com as barras || os dados aparecem na sa�da
SELECT XMLELEMENT("DataContrato", TO_CHAR(data, 'MM/DD/YYYY'))||''AS Data_Contrato
FROM tcontrato;

--XMLELEMENT(TAG, XMLELEMENT(TAG, COLUNA_REQUERIDA))
SELECT XMLELEMENT("Aluno",XMLELEMENT("cod_aluno", cod_aluno),
       XMLELEMENT("nome", nome))||'' AS aluno
FROM taluno;


-------------------------------
--XMLELEMENT(TAG, XMLATTRIBUTES(coluna_requerida(atributo) as "NOME_ATRIBUTO"))
SELECT XMLELEMENT("Aluno", XMLATTRIBUTES(cod_aluno AS "COD_ALUNO",nome as "NOME_ALUNO", cidade AS "CIDADE" ))||''AS Aluno
FROM taluno;

-------------------------------
--XMLELEMENT(TAG, XMLFOREST(COLUNA_REQUERIDA AS "TAG"))
SELECT XMLELEMENT("Aluno", XMLFOREST( cod_aluno AS "codigo", nome AS "nome", cidade as "cidade"))||''AS Aluno
FROM TAluno;

-------------------------------
--Caso queria que o nome da TAG seja o mesmo nome da coluna da tabela, basta fazer conforme exemplo abaixo
--XMLELEMENT(TAG, XMLFOREST(COLUNA_REQUERIDA,COLUNA_REQUERIDA,...))
SELECT XMLELEMENT("Aluno",XMLFOREST(cod_aluno,nome,cidade))||''AS Aluno
    FROM taluno;
    
-------------------------------
--XMLELEMENT(TAG,(XMLATTRIBUTES)COLUNA_REQUERIDA AS "TAG"),XMLFOREST(COLUNA_REQUERIDA AS "TAG",...)
SELECT XMLELEMENT("Aluno",
XMLATTRIBUTES(cod_aluno as "cod_aluno"),
XMLFOREST(nome AS "nome", cidade AS "cidade", cep AS "cep") 
)||''AS aluno
FROM TALUNO;
------------------------
--XMLELEMENT(TAG,(XMLATTRIBUTES)COLUNA_REQUERIDA),XMLFOREST(COLUNA_REQUERIDA,...)
SELECT XMLELEMENT("Aluno",
       XMLATTRIBUTES(cod_aluno),
       XMLFOREST(nome, cidade, cep))||''AS aluno
FROM TALUNO
;

------------------------
SELECT XMLPARSE(CONTENT'<TAluno><nome>M�rcio Konrath</nome></TAluno>'WELLFORMED)||'' AS ALUNO
FROM dual;


--Criando arquivo XML a partir de tabela

--Primeiramente temos que configurar o Oracle para aceitar criar arquivos
--Abra o CMD como Administrador 
set ORACLE_SID=xe
--
CONNECT SYS/123 AS SYSDBA

--Fechar o banco de dados 
SHUTDOWN IMMEDIATE;

--Iniciar o banco de dos sem abrir 
STARTUP MOUNT;

--Alterar o par�metro UTL_FILE_DIR: 
ALTER SYSTEM SET UTL_FILE_DIR = '*' SCOPE = SPFILE;

--Fechar novamente o banco 
SHUTDOWN IMMEDIATE;

--Abrir o banco 
STARTUP;

--Verificar se o par�metro foi alterado 
SHOW PARAMETER UTL_FILE_DIR;

--Dar privilegio para qualquer usu�rio para trabalhar com UTL_FILE
GRANT EXECUTE ON UTL_FILE TO PUBLIC;

SELECT * FROM ALL_OBJECTS
 WHERE OBJECT_TYPE = 'DIRECTORY'

--Conectar novamente ao usu�rio no SQL Developer
--Gerando arquivo xml
DECLARE
  p_directory VARCHAR2(100) := 'DIRETORIO'; --Diret�rio do arquivo
  p_file_name VARCHAR2(50) := 'arquivo.xml'; --Nome do arquivo
  v_file UTL_FILE.FILE_TYPE; --
  v_amount INTEGER:= 32767; -- Tamanho do arquivo
  v_xml_data XMLType;
  v_xml clob; -- CLOB, texto do arquivo
  v_char_buffer VARCHAR2(32767); -- Tamanho m�ximo que pode usar
BEGIN
  -- abre o arquivo para gravar o texto (at� v_amount
  -- caracteres por vez)
  v_file:= UTL_FILE.FOPEN(P_DIRECTORY,p_file_name,'w', v_amount); --Abrir um arquivo para escrever(W)
  -- grava a linha inicial em v_file
  UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0"?>'); -- Gravar o cabe�alho do XML
  -- recupera os alunos e os armazena em v_xml_data
  SELECT XMLELEMENT(
  "Aluno",
  XMLFOREST(
  cod_aluno AS "codigo",
  nome AS "nome"
  ))AS Aluno
  INTO v_xml_data
  from taluno where cod_aluno = 1; 
 
  -- obt�m o valor da string de v_xml_data e o armazena em v_char_buffer
  v_char_buffer:= v_xml_data.GETSTRINGVAL();
  -- copia os caracteres de v_char_buffer no arquivo
  UTL_FILE.PUT(v_file, v_char_buffer);
  -- descarrega os dados restantes no arquivo
  UTL_FILE.FFLUSH(v_file);
  -- fecha o arquivo
  UTL_FILE.FCLOSE(v_file);
end;


--Lendo arquivo
DECLARE
  arq_leitura UTL_File.File_Type;
  Linha Varchar2(250);
BEGIN
  arq_leitura := UTL_File.Fopen('DIRETORIO','arquivo.xml', 'r');
  Dbms_Output.Put_Line('Processamento');
  Loop
    UTL_File.Get_Line(arq_leitura, Linha);
    DBMS_OUTPUT.PUT('Linha XML: '||Linha);
    exit;
  End Loop;
  UTL_File.Fclose(arq_leitura);
  Dbms_Output.Put_Line('Arquivo processado com sucesso.');
EXCEPTION
  WHEN No_data_found THEN
    UTL_File.Fclose(arq_leitura);
    Commit;
  WHEN UTL_FILE.INVALID_PATH THEN
    Dbms_Output.Put_Line('Diret�rio inv�lido.');
    UTL_File.Fclose(arq_leitura);
  WHEN Others THEN
  Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
  UTL_File.Fclose(arq_leitura);
END;