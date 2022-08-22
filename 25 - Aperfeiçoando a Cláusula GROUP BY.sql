-----------------------------------APERFEIÇOANDO A CLÁUSULA GROUP BY-----------------------------------
--As operações de GROUP BY e HAVING podem se utilizar de operações chamadas de ROLLUP e CUBE
--  São subtotais e tabulações sobre as dimensões
--  Úteis para sistemas de DatWare House(Informações gerenciais) 
--    GROUP BY ROLLUP( column, [column])
--    GROUP BY CUBE (column, [column])
-----------------------------------FUNÇÃO ROLLUP-----------------------------------
--Retorna uma única linha sumarizada para os subgrupos
--Tem grande utilidade na construção de subtotais
-----------------------------------FUNÇÃO CUBE-----------------------------------
--Executa as funções de agregação para subgrupos compostos dos valores de todas as possíveis combinações das expressões(informadas para CUBE)
--Retorna uma única linha sumarizada para cada subgrupo
--Ao final executa totais individuais
-----------------------------------IDENTIFICANDO SUBGRUPOS-----------------------------------
--Algumas funções podem nos ajudar a distinguir um valor NULL que representa um subgrupo(de uma das agregações produzidas pelo ROLLUP e CUBE), de um valor NULL real.
--  GROUPING: Retorna 1 se o valor da expressão representar um subgrupo
--  GROUPING_ID:Retorna valores sequênciais dos diversos resultados de GROUPING na ordem em que ocorrem
-----------------------------------FUNÇÕES ANALÍTICAS-----------------------------------
--As funções analíticas são valiosas para todo tipo de processamento, desde suporte á decisão até a geração de relatórios comuns
--Melhoram o desempenho de consultar ao banco de dados e a produtividade dos desenvolvedores
-----------------------------------FUNÇÃO RANK-----------------------------------
--As funções da família RANK calculam o rank(posição, ordem) de uma linha em relação as demais linhas, dentro de um conjunto de dados
--A função RANK() produz uma classificação ordenada de linhas começando com a posição 1
-----------------------------------RANKING COM PARTICIONAMENTO-----------------------------------
--A cláusula opcional PARTITION BY é usada para definir onde o cálculo da posição é reinicializado
-----------------------------------FUNÇÃO DENSE_RANK-----------------------------------
--A função DENSE_RANK não deixa "abertura" na sequência numérica do ranking
-----------------------------------FUNÇÃO RATIO_TO_REPORT-----------------------------------
--A função RATIO_TO_REPORT calcula a proporção de um valor em relação á agregação de um conjunto de valores
--Por exemplo, comparar o total de contratos de um cliente com o total geral de contratos
-----------------------------------LAG() E LEAD()-----------------------------------
--As funções LAG e LEAD permitem comparações entre duas linhas de um mesmo conjunto de dados
--Por exemplo, analisar mudanças nas vendas mensais do ano corrente comparadas com as de anos anteriores ou analisar a variação entre orçamento e custos reais



--Comando ROLLUP traz o subtotal dos campos que não tem função de grupo
SELECT COD_ALUNO, TRUNC(DATA),
       SUM(DESCONTO) DESCONTO,
       SUM(TOTAL) TOTAL
FROM   TCONTRATO
GROUP  BY ROLLUP( COD_ALUNO, TRUNC(DATA) );          


--ROLL UP com as descrições
SELECT COD_ALUNO,
       CASE
         WHEN TRUNC(DATA) IS NULL AND COD_ALUNO IS NOT NULL
             THEN 'SUB-TOTAL'
         WHEN COD_ALUNO IS NULL AND Trunc(DATA) IS NULL
             THEN 'TOTAL-GERAL'
         ELSE TO_CHAR( Trunc(DATA) )
       END DESCRICAO,
       Round(AVG(DESCONTO),2) DESCONTO,
       SUM(TOTAL) TOTAL
FROM   TCONTRATO
GROUP  BY ROLLUP(COD_ALUNO, TRUNC(DATA) );




--CUBE é Similar com o ROLL UP 
SELECT COD_ALUNO, Trunc(DATA), SUM(TOTAL)
FROM TCONTRATO
GROUP BY CUBE(COD_ALUNO, Trunc(DATA));


--
SELECT * FROM TCONTRATO;

--------------------------- Identifica total geral
--Utilizando a função GROUPING

SELECT GROUPING(COD_ALUNO), Sum(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);

