---------------------------------CURSORES---------------------------------
--Tipo de Cursor  |Descrição
--Implício(Oculto)|Cursores implícitos são delcarados pelo PL/SQL implicitamente para todos os comandos DML(Data Manipulage Language) e
--                | PL/SQL SELECT, incluindo consultas que retornam somente uma linha
---------------------------------------------------------------------------
--Explícito       |Para consultas que retornam mais de uma linha, um cursor explícito pode ser delcarado e nomeado pelo programador e
--                |manipulado através de comandos específicos no bloco PL/SQ
--                |A Vantagem é se sua consulta retorna mais de uma linha ou nenhuma, não retorna erro
--                |Este cursor serve para realizar SELECT
------------------------------------------------------------------
---------------------------------CURSORES EXPLÍCITOS---------------------------------
--Podem processar além da primeira linha retornada pela consulta, linha por linha(Fazer um laço na linha da consulta)
--Mantém o registro da linha que está sendo processada
--Permite ao programador manualmente controlá-los no bloco PL/SQL

---------------------------------CONTROLANDO CURSORES EXPLÍCITOS---------------------------------
--Crie uma áre SQL nomerada:                                  DECLARE
--Identifique o conjunto ativo(result set):                   OPEN
--Carregue a linha atual para variáveis:                      FECTCH
--verifique se ainda existem linhas, execuando um novo FETCH: VAZIO? SIM/NÃO
--Libere o conjunto ativo(result set):                        CLOSE

---------------------------------DECLARANDO O CURSOR---------------------------------
--CURSOR cursor_name IS 
--  select_statemente;
---------------------------------EXEMPLOS---------------------------------
--DECLARE
--  CURSOR c1 IS
--  SELECT id, nome
--    FROM tclientes;
--
--  CURSOR c2 IS
--  SELECT *
--    FROM tcontratos
--   WHERE id = 1000;
--  BEGIN
--...
---------------------------------ABRINDO CURSOR---------------------------------
--OPEN cursor_name;
--Abra o cursor para executar a consulta e identificar o result set, que consiste de todas as linhas que satisfaçam o critério de pesquisa da consulta
--O cursor neste momento aponta para a primeira linha no result set
---------------------------------RECUPERANDO DADOS DO CURSOR---------------------------------
--FETCH cursor_name INTO [variable1, variable2,...] |
--                        record_name];

--O comando FECHT recupera as linhas do result set uma de cada vez
--Após cada FETCH, o cursor avança para a próxima linha no result set

---------------------------------FECHANDO UM CURSOR---------------------------------
--CLOSE cursor_name;
--O Comando CLOSE desabilita o cursor e o result set torna-se idenfinido
---------------------------------ATRIBUTOS DE CURSORES---------------------------------
--Atributo  |Tipo     |Descrição
--%ISOPEN   |Boleano  |Retorna TRUE se o cursor estiver aberto
--%NOTFOUN  |Boelano  |Retorna TRUE se o fetch mais recente não retornou uma linha
--%FOUND    |Boelano  |Retorna TRUE se o fetch mais recente retornou uma linha; contrário de %NOTFOUND
--%ROWCOUNT |Numérico |Retorna o número total de linhas recuperadas até o momento

---------------------------------UTILIZANDO CURSORES EXPLÍCITOS---------------------------------
--DECLARE
--  vId     tclientes.id%TYPE;
--  vNome   tclientes.nome%TYPE;
--  CURSOR c1 IS
--  SELECT id, nome
--    FROM tclientes;
--BEGIN
--  OPEN c1;
--    LOOP
--      FETCH c1 INTO vId, vNome;
--      EXIT WHERE c1%ROWCOUNT > 10 OR c1%NOTFOUND OR
--      c1%NOTFOUNT IS NULL;
--      ...
--    END LOOP;
--  CLOSE c1;
--END;     

--TIPO DE CURSOR com variável
DECLARE
   vcod_aluno TAluno.Cod_Aluno%TYPE; --vcod_aluno do mesmo tipo da coluna cod_aluno da tabela taluno
   vNome   TAluno.nome%TYPE;         --vNome do mesmo tipo da coluna nome da tabela taluno
   CURSOR c1 IS                      --declarando o cursor
     SELECT cod_aluno, nome          --SELECT do cursor
     FROM   taluno;

