--Cria��o de Sequencias
-- Automaticamente gera n�meros �nicos;
-- � um objeto compartilhado;
-- � normalmente utilizada para criar valores para as chaves prim�rias;
-- Substitui c�digo de aplica��o

--CREATE SEQUENCE name_sequence
--[INCREMENTE BY] n --Quanto quer que incremente;
--[START WITH n] --Valor inicial para come�ar;
--[{MAXVALUE n | NOMAXVALUE}]--Valor maximo que a sequencia pode ter;
--[{MINVALUE n | NOMINVALUE}]-- Valor minimo que a sequencia pode ter;
--[{CYCLE | NOCYCLE }]-- Propriedade que permite a reinicializa��o ou n�o-reinicializa��o
--[{CACHE n |NOCACHE }]; --Mant�m para cada sess�o, uma faixa de padr�o 20. Pode acontecer de ao realizar insert, o sequence pular 20 sequencias, ou seja, pode sair fora da ordem;
--Pode-se se por um cache maior, por�m o padr�o � 20;

-- Criando sequencial
CREATE SEQUENCE SEQ_ALUNO1
START WITH 60    --Valor Inicial
INCREMENT BY 2   --Qtde a Incrementar
MINVALUE 60      --Valor Minimo
MAXVALUE 100     --Valor Maximo
NOCACHE          --nao guarda em cache faixa de valores -- Padr�o: 20
NOCYCLE;         --n�o tem um ciclo
--
--
INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 1');
--Proximo Value

INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 2');


SELECT * FROM TALUNO;
COMMIT;

--Sequencias criadas pelo usu�rio logado no banco
SELECT * FROM USER_SEQUENCES;

--Verifica Valor Atual da sequencia
SELECT SEQ_ALUNO1.CURRVAL FROM DUAL;

--Altera��o de algum par�metro
ALTER SEQUENCE SEQ_ALUNO1 MAXVALUE  500;

--Alterar Valor da Sequencia
--Uma sequencia n�o se altera o valor atual dela, para realizar este processo, deve-se apagar a sequencia e criar de novo com o valor desejado
DROP SEQUENCE SEQ_ALUNO1;
CREATE SEQUENCE SEQ_ALUNO1 START WITH 80;



-------------------------------INDICES Secundario-------------------------------

--Chave primaria � considerado indice prim�rio;

--Indices Secundario
SELECT NOME FROM TALUNO
WHERE NOME LIKE '%A%';    --Pressionar F9 ele mostra o plano de execu��o do select
--Table access(Full) -> verifica toda a tabela
--�ndice de tabela trabalha de maneira similar ao �ndice de um livro;
--TABLE ACCESS (FULL) of "TALUNO" #1 TABLE Optimizer=ANALYZED(Cost=3 Card=1 bytes=7) -> Sem o �ndice o custo deste select � 3

--Criando um �ndice
--CREATE INDEX [nome_�ndice] ON [table_name(Coluna_Req)]; 
CREATE INDEX IND_TALUNO_NOME ON TALUNO(NOME);

--Ap�s a cria��o do ind�ce, o resultado foi:
--INDEX (FULL SCAN) of "IND_TALUNO_NOME" INDEX Optimizer=ANALYZED(Cost=1 Card=1 bytes=7) -> Com o �ndice o custo deste select � 1

--Outro Exemplo
SELECT nome,cidade FROM TALUNO
WHERE NOME LIKE '%A%' AND CIDADE LIKE '%A%';

-- Criando �ndice para as duas colunas (NOME, CIDADE)
CREATE INDEX IND_TALU_NOMECIDADE
ON TALUNO(NOME, CIDADE);

--Cria��o de ind�ce melhora a performace de consulta, por�m os comandos (DML - INSERTI; UPDATE; DELETE) ficaram lentos pois,
--sempre que um comando deste tipo for executado, ser� necess�rio atualizar todos os �ndices criados para a tabela

--Verificar todos os �ndices criados pelo usu�rio
SELECT * FROM USER_INDEXES;

--Drop �ndice
DROP INDEX IND_TALU_NOMECIDADE;


--Sinonimos
--Caso uma tabela contem um nome muito dif�cil de ser utilizado na programa��o, pode-se criar um sin�nimo, ou seja, um apelido para facilitar
--Sin�nimo nada mais � que um apelido para um objeto

--CREATE SYNONYM [nome_sin�nimo] FOR [table_name];
CREATE SYNONYM ALU FOR TALUNO;

--SELECT NO SIN�NIIMO
SELECT * FROM ALU;