-------------------------
SELECT GROUPING(COD_ALUNO),
       CASE
         WHEN GROUPING(COD_ALUNO)=0 THEN TO_CHAR(COD_ALUNO)
         ELSE 'Total Geral :'
       END ALUNO,
       Sum(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP(COD_ALUNO);


--------------------------------------
SELECT Trunc(DATA),
       GROUPING_ID(Trunc(DATA)) GDT,
       COD_ALUNO,
       GROUPING_ID(COD_ALUNO) GCL,
       SUM(TOTAL)
FROM TCONTRATO
GROUP BY ROLLUP( Trunc(DATA), COD_ALUNO);


-----------------*********
SELECT Trunc(DATA),COD_ALUNO,
    CASE
     WHEN GROUPING_ID(COD_ALUNO)=1 AND
    	  GROUPING_ID(Trunc(DATA))=0 THEN 'Total do Dia : '
     WHEN GROUPING_ID(COD_ALUNO)=1 AND
        GROUPING_ID(Trunc(DATA))=1 THEN 'Total Geral  : '
    END AS DESCRICAO,
    SUM(TOTAL) TOTAL
FROM TCONTRATO
GROUP BY ROLLUP(Trunc(DATA), COD_ALUNO);



-------********* Retorna somente subtotais
SELECT COD_ALUNO, Trunc(DATA), SUM(TOTAL)
FROM TCONTRATO
GROUP BY GROUPING SETS (COD_ALUNO, Trunc(DATA) );

------------*********
--Total igual repete o rank
--   1 - 1 - 3 - 4 - 4 - 6
-- RANK traz um ranqueamento conforme o total
SELECT Trunc(DATA), COD_ALUNO, SUM(TOTAL),
       RANK() OVER (ORDER BY SUM(TOTAL) DESC) POSICAO
FROM TCONTRATO
GROUP BY (Trunc(DATA), COD_ALUNO)

-------------*********
-- rank -> 1 - 2 - 3 - 3 - 5
SELECT COD_ALUNO, SUM(TOTAL),
       RANK() OVER (ORDER BY SUM(TOTAL) DESC) POSICAO
FROM TCONTRATO
GROUP BY (COD_ALUNO);

------------**********Posicao por grupo
-- rank -> 1 - 2 - 1 - 2
SELECT Trunc(DATA),COD_ALUNO,SUM(TOTAL),
       RANK() OVER (PARTITION BY Trunc(DATA) --PARTITION BY faz a quebra por data
   		  ORDER BY SUM(TOTAL) DESC) POSICAO  --SUM(TOTAL) será considerada para fazer o RANK()
FROM TCONTRATO
GROUP BY (Trunc(DATA),COD_ALUNO)
ORDER BY COD_ALUNO;

--------------------------- DENSE_RANK()
SELECT COD_ALUNO, TOTAL,
     RANK() OVER (ORDER BY TOTAL DESC) "RANK()", -- o RANK se tiver algum registro empatado, ele não traz na sequência 1 - 2 - 3 - 3 - 5 - 6
     DENSE_RANK() OVER (ORDER BY TOTAL DESC) "DENSE_RANK()" --Se tiver algum registro empatado o DENSE_RANK() traz o próximo número do rank 1 - 2 - 3 - 4 - 5 - 6
FROM TCONTRATO
GROUP BY COD_ALUNO, TOTAL;

---------------RATIO_TO_REPORT
SELECT COD_ALUNO,SUM(TOTAL) "Total do Cliente",
  ROUND(RATIO_TO_REPORT(SUM(TOTAL)) OVER()*100 ,2)"% do Total" -- Traz um percentual de cada registro, referente ao percentual total
FROM TCONTRATO
GROUP BY COD_ALUNO;

-----------
SELECT COD_ALUNO,
       Trunc(DATA),
       SUM(total) "Total do Dia",
       ROUND(RATIO_TO_REPORT(SUM(total)) OVER(PARTITION BY
       Trunc(DATA)) * 100, 2) "% do Dia"
FROM TCONTRATO
GROUP BY COD_ALUNO, Trunc(DATA)
ORDER BY 2 ASC, COD_ALUNO;

-------------------------

-----------FUNÇÃO LAG e LEAD
SELECT Trunc(DATA), SUM(Total) total_dia,
  LAG  (SUM(Total),1) OVER (ORDER BY Trunc(DATA)) anterior,
  LEAD (SUM(Total),1) OVER (ORDER BY Trunc(DATA)) proximo
FROM TCONTRATO
GROUP BY Trunc(DATA)
ORDER BY Trunc(DATA);



TOTAL  ANT     PROX
500    NULL    600
600    500     700
700    600     800
800    700     NULL