BEGIN
   OPEN c1;                          --Abrir o cursor
   LOOP                              --Abertura do LOOP
      FETCH c1 INTO vCod_Aluno, vNome; --FETCH irá pegar registro a registro do cursor C1 e inserir nas variáveirs  
      EXIT WHEN c1%ROWCOUNT > 10 OR c1%NOTFOUND;    --A inserção de dados para quando a linha atual foi >= 10 ou quando não existir mais registro
      Dbms_Output.Put_Line('Codigo: '||LPad(vcod_aluno,4,'0')||' - '||'Nome: '||vNome); -- A cada inserção, será impresso os dados
   END LOOP;                         --Fechar LOOP
   CLOSE c1; --fechando cursor
END;



--TIPO DE CURSOR com RECORD
DECLARE
   CURSOR c1 IS                 --criando um cursor com a mesma estrutura da tabela TALUNO
      SELECT * FROM TAluno;
   Reg c1%ROWTYPE;  --criando um RECORD(Reg) do mesmo tipo do cursor, ou seja, contém a mesma estrutura do cursor(c1)
BEGIN
   OPEN c1;                    --Abrindo o cursor
   LOOP                        --Abrindo o LOOP
      FETCH c1 INTO reg;       --Insere os dados do cursor c1 no REGISTRO(RECORD) reg 
      EXIT WHEN c1%ROWCOUNT > 10 OR c1%NOTFOUND; --A inserção de dados para quando a linha atual foi >= 10 ou quando não existir mais registro 
      Dbms_Output.Put_Line('Codigo: '||LPad(reg.cod_aluno,5,'0')||'-'||'Nome: '||reg.nome);    --Impresão dos dados
   END LOOP;    --Fechando o LOOP
   CLOSE c1; -- Fechando o cursor
END;  


--TIPO DE CURSOR COM FOR
DECLARE
  CURSOR c1 IS             --Criando um CURSOR(c1) com a mesma estrutura da tabela TALUNO
    SELECT * FROM TAluno;
  Reg TAluno%ROWTYPE;      --Criando um RECORD(Reg) do mesmo tipo da tabela TALUNO
BEGIN
  FOR reg IN c1  --(open, laço, fetch, close, exit when)
  LOOP            --Abrindo o LOOP
    Dbms_Output.Put_Line('Codigo: '||LPad(reg.cod_aluno,5,'0')||' - ' || 'Nome: '||reg.nome);  --Impresão dos dados

  END LOOP;  --Fechando LOOP
END;


--Exemplo de laço direto em uma tabela
DECLARE
  Reg TALUNO%ROWTYPE; --Record do mesmo tipo da tabela TALUNO
BEGIN
  FOR reg IN (SELECT * FROM TALUNO) --Laço FOR 
  LOOP                              --abertura do LOOP
    Dbms_Output.Put_Line(reg.cod_aluno ||' - ' || reg.nome); --Impressão de dados
  END LOOP;                         --Fechandodo LOOP
END;


---
--Exemplo de CURSOR com parâmetro e FOR com UPDATE
DECLARE
  CURSOR c1 (pCod_aluno NUMBER) IS --Declarando o CURSOR c1 com parâmetros
    SELECT * FROM TAluno
    WHERE Cod_aluno = pCod_aluno
   FOR UPDATE OF NOME NOWAIT;   --Bloquear a coluna NOME para alteração. Enquanto o SELECT estiver rodando, não se pode alterar a coluna NOME;
  
  Reg c1%ROWTYPE;  --RECORD(registro) do tipo do CURSOR c1
BEGIN
  OPEN c1(&codigo); --Variável de substituição. Como o resultado do cursor é um registro, não se precisa fazer um laço. Se não encontrar o registro, não mostra erro
  FETCH c1 INTO reg;                 --FETCH irá buscar os valores do CURSOR c1 e inserir no REGISTRO reg
  Dbms_Output.Put_Line(reg.cod_aluno ||' - ' || reg.nome);
  CLOSE c1; --libera o registro para alteracao
END;
--


--Exemplo de FOR UPDATE
DECLARE
   CURSOR c1 IS            --Declarando o CURSOR c1 com os mesmos dados da tabela TALUNO
     SELECT * FROM TALUNO
     FOR UPDATE;           --FOR UPDATE para bloquear o registro sempre que o laço passar por cada linha
   Reg_aluno c1%ROWTYPE;    --Declarando RECORD do mesmo tipo do CURSO c1
BEGIN
   FOR reg_aluno IN c1   --Laço na tabela
   LOOP
      UPDATE TALUNO      --UPDATE para formatar o nome
      SET    nome = InitCap(reg_aluno.nome)  --INITCAP para deixar a primeira letra maíscula
      WHERE CURRENT OF c1;  --bloqueia somente o reg atual
      Dbms_Output.Put_Line('Nome: '||InitCap(reg_aluno.nome)); --impressão de dados
   END LOOP;
   COMMIT;
END;
         
SELECT * FROM TALUNO