/****************************************************************
************************Funções básicas**************************
************************CONCAT******************************
************************||(pipe)*******************************
************************INITCAP************************************
************************INSTR************************************
************************LENGTH**********************************
************************LOWER*************************************
* UPPER
* LPAD
* RPAD
* SUBSTR
* REPLACE
*****************************************************************/

--
SELECT * FROM TALUNO;

-- Função CONCAT retorna a junção dos valores
SELECT Concat(COD_ALUNO,NOME) FROM TALUNO;

-- Utilizando ||(pipe) para a junção também dos valores
SELECT COD_ALUNO||' - '||NOME FROM TALUNO;

-- Função INITCAP, retorna a primeira letra de cada palavra em maíusculo
SELECT nome, InitCap(NOME) FROM TALUNO;

-- Exemplo função INITCAP
SELECT InitCap('JOSE DA SILVA') FROM dual;

-- Função INSTR, retorna em que posição está determinado caracter ou valor informado
SELECT nome, InStr(NOME,'R') FROM TALUNO;

-- Função LENGTH, retorna quantos caracteres tem o valor da coluna
SELECT nome, Length(NOME) FROM TALUNO;

-- Função LOWER, retorna a coluna em letra minúscula
SELECT nome, Lower(NOME) FROM TALUNO

-- Função UPPER, retorna a coluna em letra maíuscula
SELECT nome, Upper(NOME) FROM TALUNO;

-- Função LPAD, retorna o campo preenchido com o caracter informado a esquerda 
--> LPAD( Coluna_Requerida,Quantidade_de_Caracteres,'Valor_Preenchido' )
SELECT cod_aluno, LPad(COD_ALUNO,5,'0') FROM TALUNO;

-- Função RPAD, retorna o campo preenchido com o caracter informado a direita 
--> RPAD( Coluna_Requerida,Quantidade_de_Caracteres,'Valor_Preenchido' )
SELECT nome, salario, rpad(SALARIO,8,'0') FROM TALUNO;

-- Exemplo da função RPAD
SELECT nome, rpad(NOME,10,'$') FROM TALUNO;

-- Função SUBSTR, retorna parte de um texto --> SUBSTR( Coluna_Requerida, Posição, Quantidade_de_Caracteres )
SELECT nome, SubStr(NOME,1,3) FROM TALUNO;

-- Exemplo SUBSTR compiando um caracter apenas a partir do primeiro caracter
SELECT SubStr(NOME,1,1) FROM TALUNO;

-- Exemplo de SUBSTR copiando um caracter a partir do terceiro caracter
SELECT nome, SubStr(NOME,3,1) FROM TALUNO;

-- Função REPLACE, substituindo o caracter desejado --> REPLACE( Coluna_Requerida, Caracter, Caracter_substituto )
-- A baixo, a função UPPER está sendo utilizada apenas para deixar as letras maíusculas
SELECT REPLACE(Upper(NOME),'R','$') FROM TALUNO;

-- Junção de duas funções( SUBSTR e LENGHT) para descobrir  a última letra de cada valor da coluna
SELECT SubStr(NOME,Length(nome),1) FROM TALUNO;

--
SELECT SubStr(NOME,Length(nome)-1, 2) FROM TALUNO;

--
SELECT nome, SubStr(NOME, 3, Length(nome)-3 ) FROM TALUNO;


--
SELECT * FROM TALUNO
WHERE Lower(NOME) = 'marcio';

SELECT * FROM TALUNO
WHERE Upper(NOME) = 'MARCIO';

SELECT * FROM TALUNO
WHERE Upper(SubStr(CIDADE,1,3)) = 'CAN';


UPDATE TALUNO SET
SALARIO = 633.47
WHERE COD_ALUNO = 1;


SELECT
  SALARIO,
  REPLACE(SALARIO, ',' , ''),
  RPad(SALARIO, 10,'0'),     --Zeros a direita até 10 casas
  LPad(SALARIO, 10,'0'),     --Zeros a esquerda até 10 casas
  LPad(REPLACE(SALARIO,',',''),10,'0')
FROM TALUNO;



------------------Data
--DUAL é uma tabela que existe apenas para completar o sintaxe do SELECT
SELECT * FROM DUAL;

--Função SYSDATE retorna data/hora do Servidor.
SELECT SYSDATE FROM DUAL;

-- Função ROUND arredonda o número para cima --> ROUND( Número, Casas_decimais )
-- Função TRUNC arredonda o número para baixo --> TRUNC( Número, Casas_decimais )
-- Função MOD traz o resto da divisão --> ( Dividendo, Divisor )
SELECT Round(45.925, 2 ),  --45.93
       Trunc(45.929, 2 ),  --45.92
       Mod(10, 2) AS RESTO_DIVISAO,
       Trunc(1.99),
       Trunc(1.99, 2)
FROM DUAL;

SELECT * FROM TCONTRATO;

--Funcoes de Data/Hora
SELECT DATA, SYSDATE, DATA + 5 FROM TCONTRATO;

SELECT SYSDATE - DATA AS DIF_DIAS FROM TCONTRATO;

SELECT Trunc(SYSDATE - DATA) as DIAS FROM TCONTRATO;

--Somando horas em uma data
SELECT SYSDATE, SYSDATE + 5 / 24 as ADD_HORAS FROM TCONTRATO;

--Somar minutos
SELECT SYSDATE, SYSDATE + 15 / 1440 as ADD_MINUTOS FROM TCONTRATO;

SELECT SYSDATE, SYSDATE + 30 / (3600 * 24) as ADD_SEGUNDOS FROM TCONTRATO;


--Hora fica 00:00:00
SELECT SYSDATE, Trunc(SYSDATE) FROM DUAL;

