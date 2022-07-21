--------------------------------------------------PACKAGES--------------------------------------------------

--Uma package possui uma especificação(package specification) e um corpo(package body) armazenados separadamente no banco de dados
--Desenvolva packages de banco de dados para agrupar objetos PL/SQL(identificadores e rotinas)
--Crie uma package em duas partes: Package specficiation e package body
--------------------------------------------------
--Construções  | Descrição 
--VARIÁVEL     | Identificador que pode ter valores alterados
--CURSOR       | Identificador associado a um comando SELECT
--CONSTANTE    | Identificador com um valor fixo
--EXCEPTION    | Identificador para uma condição anormal
--PROCEDURE    | Subrotina com argumentos (parâmetros)
--FUNCTION     | Subrotina com argumentos (parâmetros) que retorna obrigatoriamente um valor

--------------------------------------------------CONSTRUÇÕES PÚBLICAS EM PACKAGES--------------------------------------------------
--Consruções públicas em uma package são aquelas que podem ser invocadas por procedimentos ou funções externas a package
--Devem ser declaradas na Package Specification e definidas no Package Body

--------------------------------------------------CONSTRUÇÕES PRIVADAS EM PACKAGES--------------------------------------------------
--Construções privadas em uma package são aquelas que só podems er invocadas por procedimentos ou funções da própria package
--Devem ser declaradas e definidas no package body

--------------------------------------------------CRIANDO PACKAGE SPECIFICATION--------------------------------------------------
-- CREATE OR REPLACE PACKAGE nome_package
--  IS | AS
--  Declaração de variável;     --Público
--  Declaração de cursor;       --Público
--  Declaração de PROCEDURE; --Público 
--  Decaração de FUNCTION;        --Público
--  END nome_package;           --Público
--------------------------------------------------CRIANDO PACKAGE BODY--------------------------------------------------
--CREATE OR REPLACE PACKAGE BODY nome_package
--  IS | AS
--  Declaração de variável;     --Privado
--  Declaração de cursor;       --Privado
--  Declaração de EXCEPTION     --Privado
--  Declaração e definição de PROCEDURE;    --Privado 
--  Declaração e definição de FUNCTION;      --Privado
--  END nome_package;           

--------------------------------------------------INVOCANDO CONSTRUÇÕES DE PACKAGES--------------------------------------------------
--Invoque uma construção de uma package a partar de uma construção da própria package simplesmente invocando seu nome(PROCEDURE ou FUNCTION) ou identificador
--  (variáveis, curosres, constantes ou EXECPTION), sem prefixos
--Construções externas a package, prefixe o nome da construção com o nome da package
--Exemplo:  EXECUTE pck_cursos.aumenta_preco(47)

--------------------------------------------------BENEFÍCIOS DO USO DE PACKAGE --------------------------------------------------
--Modularização do desenvolvimento da aplicação
--Organizaçção de procedimentos e funções de banco de dados
--Gerenciamento de Segurança
--Possibilita a criação de identificadores globais que podem ser referenciados durante a sessão
--Performance
--------------------------------------------------GERENCIANDO DEPENDÊNCIAS EM PACKAGES--------------------------------------------------
--Se o Package Body da package referenciada é alterado, e a Package Specification não é alterada, a procedure ou a função que referncia a package não é invalidada
--Se o Package Specification da apckage referenciada é alterada, então a procedure ou a função que referencia a package é invalidade, assim como o Package Body da package alterada

--------------------------------------------------RECOMPILANDO PACKAGE--------------------------------------------------
--ALTER PACKAGE nome_package COMPILE;
--ALTER PACKAGE nome_package COMPILE SPECIFICATION;
--ALTER PACJAGE nome_package COMPILE BODY;
--Não é necessário re-compilar a Package Specification quando re-compilando o Package Body e vice-versa


--Especificação ou declaração
CREATE OR REPLACE PACKAGE PKG_ALUNO
IS
  vCIDADE VARCHAR2(30);  --Variaveis publicas
  vMedia NUMBER(8,2);    --Variaveis publicas
  vNOME VARCHAR2(30);    --Variaveis publicas
  PROCEDURE DELETA_ALUNO(pCOD_ALUNO NUMBER);   --Procedure pública
  PROCEDURE MEDIA_CONTRATOS;                   --Procedure pública
  PROCEDURE CON_ALUNO(pCOD_ALUNO NUMBER);      --Procedure pública
END;
/
---------
--PACKAGE BODY
CREATE OR REPLACE PACKAGE BODY PKG_ALUNO --Corpo
IS
 --variaveis locais
 vTESTE VARCHAR(20);
 --PROCEDURE MEDIA_CONTRATOS executa apenas a média de valor para a tabela TCONTRATO
 PROCEDURE MEDIA_CONTRATOS
 IS
 BEGIN
   vTESTE := 'teste';    --Variável pública delcarada em package specification, passando o valor 'teste'
   SELECT Avg(total) INTO vMEDIA FROM tcontrato;
 END;
 --PROCEDURE COD_ALUNO traz o nome do aluno
 PROCEDURE CON_ALUNO(pCOD_ALUNO NUMBER)
 IS
 BEGIN
   vNOME := ''; --Variável pública delcarada em package specification
   SELECT NOME INTO vNOME FROM TALUNO
   WHERE COD_ALUNO=pCOD_ALUNO;

--Exception criada para caso o aluno informado não exista na tabela TALUNO 
 EXCEPTION 
   WHEN No_Data_Found THEN
     Dbms_Output.Put_Line('Aluno não existe');
 END;

 --PROCEDURE DELETA_ALUNO irá verificar se o nome do aluno digitado exista na tabela TALUNO, conforme PROCEDURE CON_ALUNO.
 -- Se existir, irá realizar o delete na tabela TALUNO
 PROCEDURE DELETA_ALUNO(pCOD_ALUNO NUMBER)
 IS
 BEGIN
  CON_ALUNO(pCOD_ALUNO);
  IF Length(vNOME) > 0 THEN
    DELETE FROM TALUNO WHERE COD_ALUNO = pCOD_ALUNO;
    Dbms_Output.Put_Line(vNOME||'->Excluido');
  END IF;
 END;

END;
--FIM do package


--UTILIZANDO A PACKAGE
EXEC PKG_ALUNO.DELETA_ALUNO(62);

SELECT * FROM TALUNO;




--
DECLARE
  m NUMBER; --variável local
BEGIN
  pkg_aluno.media_contratos; --executa a procedure  da package
  m := pkg_aluno.vMedia;  --Recebe o valor da variável pública dentro da package specification
  Dbms_Output.Put_Line('Média: '||m);
END;



--
DECLARE
  nome VARCHAR(30);
BEGIN
  pkg_aluno.con_aluno(2); --executa a procedure do package
  nome := pkg_aluno.vnome; --Variável vnome declarada na package;
  Dbms_Output.Put_Line('Nome '||nome);
END;


--
BEGIN
  pkg_aluno.con_aluno(1); --executa a procedure
  IF (pkg_aluno.vnome <> '') THEN
    Dbms_Output.Put_Line('Nome '||pkg_aluno.vnome);
  END IF;
END;