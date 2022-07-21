
SELECT Count(*)   AS QTDE_REGISTROS,
       Avg(TOTAL) AS MEDIA,
       Round(Avg(TOTAL),2) AS MEDIA,
       Max(TOTAL) AS MAXIMO,
       Min(TOTAL) AS MINIMO,
       Sum(TOTAL) AS SOMA,
       Max(DATA)  AS DATA_MAIOR,
       Min(DATA)  AS DATA_MENOR
FROM TCONTRATO;

--Proximo código sequencial tabela
SELECT Max(COD_CONTRATO) + 1 AS PROXIMO_CODIGO
FROM TCONTRATO;

--
SELECT * FROM TALUNO;
SELECT * FROM TCONTRATO;

--TOTAL DE CONTRATOS POR ALUNO
-- Função GROUP BY deve ser utilizado em colunas que devems er agrupadas
SELECT COD_ALUNO,
       COUNT(*) AS QTDE_CONTRATO,
       Sum(TOTAL) AS VALOR_TOTAL
FROM TCONTRATO
GROUP BY COD_ALUNO

-- Função TO_CHAR serve para formatar o campo de data conforme exemplo abaixo
SELECT To_Char(Trunc(SYSDATE),'DD/MM/YYYY') AS DATA FROM DUAL

--TOTAL DE CONTRATO POR DATA
SELECT To_Char(Trunc(DATA),'DD/MM/YYYY') AS DATA,
       Sum(TOTAL) AS SOMA,
       Avg(TOTAL) AS MEDIA,
       Count(*)   AS QTDE
FROM TCONTRATO
GROUP BY Trunc(DATA)  --o trunc é utilizado no GROUP BY para agrupar por data e não por hora
ORDER BY DATA DESC

--------------------------

UPDATE TCONTRATO SET
  DESCONTO = NULL
WHERE COD_CONTRATO = 4;

update TCONTRATO SET
  DESCONTO = NULL
WHERE COD_CONTRATO = 3;


SELECT Count(*) AS QTDE_REGISTROS
FROM TCONTRATO;

SELECT * FROM TCONTRATO

--COUNT -> IGNORA NULOS, assim como qualquer função de grupo
SELECT Count(DESCONTO)
FROM TCONTRATO;

SELECT * FROM TALUNO

--Qtde de registros com estado informado
SELECT  Count(ESTADO)  FROM   TALUNO;

--QTDE DE estados diferentes
--Função DISTINCT para não repetir os registros
SELECT Count(DISTINCT(ESTADO)) FROM TALUNO;

--QUANT DE REGISTROS POR estado
SELECT Estado, Count(*)
FROM TALUNO
GROUP BY Estado;

-- LEMBRANDO, AS FUNÇÕES DE GRUPO IGNORAM VALORES NULOS
-- SUM -> Função de GRUPO de soma
-- AVG -> Função de GRUPO de média
-- COUNT -> Função de GRUPO para contador
SELECT Sum(DESCONTO),
       Avg(DESCONTO),
       Count(DESCONTO),
       Round(Avg( Nvl(DESCONTO,0) ), 2)
FROM TCONTRATO;

SELECT * FROM TCONTRATO

--TOTAL DE CONTRATO POR ESTADO E DATA
SELECT ALU.Estado, Trunc(CON.DATA) AS DATA,
       SUM(CON.Total) TOTAL, Count(*) qtde

FROM   TALUNO ALU, TCONTRATO CON
WHERE  ALU.COD_ALUNO = CON.COD_ALUNO
GROUP  BY  ALU.Estado, Trunc(CON.DATA)
ORDER  BY  ALU.ESTADO, DATA DESC;

--TOTAL DE CONTRATO POR ESTADO
SELECT ALU.Estado,
       SUM(CON.Total) TOTAL, Count(*) qtde

FROM   TALUNO ALU, TCONTRATO CON
WHERE  ALU.COD_ALUNO = CON.COD_ALUNO
GROUP  BY  ALU.Estado
ORDER  BY  ALU.ESTADO


-- Função HAVING - filtrar coluna com funcao de grupo
-- A Função HAVING pode ser usada antes do GROUP BY ou depois, conforme exemplos abaixo

SELECT COD_ALUNO, Round(AVG(TOTAL),2) MEDIA
FROM TCONTRATO
WHERE COD_ALUNO > 0
HAVING AVG(Total) > 500
GROUP BY COD_ALUNO
ORDER BY COD_ALUNO

--
SELECT To_Char(Trunc(DATA),'DD/MM/YYYY'), SUM(TOTAL) TOTAL
FROM   TCONTRATO
WHERE  COD_CONTRATO > 0
GROUP  BY Trunc(DATA)
HAVING SUM(TOTAL) > 500
ORDER  BY TOTAL Desc;

---Media mais alta por aluno
-- Função MAX busca o maior número de acordo com a busca do SELECT;
-- Como são funções de grupo, é necessário encerrar o SELECT com o comando GROUP BY
select max(avg(total))
from tcontrato
group by cod_aluno;

--Soma dos salarios por estado
SELECT ESTADO, Sum(Nvl(SALARIO,'0')) AS TOTAL
FROM TALUNO
GROUP BY ESTADO
ORDER BY TOTAL DESC -- ORDER BY 2, ele irá order a partir da segunda coluna do SELECT
