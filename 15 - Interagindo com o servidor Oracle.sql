--PL/SQL suporta comandos DML e o comando SELECT.
--Um bloco PL/SQL não é uma unidade de transação. COMMITs, SAVEPOINTs e ROLLBAKCs são independentes de blocos, mas vocÊ pode executar estes comandos dentro do bloco.
--O PL/SQL não suporta a linguagem de definição de dados (DDL) nem linguagem control de dados(DCL).
--A cláusula INTO é obrigatória e deve estar entre as cláusulas SELECT e FROM
--Você utiliza a cláusula INTO para popular variáveis PL/SQL ou variáveis HOST(Bind variable - se usa fora do bloco anônimo)
--  DECLARE
--    vPreco NUMBER(2);
--    vCod_trg VARCHAR2(15);
--  BEGIN
--    SELECT preco, cod_trg
--      INTO vPreco, vCod_trg
--      FROM tcursos
--     WHERE id=1;
--...
--  END;
--Lembrando, a cláusua INTO deve trazer apenas um registro, mais de um registro ou nenhuma teremos o erro(EXCEPTION)


                                    
DECLARE
--declarando as variáveis
  vValor NUMBER(8, 2);
  vNome  VARCHAR2(30);
BEGIN
--variávies recebem os valores das colunas
  SELECT valor, nome
  INTO   vValor, vNome --INTO deve trazer apenas UMA única linha, mais linhas ou nenhuma irá retornar um EXCEPTION
  FROM   tcurso
  WHERE  cod_curso = &cod_Curso; --o e comercial irá aparercer uma caixa para digitar o valor

--Dbms_Output.Put_line(); -> função para exibição do resultado
  Dbms_Output.Put_Line('Valor: '|| To_Char(vValor,'fm9999.99'));--TO_CHAR, função de grupo para formatação de dados

  Dbms_Output.Put_Line('Curso: '|| InitCap(vNome));--InitCap transforma a primeira letra da cada palavra em maíuscula
END;

SELECT * FROM TCurso;




DECLARE
   vDt_compra  tcontrato.Data%TYPE;
   vDt_curso   tcontrato.Data%TYPE;
BEGIN
   SELECT data, data + 10
   INTO   vDt_compra, vDt_curso
   FROM   tcontrato
   WHERE  cod_contrato = &Contrato;
   Dbms_Output.Put_Line('Data Compra: '||vDt_compra);
   Dbms_Output.Put_Line('Data Curso: '||vDt_curso);
END;

SELECT * FROM TCONTRATO;



SELECT Max(COD_CONTRATO) FROM TCONTRATO;
CREATE SEQUENCE SEQ_CONTRATO START WITH 8;

--
DECLARE
  vCod tcontrato.cod_contrato%TYPE;
BEGIN
  SELECT SEQ_CONTRATO.NEXTVAL --Comando para informar o próximo valor da sequencia, no caso SEQ_CONTRATO
  INTO   vCod FROM Dual;

  INSERT INTO TContrato(COD_CONTRATO, DATA,
                        COD_ALUNO, DESCONTO)
  VALUES(vCod, SYSDATE, 2, NULL);

  Dbms_Output.Put_Line('Criado Contrato: '||vCod);
END;



--Pegar o valor atual da sequencia criada
SELECT Seq_Contrato.CURRVAL FROM Dual;

SELECT * FROM TCONTRATO;


-----Update
DECLARE
  vValor TCurso.Valor%TYPE := &Digite_o_Valor;
BEGIN
  UPDATE tcurso SET
  Valor = Valor + vValor
  WHERE  carga_horaria >= 25;

  dbms_output.put_line('Aumento na carga horária de: '||vValor||' horas');
END;
--
SELECT * FROM tcurso;

-----Delete
DECLARE
  vContrato TContrato.COD_CONTRATO%TYPE := &Informe_o_contrato;
BEGIN
  DELETE FROM TContrato
  WHERE  Cod_Contrato = vContrato;
END;

-- INSERT, DELETE, E UPDATE pode-se fazer com mais de um registro, entretando o SELECT deve retornar apenas um registro, e é obrigatório ter a cláusula INTO


SELECT * FROM tcontrato;


-- Exemplo de: Erro No_Data_Found
-- Select Into que nao encontra registros
DECLARE
   vdt_compra    tcontrato.data%TYPE;
   vTotal       tcontrato.total%TYPE;
   vDt_atual    DATE := SYSDATE;
BEGIN
   SELECT data, total
   INTO   vdt_compra, vTotal
   FROM   tcontrato WHERE  Data = vDt_atual;	--
   Dbms_Output.Put_Line('Resultado Select');
END;




SELECT * FROM ALL_CONSTRAINTS
 WHERE OWNER = 'ALUNO'


DECLARE
   vContrato   NUMBER := &cod_contrato;
   vtexto VARCHAR2(50);
BEGIN
  UPDATE TContrato SET
  desconto = desconto + 2
  WHERE Cod_Contrato = VContrato;

  vtexto := SQL%ROWCOUNT;
  --Retorna qtde de registros afetados
  --pelo comando sql

  Dbms_Output.Put_Line(vtexto|| ' linhas atualizadas.');
END;

-- SQL%ROWCOUNT - Retorna quantidade de linhas afetadas;
-- SQL%FOUND - Retorna TRUE se o comando SQL afetou uma ou mais linhas;
-- SQL%NOTFOUND - Retorna TRUE se o comando SQL não afetou nenhuma linha;
-- SQL%ISOPEN - Retorne sempre FALSE porque o PL/SQL fecha cursores implícitos imediatamente após sua execução;

--- Exercicios   --- Pagina 95



1)
DECLARE
   vCod NUMBER;
BEGIN
   SELECT max(cod_depto) INTO vCod
   FROM   tdepartamento;
   Dbms_Output.Put_Line(vCod);
END;

2)
DECLARE
   vCod NUMBER;
BEGIN
   SELECT max(cod_depto) INTO vCod
   FROM   tdepartamento;
   vCod := vCod + 10;
   INSERT INTO tdepartamento  (cod_depto, nome, loca)
   VALUES (vCod, '&nome', NULL);
   Dbms_Output.Put_Line(vCod);
END;


3)
DECLARE
  vNome TDEPARTAMENTO.NOME%TYPE;
  vLocal TDEPARTAMENTO.LOCAL%TYPE;
BEGIN
  UPDATE TDEPARTAMENTO SET
  NOME = '&NOME'   ,
  LOCAL = '&LOCAL'
  WHERE COD_DEPTO = &cod_depto;
  --
  --SELECT NOME,LOCAL INTO vNome, vLocal
  --FROM TDEPARTAMENTO
  --WHERE COD_DEPTO = &cod_depto;
  --
  Dbms_Output.Put_Line('Departamento: '||vNome);
  Dbms_Output.Put_Line('Local: '||vLocal);
END;

4)
DECLARE
  vQtde VARCHAR(10);
BEGIN
  DELETE FROM TDEPARTAMENTO
  WHERE COD_DEPTO = &cod_depto;
  vQtde := SQL%ROWCOUNT;
  Dbms_Output.Put_Line('Registros deletados: '|| vQtde);
END;