--Diferenca de meses entre datas
SELECT Months_Between(SYSDATE, SYSDATE-90) AS DIF_MES FROM DUAL;

--Adiciona meses
SELECT Add_Months(SYSDATE, 5) AS ADICIONA_MES_DATA FROM DUAL;

--Proxima data a partir de uma dia da semana
SELECT Next_Day(SYSDATE, 'WEDNESDAY') AS PROXIMA_QUARTA_DATA FROM DUAL;

--Ultimo dia do mes
SELECT Last_Day(SYSDATE) AS ULTIMO_DIA_MES FROM DUAL;

--Primeiro dia do proximo mes
--até dia 15 do mes pega o primeiro dia do mes atual
--a partir do dia 16 retorna o primeiro dia do proximo mes
SELECT Round(SYSDATE, 'MONTH') AS PRIMEIRO_DIA_PROXIMO_MES FROM DUAL;


--Primeiro dia do mes. Com sempre traz o primeiro dia do mês corrente
SELECT Trunc(SYSDATE,'MONTH') AS PRIMEIRO_DIA_MES_CORRENTE FROM DUAL;


---Formatação de data

--Conversor to_char(data, formato)
--Função TO_CHAR converte para VARCHAR, String

--DD -> dia do mes
SELECT SYSDATE, To_Char(SYSDATE,'DD') FROM DUAL

-- Data sem horário
SELECT To_Char(SYSDATE,'DD/MM/YYYY') DATA FROM DUAL;

--Dia e Mês
SELECT To_Char(SYSDATE,'DD/MM') DIA_MES FROM DUAL;

--Dia
SELECT To_Char(SYSDATE,'DD') DIA FROM DUAL;

--Mês
SELECT To_Char(SYSDATE,'MM') MES FROM DUAL;

--Ano
SELECT To_Char(SYSDATE,'YYYY') ANO FROM DUAL;

--Ano
SELECT To_Char(SYSDATE,'YY') ANO FROM DUAL;

--Nome do Mês
SELECT To_Char(SYSDATE,'MONTH') MES1 FROM DUAL;

--Dia
SELECT To_Char(SYSDATE,'D') DIA_SEMANA FROM DUAL;

--Nome do dia da semana(3 primeiras letras)
SELECT To_Char(SYSDATE,'DY') DIA_SEMANA FROM DUAL;   -- QUA

--Nome do dia da semana
SELECT To_Char(SYSDATE,'DAY') DIA_SEMANA1 FROM DUAL; -- QUARTA

--Nome do ano
SELECT To_Char(SYSDATE,'YEAR') ANO FROM DUAL;        -- Em Ingles

--fm para retirar espaços entre os textos
SELECT To_Char(SYSDATE,'"NOVO HAMBURGO", fmDAY "," DD "de" fmMonth "de" YYYY') FROM DUAL;

--Hora e minutos em 24 horas
SELECT To_Char(SYSDATE,'HH24:MI') HORA_MIN FROM DUAL;

-- Hora, minutos e segundos
SELECT To_Char(SYSDATE,'HH24:MI:SS') HORA_MIN_SEG FROM DUAL;

-- Dia/ Mês, hora e minuto
SELECT To_Char(SYSDATE,'DD/MM HH24:MI') DATA_HORA FROM DUAL;

-- Data completa
SELECT To_Char(SYSDATE,'DD/MM/YYYY HH24:MI:SS') DATA_HORA FROM DUAL;






SELECT * FROM TALUNO
--Formatar dentro de aspas simples
--L -> R$
--G -> ponto
--D -> casas decimais
-- Função TRIM retira espaços em branco
SELECT Trim(To_Char(Salario,'L99999.99')) salario1, trim(To_Char(Salario,'L99G999D99')) salario2
FROM TALUNO;

--
SELECT 'R$ '||(Round(Salario,2)) AS salario FROM TALUNO;



-----
-- Função NVL retorna um valor específicado para valores nulos --> NVL( Coluna_Requerida, Se_Nulo_Retorna_Valor_informado )
-- Função NVL2 retorna um valor específicado para valores nulos com condição --> NVL2( Coluna_Requerida, Senão_Retorna_outro_valor , Se_Nulo_Retorna_Valor_informado )
SELECT * FROM tcontrato;

SELECT Total,
       Desconto,
       Desconto+Total,
       Nvl(Desconto,0),
       Nvl(Desconto,0) + TOTAL,
       Nvl2(DESCONTO, TOTAL, 0)
FROM TContrato;

SELECT * FROM TALUNO

UPDATE TALUNO SET
NOME = NULL
WHERE COD_ALUNO = 5;

SELECT Cod_Aluno, Nvl(Nome, 'SEM NOME') FROM TALUNO

SELECT * FROM TALUNO;


UPDATE TAluno SET
Estado = 'SC'
WHERE Cod_Aluno=3;

UPDATE TAluno SET
Estado = 'RJ'
WHERE Cod_Aluno=5;

--Função Case retorna os dados de acordo com as validações, conforme exemplo abaixo
SELECT NOME, Estado,
       CASE
         WHEN Estado = 'RS' THEN 'GAUCHO'
         WHEN Estado = 'AC' THEN 'ACREANO'
         WHEN Estado = 'RJ' AND SALARIO > 500 THEN 'CARIOCA'
         ELSE 'OUTROS'
       END AS Apelido
FROM TALUNO;

--
SELECT SYSDATE AS DATA FROM DUAL

-- Função Decode, é parecido com CASE, porém não se pode explorar tanto em relação a combinação de valores
SELECT NOME, ESTADO,
       Decode(ESTADO,'RS','GAUCHO',
                     'AC','ACREANO',
                     'SP','PAULISTA',
                          'OUTROS' ) AS APELIDO
FROM TALUNO;



---------- Fim ----------