--Comando MERGE serve para fazer atualização de uma tabela, buscando os registros de várias tabelas
--A primeiro momento, se não existe registro na tabela alvo, o MERGE faz o insert, caso já tenha registro, o comando faz a atualização dos dados

SELECT * FROM TALUNO
 ORDER BY COD_ALUNO;
 
SELECT * FROM TCONTRATO;

CREATE SEQUENCE seq_con START WITH 500; --Criação de sequencia

MERGE INTO TCONTRATO --MESCLAR na tabela TCONTRATO 
--Regra definida de acordo com o select abaixo
    USING (SELECT COD_ALUNO AS ALUNO
           FROM   TALUNO
           --WHERE  ESTADO = 'RS'
           ) --SELECT utilizado como regra
    ON    (TCONTRATO.COD_ALUNO = ALUNO)
       WHEN MATCHED THEN --Comando WHEN MATCHED identifica que, se o registro na tabela foi encontrado, então será realizado um updade no campo desconto na tabela TCONTRADO
            UPDATE SET desconto = 22
       WHEN NOT MATCHED THEN --Caso não encontre o registro na tabela TCONTRADO, será realizado a inserção dos dados
            INSERT(TCONTRATO.COD_CONTRATO, TCONTRATO.DATA, TCONTRATO.COD_ALUNO,
                   TCONTRATO.desconto, TCONTRATO.total)
           VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);

--SELECT * FROM TCONTRATO
--SELECT * FROM TALUNO