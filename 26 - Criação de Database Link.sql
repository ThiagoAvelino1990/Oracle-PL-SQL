------------------------DATABASE LINKS------------------------
--Database link serve para realizar acesso remoto de dados. No Oracle o acesso remoto de dados, como por exmeplo, 
--  consultas e atualizações em bases remotas estão disponíveis através dos chamados database links
--Os database links possibilitam que os usuários tratem um grupo de bases distribuídas como se gfosse um único banco de dados integrado
--O database link especifica as seguintes informações da conexão:
--  O protocolo de comunicação a ser utilizado durante a conexão(TCP/ IP)
--  A máquina na qual o banco de dados remoto se encontra
--  O nome do banco de dados remoto
--  O nome de um usuário válido no banco de dados remoto
--  A senha do usuário

------------------------UTILIZANDO O DATABASE LINKS------------------------
--O Oracle realiza a conexão ao banco de dados remoto utilizando o nome do usuário e senha definidos na criação do link
--Com o database link e os provilégios necessários, é possível utilizar comandos:
--  SELECT, INSERT, UPDATE, DELETE sobre os objetos desejados do banco de dados remoto

------------------------
------------------------
--Para este exercício, acessar o banco com o usuário system e criar o databselink

--Criando um database link
CREATE DATABASE LINK curso_link
CONNECT TO aluno     --usuario
IDENTIFIED BY "123"   --senha do usuario
USING 'xe'            --tns (sid)

--Derrubar o link
--DROP DATABASE LINK curso_link;

--TNS

SELECT * FROM TALUNO@curso_link                                                           


SELECT * FROM TCONTRATO@curso_link