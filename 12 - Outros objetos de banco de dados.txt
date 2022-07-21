--Criação de Sequencias
-- Automaticamente gera números únicos;
-- É um objeto compartilhado;
-- É normalmente utilizada para criar valores para as chaves primárias;
-- Substitui código de aplicação

--CREATE SEQUENCE name_sequence
--[INCREMENTE BY] n --Quanto quer que incremente;
--[START WITH n] --Valor inicial para começar;
--[{MAXVALUE n | NOMAXVALUE}]--Valor maximo que a sequencia pode ter;
--[{MINVALUE n | NOMINVALUE}]-- Valor minimo que a sequencia pode ter;
--[{CYCLE | NOCYCLE }]-- Propriedade que permite a reinicialização ou não-reinicialização
--[{CACHE n |NOCACHE }]; --Mantém para cada sessão, uma faixa de padrão 20. Pode acontecer de ao realizar insert, o sequence pular 20 sequencias, ou seja, pode sair fora da ordem;
--Pode-se se por um cache maior, porém o padrão é 20;

-- Criando sequencial
CREATE SEQUENCE SEQ_ALUNO1
START WITH 60    --Valor Inicial
INCREMENT BY 2   --Qtde a Incrementar
MINVALUE 60      --Valor Minimo
MAXVALUE 100     --Valor Maximo
NOCACHE          --nao guarda em cache faixa de valores -- Padrão: 20
NOCYCLE;         --não tem um ciclo
--
--
INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 1');
--Proximo Value

INSERT INTO TAluno (Cod_Aluno, Nome)
VALUES (Seq_Aluno1.NEXTVAL,'MASTER TRAINING 2');


SELECT * FROM TALUNO;
COMMIT;

--Sequencias criadas pelo usuário logado no banco
SELECT * FROM USER_SEQUENCES;

--Verifica Valor Atual da sequencia
SELECT SEQ_ALUNO1.CURRVAL FROM DUAL;

--Alteração de algum parâmetro
ALTER SEQUENCE SEQ_ALUNO1 MAXVALUE  500;

--Alterar Valor da Sequencia
--Uma sequencia não se altera o valor atual dela, para realizar este processo, deve-se apagar a sequencia e criar de novo com o valor desejado
DROP SEQUENCE SEQ_ALUNO1;
CREATE SEQUENCE SEQ_ALUNO1 START WITH 80;



-------------------------------INDICES Secundario-------------------------------

--Chave primaria é considerado indice primário;

--Indices Secundario
SELECT NOME FROM TALUNO
WHERE NOME LIKE '%A%';    --Pressionar F9 ele mostra o plano de execução do select
--Table access(Full) -> verifica toda a tabela
--Índice de tabela trabalha de maneira similar ao índice de um livro;
--TABLE ACCESS (FULL) of "TALUNO" #1 TABLE Optimizer=ANALYZED(Cost=3 Card=1 bytes=7) -> Sem o índice o custo deste select é 3

--Criando um índice
--CREATE INDEX [nome_índice] ON [table_name(Coluna_Req)]; 
CREATE INDEX IND_TALUNO_NOME ON TALUNO(NOME);

--Após a criação do indíce, o resultado foi:
--INDEX (FULL SCAN) of "IND_TALUNO_NOME" INDEX Optimizer=ANALYZED(Cost=1 Card=1 bytes=7) -> Com o índice o custo deste select é 1

--Outro Exemplo
SELECT nome,cidade FROM TALUNO
WHERE NOME LIKE '%A%' AND CIDADE LIKE '%A%';

-- Criando índice para as duas colunas (NOME, CIDADE)
CREATE INDEX IND_TALU_NOMECIDADE
ON TALUNO(NOME, CIDADE);

--Criação de indíce melhora a performace de consulta, porém os comandos (DML - INSERTI; UPDATE; DELETE) ficaram lentos pois,
--sempre que um comando deste tipo for executado, será necessário atualizar todos os índices criados para a tabela

--Verificar todos os índices criados pelo usuário
SELECT * FROM USER_INDEXES;

--Drop índice
DROP INDEX IND_TALU_NOMECIDADE;


--Sinonimos
--Caso uma tabela contem um nome muito difícil de ser utilizado na programação, pode-se criar um sinônimo, ou seja, um apelido para facilitar
--Sinônimo nada mais é que um apelido para um objeto

--CREATE SYNONYM [nome_sinônimo] FOR [table_name];
CREATE SYNONYM ALU FOR TALUNO;

--SELECT NO SINÔNIIMO
SELECT * FROM ALU;

