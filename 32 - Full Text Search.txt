--Oracle Text

--O Oracle Text é uma feature embutida no banco de dados que utiliza a linguagem SQL para indexar, 
--  pesquisar e analisar textos e documentos binários armazenados nas tabelas. 
--  Nas versões Oracle 11g essa feature é conhecida como Oracle Text. 
--  Esta tecnologia oferece uma solução completa para pesquisa de textos na qual a mesma permite 
--  filtrar e extrair textos de conteúdos de diferentes formatos de documentos. 
--  O Oracle Text suporta mais de 150 formatos de documentos, incluindo os mais populares 
--  como os documentos Microsoft Office, além de formatos de arquivo do Adobe PDF, arquivos HTML e XML. 
--  Neste artigo irei demonstrar como gravar um documento binário (.doc) no banco de dados Oracle 11g e o que fazer para poder realizar pesquisas no seu conteúdo. 

--O arquivo que irei carregar para o banco de dados (teste.doc) possui o conteúdo "Marcio Konrath Curso de Oracle" para isto abra arquivo em branco do microsoft word e escreva o texto mencinado ou algum outro texto qualquer e salva na pasta C:\Temp com nome de "arquivo.doc"

--Em seguida abra o CMD como administrador e conecte no SQLPLUS 

--C:\set ORACLE_SID=curso

--C:\>sqlplus sys/123 as sysdba

 

 

-- Criação de um diretório que indica a localização do documento

--Conectado como usuario SYSTEM(DIRECTORY é um objeto que aponta para uma pasta, sempre que direcionar a leitura ou criação de um arquivo, será direcionado para o diretório)
--grant create any directory to ALUNO;

--Conectado como usuario normal 
create or replace directory arquivos as 'C:\Temp';
 

--Agora conectado como usuário normal de desenvolvimento no SQL Developer vamos criar uma tabela
--DROP TABLE TESTE
create table teste (
  codigo number,
  nome varchar2(40),
  documento blob
);

--Criando Sequencia
create sequence seq_doc start with 10;


-- Criação de uma procedure para carregar o arquivo para o banco de dados

create or replace procedure grava_arquivo (p_file_name in VARCHAR2) --Parâmetro com o nome do arquivo
as
  v_bfile bfile;
  v_blob blob;
begin
  insert into teste (codigo,nome,documento)
  values (seq_doc.nextval,p_file_name,empty_blob())
  return documento into v_blob;
  -- Informação de directory tem que ser maiusculo 
  v_bfile := bfilename('ARQUIVOS',p_file_name);
  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);  --fileopen abre o aquivo   
  dbms_lob.loadfromfile(v_blob,v_bfile,dbms_lob.getlength(v_bfile)); -- loadfromfile abre do arquivo
  dbms_lob.fileclose(v_bfile); -- fileclose fecha o arquivo
  commit;
end;
-- Grava o arquivo para a tabela 

execute grava_arquivo('arquivo.doc');
 

--Para testar se gravou o registro faça select na tabela

Select * from teste;

--Verificar o tamanho do arquivo gravado
Select dbms_lob.getlength(documento) bytes from teste;


--Vamos criar índice que vai permitir pesquisar dentro deste arquivo grava na tabela
-- 
create index ind_teste_doc on teste (documento) indextype is ctxsys.context parameters ('sync (on commit)');



--Para verificar se houve erro na criação do índice
select * from ctx_user_index_errors;


--Podemos verificar que foram criados alguns índices adicionais usando o selects abaixo
select table_name from user_tables;
select index_name,table_name from user_indexes;


--Fazendo pesquisar no documento gravando na tabela
select codigo, nome from teste where contains(documento, 'Marcio', 1) > 0;

select codigo,nome from teste where contains(documento, 'Roma', 1) > 0;


--Limpar o registro
UPDATE TESTE SET DOCUMENTO = NULL
