CREATE OR REPLACE FUNCTION CALCULA_INSS
 (               
P_SALARIO IN NUMBER
 ) RETURN NUMBER
 AS
V_DESCONTO NUMBER := 0;

 BEGIN  

        IF P_SALARIO <= 1212.00
        THEN 
            V_DESCONTO := P_SALARIO - (P_SALARIO * 0.925);
            DBMS_OUTPUT.PUT_LINE('VALOR DO DESCONTO É: R$'||V_DESCONTO);
            RETURN ROUND(V_DESCONTO, 3);
    END IF;    
    IF (P_SALARIO > 1212.01 AND P_SALARIO <= 2427.35)
        THEN
            V_DESCONTO := P_SALARIO - (P_SALARIO * 0.91);
            DBMS_OUTPUT.PUT_LINE('VALOR DO DESCONTO É: R$'||V_DESCONTO);
            RETURN ROUND(V_DESCONTO, 3);
    END IF;
    IF (P_SALARIO > 2427.35 AND P_SALARIO <= 3641.03)
        THEN
            V_DESCONTO := P_SALARIO - (P_SALARIO * 0.88);
            DBMS_OUTPUT.PUT_LINE('VALOR DO DESCONTO É: R$'||V_DESCONTO);
            RETURN ROUND(V_DESCONTO, 3);
    END IF;
    IF (P_SALARIO > 3641.03 AND P_SALARIO <= 7087.22)
        THEN
            V_DESCONTO := P_SALARIO - (P_SALARIO * 0.86);
            DBMS_OUTPUT.PUT_LINE('VALOR DO DESCONTO É: R$'||V_DESCONTO);
            RETURN ROUND(V_DESCONTO, 3);
    END IF;    
        
 END;
 
 SELECT CALCULA_INSS(2500) FROM DUAL
 ;
 
 CREATE OR REPLACE FUNCTION CALCULA_IR (P_SALARIO IN NUMBER) RETURN NUMBER
 AS
 V_DESCONTO NUMBER := 0.0;
 BEGIN
 
 IF (P_SALARIO <= 1903.98)
    THEN
    RETURN ROUND(V_DESCONTO, 3);
 END IF;
 
 IF(P_SALARIO >= 1903.99 AND P_SALARIO <= 2826.65)
    THEN
    V_DESCONTO := ((P_SALARIO - (P_SALARIO * 0.925)) - 142.80);
    RETURN ROUND(V_DESCONTO, 3);
  END IF;
  
  IF(P_SALARIO >= 2826.66 AND P_SALARIO <= 3751.05)
    THEN
    V_DESCONTO := ((P_SALARIO - (P_SALARIO * 0.85)) - 354.80);
    RETURN ROUND(V_DESCONTO, 3);
  END IF;
  
  IF(P_SALARIO >= 3751.06 AND P_SALARIO <= 4664.68)
    THEN
    V_DESCONTO := ((P_SALARIO - (P_SALARIO * 0.775)) - 636.13);
    RETURN ROUND(V_DESCONTO, 3);
  END IF;
  
  IF(P_SALARIO >= 4664.69)
    THEN
    V_DESCONTO := ((P_SALARIO - (P_SALARIO * 0.775)) - 869.36);
    RETURN ROUND(V_DESCONTO, 3);
  END IF; 
 
 END;
 
 SELECT CALCULA_IR(2500)
   FROM DUAL
;

CREATE OR REPLACE FUNCTION CALCULA_DESCONTOS
(
    P_SALARIO IN NUMBER
)
    RETURN NUMBER
    AS
        V_DESCONTO_IR NUMBER;
        V_DESCONTO_INSS NUMBER;
        V_DESCONTOS NUMBER;
        BEGIN
            
            V_DESCONTO_IR := CALCULA_IR(P_SALARIO);
            V_DESCONTO_INSS := CALCULA_INSS(P_SALARIO);
            V_DESCONTOS := V_DESCONTO_IR + V_DESCONTO_INSS;
            
            
            RETURN ROUND(V_DESCONTOS ,2);
END;

SELECT CALCULA_DESCONTOS(2500)
  FROM DUAL
;