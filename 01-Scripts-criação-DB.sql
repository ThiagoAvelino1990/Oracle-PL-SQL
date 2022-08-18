/*****************************************************************
*****************Criação de tablespace para dados*****************
*****************************************************************/


--Comando para criar uma tablespace do banco de dados(Espaço para tabelas e objetos)
create tablespace tbs_dados 													--tbs_dados é o nome da tablespace
datafile 'C:\oraclexe\app\oracle\oradata\tbd_dados.dbf' size 100M reuse			--local aonde ficará a tablespace(local de instalação do Oracle XE) e o seu tamanho inicial definido de 100MB	
autoextend on next 10M maxsize 200M 											--aumentar 10MB e se passar de 100MBe no máximo 200MB
online;

--Cria usuario (dono das tabelas)
create user aluno                                                               --criação de usuário do banco
identified by "123"                                                             --identificação a senha
default tablespace tbs_dados                                                    --definindo a tablespace do usuário criado    
temporary tablespace temp;  

--Cria e define a "role" de privilegios (perfil)
create role perfil_desenv;

--Comando para atribuir permissões a "role"(perfil) criado
grant
create cluster,
create database link,
create procedure,
create session,
create sequence,
create synonym,
create table,
create any type,
create trigger,
create view
to perfil_desenv;

--Comando para alterar sessão no banco
grant alter session to perfil_desenv;

--Comando para dar permissão direto ao usuário de banco
grant create trigger to aluno;

--Comando para atribuir todas as permissões do perfil ao usuário
grant perfil_desenv to aluno;

--Comando para atribuir a permissão do usuário de banco a preencher toda a tablespace criada
grant unlimited tablespace to aluno;

--Comando para exclusão(dropar) a tablespace criada
--drop tablespace tbs_dados;