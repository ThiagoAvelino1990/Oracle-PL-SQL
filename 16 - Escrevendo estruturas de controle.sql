DECLARE
  vNome VARCHAR(30) := 'Doidin';
  vCidade VARCHAR(30);     
  vEstado VARCHAR(2);
BEGIN
    
  IF (vNome = 'Gaucho') THEN
    vCidade := 'Porto Alegre';    
    vEstado := 'RS';
  ELSIF (vNome = 'Carioca') THEN
    vCidade := 'Rio de Janeiro';  
    vEstado := 'RJ';
  ELSIF (vNome = 'Acreano') OR (vNome = 'Amapa') THEN
    vCidade := 'Nao existe';      
    vEstado := 'AC';
  ELSE
    IF (vEstado<>'RS') THEN
      vCidade := 'Estrangeiro';
      vEstado := 'XX';
    ELSE
      vCidade := 'N�o Encontrado';
      vEstado := 'XX';
    END IF;
  END IF;
  Dbms_Output.Put_Line('Nome: '||vNome||'; Cidade: '||vCidade||'; Estado: '||vEstado);
END;

--
-- Case When
--
DECLARE
  vEstado VARCHAR(2) := 'RR';
  vNome VARCHAR(30);
BEGIN
  CASE
    WHEN vEstado ='RS' THEN vNome := 'Gaucho';
    WHEN vEstado ='RJ' OR vEstado='ES' THEN vNome := 'Carioca';
  ELSE
    vNome := 'Outros';
  END CASE;
  Dbms_Output.Put_Line('Apelido: '||vNome);
END;
--





--La�o de repeti��o 1 at� 10
DECLARE
  vContador INTEGER := 0;
BEGIN
  LOOP
    vContador := vContador + 1;
    Dbms_Output.Put_Line(vContador);
    EXIT WHEN vContador = 10;
  END LOOP;
  Dbms_Output.Put_Line('Fim do LOOP');
END;

--La�o de repeti��o 10 at� 1
DECLARE
  vContador INTEGER := 10;
BEGIN
  LOOP
    vContador := vContador - 1;
    Dbms_Output.Put_Line(vContador);
    EXIT WHEN vContador = 0;
  END LOOP;
  Dbms_Output.Put_Line('Fim do LOOP');
END;






--For loop -> mais indicado para la�os em tabelas
DECLARE
  vContador INTEGER;
BEGIN
  FOR vContador in 1..10 --La�o FOR de 1 at� 10
  LOOP
    --vContador := vContador + 1;
    Dbms_Output.Put_Line('For Loop '||vContador);
    --EXIT WHEN vContador = 5;
  END LOOP;
END;


--While Loop
DECLARE
  vContador INTEGER := 0;
  vTexto VARCHAR(10);
BEGIN
  WHILE vContador < 10
  LOOP
    vContador := vContador + 1;
    IF (vContador Mod 2)=0 THEN   --Fun��o MOD far� a divis�o de vContador por 2, e mostrar� o RESTO da divis�o
      vTexto := 'Par';
    ELSE
      vTexto := 'Impar';
    END IF;
    Dbms_Output.Put_Line(vContador|| ' -> '||vTexto);
  END LOOP;
END;




