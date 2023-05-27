---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
/* SQL para Análise de Dados: Do básico ao avançado! */
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

---------------------8. SELECT---------------------
SELECT coluna_1,coluna_1,coluna_3
FROM schema_1.nome_da_tabela;

-- Seleção de uma coluna de uma tabela
-- Liste os e-mails dos clientes da tabela sales.customers
SELECT email
FROM sales.customers


--Seleção de mais de uma coluna  de uma tabela
--Liste os emails e nomes dos clientes da tabela sales.customers
SELECT email, firsty_name, last_name 
FROM sales.customers


-- Seleçao de todas as colunas de uma table
-- Liste todas as informações dos clientes da tabela sales.customers
SELECT * FROM sales.customers

--RESUMO
-- 1 Comando usado para selecionar colunas de tabelas
-- 2 Quando selecionar mais de duas coluna, elas devem ser separadas por vígula sem conter vírgula antes do comando FROM
-- 3 Pode-se utilizar o asterisco (*) para selecionar todas as colunas da tabela


---------------------9. DISTINCT---------------------
-- Serve para remover linhas duplicadas e mostrar apenas linhas distintas
-- Muito usado na etapa de exploração das bases
SELECT DISTINCT coluna_1, coluna_2, coluna_3
FROM schema_1.tabela_1

-- Seleção de uma coluna sem DISTINCT
-- Lista as marcas de carro que constam na tabela products
SELECT brand
FROM sales.products
-- Resultado 333 linhas

-- Seleção de uma coluna com DISTINCT
-- Lista as marcas de carro distintas que constam na tabela products
SELECT DISTINCT brand
FROM sales.products;
-- Resultado 40 linhas

-- Seleção de mais de uma coluna com DISTINCT
-- Liste as marca e anos de modelo distintos que constam na tabela products
SELECT DISTINCT brand, model_year
FROM sales.products
-- Resultado 184 linhas

--RESUMO: 
-- 1 Comando usado para remover linhas duplicadas e mostrar apenas linhas distintas
-- 2 Muito utilizado na etapa de exploração dos dados
-- 3 Caso mais de uma coluna seja selecionado, o comando  SELECT DISTINCT irá retornar todas as combinações distintas.


---------------------10. WHERE----------------------

-- Filtro com condição única
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina

SELECT email
FROM sales.customers
WHERE state = 'SC'

SELECT email, state
FROM sales.customers
WHERE state = 'SC'

--Filtro com mais de uma codição
-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina OU Mato Grosso do Sul

SELECT email
FROM sales.customers
WHERE state = 'SC' OR state = 'MS'

SELECT email, state
FROM sales.customers
WHERE state = 'SC' OR state = 'MS'


-- Filtro de cindição com data

-- Liste os emails dos clientes da nossa base que moram no estado de Santa Catarina OU Mato Grosso do Sul e que mais de 30 anos
SELECT email,birth_date
FROM sales.customers

--RESUMO
-- 1 Comando utilizado para filtrar linhas de acordo com uma codição
-- 2 No PostgreSQL são utilizadas aspas simples para delimitar strings
-- 3 string = sequência de caracteres = texto
-- 4 Pode-se combinar mais de uma condição utilizando os operadores lógicos
-- 5 No PostgreSQL as datas são escritas no formato 'YYYY-MM-DD' ou 'YYYYMMDD'



---------------------11. ORDER BY----------------------
SELECT coluna_1,coluna_2,coluna_3
FROM schema_1.tabela_1
WHERE condicao_x = true
ORDER BY coluna_2

-- Ordenação de valores numéricos
-- Liste produtos das tabela products na ordem crescente com base no preço
SELECT product_id, brand, model, model_year, price
FROM sales.products
ORDER BY brand

SELECT * FROM sales.products
ORDER BY brand

-- Ordenação de valores numéricos
-- Liste produtos das tabela products na ordem decrecente com base no preço
SELECT product_id, brand, model, model_year, price
FROM sales.products
ORDER BY brand DESC

SELECT * FROM sales.products
ORDER BY brand DESC

-- Ordenação de Texto
-- Liste os estados distintos da tabela customers na ordem crescente A -> Z
SELECT DISTINCT state
FROM sales.customers
ORDER BY state

-- Ordenação de Texto
-- Liste os estados distintos da tabela customers na ordem decrecente Z -> A
SELECT DISTINCT state
FROM sales.customers
ORDER BY state DESC

--RESUMO
-- 1 Comando utilizado para ordenar a seleção de acordo com uma regra definida
-- 2 Por padrão o comando ordena na ordem crescente. Para mudar a ordem descrescente usar o comando DESC
-- 3 No caso de strings a ordenação será seguirá a ordem alfabetica


---------------------12. LIMIT----------------------
-- Seleção das N primeiras linhas usando LIMIT
-- Liste as 10 primeiras linhas da tabela funnel
SELECT * FROM sales.funnel
LIMIT 10

-- Seleção das N primeiras linhas usando LIMIT e ORDER BY
-- Liste os 10 produtos mais caros da tabela products
SELECT * FROM sales.products
ORDER BY price DESC
LIMIT 10


-- RESUMO
-- 1 Comando utilizado para limitar o nª de linhas da consulta
-- 2 Muito utlizado na etapa de exploração dos dados
-- 3 Muito utilizado em conjunto com o comando ORDER BY quando o que importa são os TOP N. Ex: "N pagamentos mais recentes", "N produtos mais caros"

---------------------13. DESAFIO ----------------------
-- EXERCÍCIOS ######################################################################

-- (Exercício 1) Selecione os nomes de cidade distintas que existem no estado de
-- Minas Gerais em ordem alfabética (dados da tabela sales.customers)
SELECT DISTINCT city, state
FROM sales.customers
WHERE state = 'MG'


-- (Exercício 2) Selecione o visit_id das 10 compras mais recentes efetuadas
-- (dados da tabela sales.funnel)
SELECT visit_page_date,visit_id
FROM sales.funnel
WHERE paid_date IS NOT NULL
ORDER BY paid_date DESC
LIMIT 10


-- (Exercício 3) Selecione todos os dados dos 10 clientes com maior score nascidos
-- após 01/01/2000 (dados da tabela sales.customers)
SELECT * FROM sales.customers
WHERE birth_date >= '2000-01-01' AND score > '900'
ORDER BY score DESC
LIMIT 10

--OU

SELECT *
FROM sales.customers
WHERE birth_date >= '2000-01-01'
ORDER BY score DESC
LIMIT 10

---------------------13. DESAFIO ----------------------
-- Servem para executar operações matemáticas
-- Muito utilizados para criar colunas calculadas

-- Tipos 
-- + 
-- -
-- *
-- /
-- ^
-- ||


-- Criação de coluna calculada
-- Crie uma coluna contendo a idade do cliente da tabela sales.customers
SELECT * FROM sales.customers 
LIMIT 10;

SELECT email, birth_date,
(current_date - birth_date)/365 AS idade
FROM sales.customers
ORDER BY "idade"


-- Criação de coluna calculada com strings
-- Crie a coluna "nome_completo" contendo o nome completo do cliente

SELECT 
    first_name || ' ' || last_name AS "Nome completo"
FROM sales.customers

-- RESUMO
-- 1 Servem para executar operações matemáticas
-- 2 Muito utilizado para criar colunas calculadas
-- 3 Alias (pseudônimos) são muito utilizados para dar nome as colunas calculadas.
-- 4 Para Criar pseudônimos que contém espaços no nome são utilizadas aspas duplas
-- 5 No caso de strings o operador de adição (||) irá concatenar as strings
-- 6 Utilize o Guia de comandos para consultar os operadores utilizados no SQL


-------------------------- 16. Operadores de comparação ----------------------------------
-- TIPOS
-- =
-- >
-- <
-- >=
-- <=
-- <>

-- Uso de operadores como flag
-- Crie uma tabela que retorne TRUE sempre que um cliente for um profissional clt

SELECT * FROM sales.customers 
LIMIT 100

SELECT count (*), professional_status FROM sales.customers 
GROUP BY professional_status

SELECT first_name ||' '|| last_name AS "Nome Completo" , professional_status
FROM sales.customers
WHERE professional_status = 'clt'

SELECT first_name ||' '|| last_name AS "Nome Completo" , (professional_status = 'clt')
FROM sales.customers

SELECT first_name ||' '|| last_name AS "Nome Completo" , (professional_status = 'clt')
FROM sales.customers
WHERE professional_status = 'clt'


-- RESUMO
-- 1 Servem para comprar dois valores retornando TRUE ou FALSE
-- 2 Muito utilizado em conjunto com a função WHERE para filtrar linhas de uma seleção
-- 3 Utilizados para criar colunas Flag que retornem TRUE ou FALSE
-- 4 Utilize o Guia de comandos para consultar os operadores utilizados no SQL   


-------------------------- 16. Operadores de comparação ----------------------------------
-- Uso do comando BETWEEN
-- Seleciona veículos que custam entre 100k e 200k na tabela products
SELECT * FROM sales.products
WHERE price >= 100000 AND price <= 200000;

SELECT * FROM sales.products
WHERE price BETWEEN 10000 AND 200000; 

-- Uso do comando NOT
-- Selecione veículos que custam abaixo de 100k ou acima 200k
SELECT * FROM sales.products
WHERE  price < 100000 OR price > 200000;

SELECT * FROM sales.products 
WHERE price NOT BETWEEN 100000 AND 200000;

-- Uso do comando IN
-- Selecionar produtos que sejam da marca HONDA, TOYOTA ou RENAULT
SELECT * FROM sales.products
WHERE brand IN('HONDA','TOYOTA','RENAULT');

SELECT * FROM  sales.products
WHERE brand = 'HONDA' OR brand = 'TOYOTA' OR brand = 'RENAULT';


-- Selecionar produtos que NÃO sejam da marca HONDA, TOYOTA ou RENAULT
SELECT * FROM sales.products
WHERE brand NOT IN('HONDA','TOYOTA','RENAULT');


-- Uso do comando LIKE (matchs imperfeitos)
-- Selecione os primeiros nomes distintos da tabela customers que começam com as iniciais ANA
SELECT DISTINCT c.first_name FROM sales.customers c
WHERE first_name LIKE('ANA%');


-- Uso do comando ILIKE (ignora letras maiúsculas e minúculas)
-- Selecione os primeiros nomes distintos com iniciais 'ana'
SELECT DISTINCT c.first_name FROM sales.customers c
WHERE first_name ILIKE('ana%');

-- Uso do comando IS NULL
-- Selecionar apenas as linhas que contém nulo no campo "population" na tabela temp_tables.regions
SELECT * FROM temp_tables.regions
WHERE population IS NULL;

-- Lembrando que o comando a baixo não funciona. Devemos sempre usar o IS NULL, dessa forma ele mostrará os/todos campos vazios
SELECT * FROM temp_tables.regions
WHERE population = NULL;

--RESUMO
-- 1 Usados para unir expressões simples em uma composta
-- 2 AND: Verifica se duas comparações são simultaneamente verdadeiras
-- 3 OR: Verifica se uma ou outra comparação é verdadeiras
-- 4 BETWEEN: Verifica quais valores estão dentro do range definido
-- 5 IN: Funciona como multiplos ORs
-- 6 LIKE e ILIKE: Comparam textos e são sempre utilizados em conjunto com o operador %, que funciona como coringa, indicando que qualquer texto pode aparecer no lugar do campo
-- 7 ILIKE ignora se o campo tem letras maiúsculas ou minúsculas na camparação
-- 8 IS NULL: Verifica se o campo é nulo
-- 9 Utilize o Guia de comandos para consultar os operadores utilizados no SQL


-------------------------- 18. Desafios ----------------------------------
-- (Exercício 1) Calcule quantos salários mínimos ganha cada cliente da tabela 
-- sales.customers. Selecione as colunas de: email, income e a coluna calculada "salários mínimos"
-- Considere o salário mínimo igual à R$1200
SELECT email,income,(income/1200) AS "Quantidade de Salário Minimo" 
FROM sales.customers;

SELECT email, professional_status,CONCAT('R$ ',income), ROUND(income/1200,3) AS "Quantidade de Salário Minimo" 
FROM sales.customers
ORDER BY income DESC;



-- (Exercício 2) Na query anterior acrescente uma coluna informando TRUE se o cliente
-- ganha acima de 5 salários mínimos e FALSE se ganha 4 salários ou menos.
-- Chame a nova coluna de "acima de 4 salários"
SELECT email, professional_status,CONCAT('R$ ', income), ROUND(income/1200,2) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
ORDER BY income ASC;

SELECT email,income,(income/1200) AS "Quantidade de Salário Minimo",(((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers;


-- (Exercício 3) Na query anterior filtre apenas os clientes que ganham entre
-- 4 e 5 salários mínimos. Utilize o comando BETWEEN
SELECT email, professional_status,CONCAT('R$ ', income), (income/1200) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;

SELECT email, professional_status,CONCAT('R$ ', income),(income/1200) AS "Quantidade de Salario Minimo", (((income/1200) > 5) = TRUE) AS "Acima de 5 Salarios minimos"
FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;

select *, ROUND(income/1200,0) AS "Quantidade de Salario Minimo" FROM sales.customers
WHERE (income/1200) BETWEEN 4 AND 5
ORDER BY income ASC;


-- (Exercício 4) Selecine o email, cidade e estado dos clientes que moram no estado de 
-- Minas Gerais e Mato Grosso. 
SELECT email, city,state
FROM sales.customers
WHERE state IN('MG','MT') 
ORDER BY state DESC;

SELECT email, city,state
FROM sales.customers
WHERE state = 'MG' OR state = 'MT'
ORDER BY state DESC;

-- (Exercício 5) Selecine o email, cidade e estado dos clientes que não 
-- moram no estado de São Paulo.
SELECT email, city,state
FROM sales.customers
WHERE state IN('MG','MT') 
ORDER BY state DESC;

SELECT email, city,state
FROM sales.customers
WHERE state = 'MG' OR state = 'MT'
ORDER BY state DESC;


-- (Exercício 6) Selecine os nomes das cidade que começam com a letra Z.
-- Dados da tabela temp_table.regions
SELECT city,state
FROM sales.customers
WHERE 	city ILIKE('Z%')
ORDER BY state DESC;


-------------------------- 19. Funções de agregação ----------------------------------
-- COUNT()

-- Contagem de todas as linhas de uma tabela
--(1) Conte todas as visitas realizadas no site da empresa fictícia
SELECT COUNT(*) FROM sales.funnel;


--(2) Conte todos os pagamentos registrados na tabela sales.funnel
SELECT COUNT(paid_date)
FROM sales.funnel;
-- Quando o campo está vazio (NULL), a função COUNT ela não conta esses campos
-- Resultado foi 3788 linhas

SELECT * FROM SALES.funnel
WHERE paid_date IS NULL;
-- Resultado de todos os campos NULL: 26792 linhas


--(3) Contagem distintas de uma coluna
-- Conte todos os produtos distintos visitados em jan/2021
SELECT COUNT(DISTINCT  product_id)
FROM sales.funnel
WHERE visit_page_date BETWEEN '2021-01-01' AND '2021-01-31'
-- Lebrando para contar algo usando o DISTINCT devemos usar ele dentro da função a apontando para qual coluna ele fazerá a conta . Caso o DISTICT seja colocado fora nesse caso ele contará os produtos repetidos
-- 136 produtos sem repetir

SELECT DISTINCT  product_id, visit_page_date 
FROM sales.funnel
WHERE visit_page_date BETWEEN '2021-01-01' AND '2021-01-31'
-- Like não funciona quando estamos falando de datas. Quando tipo primitivo do banco é date
-- 692 linhas

SELECT DISTINCT  product_id, visit_page_date 
FROM sales.funnel
WHERE visit_page_date BETWEEN '2021-01-01' AND '2021-01-31'
-- 692 linhas



-- OUTRAS FUNÇÔES
--(4) Calcule o preço mínimo, máximo e médio dos productos da tabela products
SELECT MIN(price),MAX(price), AVG(price)
FROM sales.products

SELECT MIN(price) AS "Preço minimo", MAX(price) AS "Price Maximo", AVG(price) AS "Preço medio de todos os Produtos"
FROM sales.products

--(5) Informe qual é o veículo mais caro da tabela products
SELECT MAX(price) 
FROM sales.products;

SELECT * FROM sales.products
WHERE price = (SELECT MAX(price) 
FROM sales.products);


--RESUMO
--(1) Servem para executar operações aritmética nos registros de uma coluna
--(2) Funções agregadas não computam cédulas vazias (NULL) como zero
--(3) Na função COUNT() pode-se utilizar o asterisco (*) para contar os registros
--(4) COUNT(DISTINCT) irá contar apenas os valores exclusivos


---------------------------------------------20. GROUP BY--------------------------------
-- Contagem agrupada de uma coluna
-- (1) Calcule o n» de cliente da tabela customers por estado
SELECT COUNT(*) FROM sales.customers;

SELECT state , COUNT(*) as contagem FROM sales.customers
GROUP BY state
ORDER BY contagem DESC;


-- (2) Contagem agrupada de varias colunas
-- Calcule o n« de clientes por estado e status profissional
SELECT state , professional_status,COUNT(*) as contagem FROM sales.customers
GROUP BY state, professional_status
ORDER BY contagem DESC;


SELECT state , professional_status,COUNT(*) as contagem FROM sales.customers
GROUP BY 1, 2
ORDER BY contagem DESC;



-- (3) Seleção de valores distintos
-- Selecione os estados distintos na tabela customers utilizando o group by
SELECT state FROM sales.customers
GROUP BY state;

SELECT DISTINCT state
FROM sales.customers
GROUP BY state;

/*
OBS: Tanto o comando de cima como o comando de baixo entrega os mesmo dados e Quantidade
Pois, o comando GROUP BY quando é usado sozinho ele funciona como um comando DISTINCT e também sua funcionalidade. Mas é sempre bom
usar o comando DISTINCT por boas práticas
*/

--RESUMO
-- (1) Serve para agrupar registros semelhante de uma coluna
-- (2) Normalmente utilizado em conjunto com as funções de agregação
-- (3) Pode-se referenciar a coluna a ser agrupada pela sua posição ordinal
--     Ex: GROUP BY 1,2,3 irá agrupar pelas 3 primeiras colunas da tabela
-- (4) O GROUP BY sozinho funciona como um DISTINCT, eliminando linha duplicadas


----------------------------------------21. HAVING--------------------------------
-- OBS: A função HAVING serve tanto para fazer um filtro em colunas agregadas e não agregadas
-- (1#) Seleção com filtro no HAVING
-- Calcule o nª de clientes por estado filtrando apenas estados acima de 100 clientes
SELECT state,
       COUNT(*)
FROM sales.customers
-- WHERE COUNT(*) > 100     --Comando WHERE não funciona quando temos que filtrar em funções agregadas. Utilizamos HAVING
GROUP BY state
HAVING COUNT(*) > 100;


SELECT state,
       COUNT(*)
FROM sales.customers
GROUP BY state
HAVING COUNT(*) > 220;

--

-- (1) Seleção com filtro no HAVING e WHERE
-- Calcule o nª de clientes por estado diferente  de MG e filtrando apenas estados acima de 100 clientes
SELECT state, COUNT(*)
FROM sales.customers
WHERE state <> 'MG'
GROUP BY state
HAVING COUNT(*) > 100;


-- (1##) Seleção com filtro no HAVING e WHERE
-- Calcule o nª de clientes por estado diferente  de MG e filtrando apenas estados acima de 100 clientes. Colocando em ordem organizada pela coluna state
SELECT state, COUNT(*)
FROM sales.customers
WHERE state <> 'MG'
GROUP BY state
HAVING COUNT(*) > 100 OR COUNT(*) = 1
ORDER BY COUNT(*)


-- RESUMO
-- (1) Tem a mesma função do WHERE mas pode ser usado para filtrar os resultados
-- das funções agregadas enquanto o WHERE possui essa limitação
-- (2) A função HAVING também pode filtrar colunas não agregadas


----------------------------------------22. Desafio--------------------------------

-- (Exercício 1) Conte quantos clientes da tabela sales.customers tem menos de 30 anos
SELECT  COUNT(*)  AS "Quantidade de Clientes"
FROM sales.customers;
--  Resultado: 25109


-- (Exercício 2) Informe a idade do cliente mais velho e mais novo da tabela sales.customers
SELECT MIN(EXTRACT(YEAR FROM AGE(current_date, birth_date))) AS "IDADE MINIMA"
FROM sales.customers;
--I A função "EXTRACT()" é usada para extrair o ano da diferença entre a data atual e a data de nascimento, que é calculada pela função "AGE()".
--II A função "AGE()" retorna a diferença entre a data atual (current_date) e a data de nascimento (birth_date) em anos, meses e dias. No entanto, a função "EXTRACT()" é usada 


-- (Exercício 3) Selecione todas as informações do cliente mais rico da tabela sales.customers
-- (possívelmente a resposta contém mais de um cliente)

SELECT customer_id, name, email, MAX(score) AS max_score
FROM sales.customers
GROUP BY customer_id, name, email
HAVING MAX(score) = (SELECT MAX(score) FROM sales.customers);
/*
Nessa consulta, a cláusula HAVING foi adicionada para filtrar os 
resultados para mostrar somente as linhas com o valor máximo de score. A função MAX(score) 
é usada para obter o valor máximo de score na tabela "customers". A cláusula HAVING é usada 
para filtrar os resultados para mostrar somente as linhas que possuem o valor máximo de score. Note que
a cláusula HAVING deve ser usada depois da cláusula GROUP BY, para filtrar os resultados após o agrupamento.
*/

-- (Exercício 4) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- Ordene o resultado pelo nome da marca
SELECT COUNT(*) AS "Quantidade de Carros", brand
FROM sales.products
GROUP BY brand
ORDER BY brand DESC;


-- (Exercício 5) Conte quantos veículos existem registrados na tabela sales.products
-- por marca e ano do modelo. Ordene pela nome da marca e pelo ano do veículo
SELECT COUNT(*)  AS "Qtd_veículo", brand, model_year
FROM sales.products
GROUP BY brand, model_year;


-- (Exercício 6) Conte quantos veículos de cada marca tem registrado na tabela sales.products
-- e mostre apenas as marcas que contém mais de 10 veículos registrados
SELECT COUNT(*)  AS "Qtd_veículo", brand, model_year
FROM sales.products
GROUP BY brand, model_year
HAVING COUNT(*) >  10;
-- 0  Linhas, pois não tem marcas que contém mais de 10 veículos registrados



----------------------------------------24. Tipos de JOIN--------------------------------
-- (1) Utilize o LEFT JOIN para fazer JOIN entre as tabelas:  temp_tables_1 , temp.tamble_2
SELECT * FROM temp_tables.tabela_1;
SELECT * FROM temp_tables.tabela_2;

SELECT t1.cpf,t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
LEFT JOIN temp_tables.tabela_2 AS t2
ON t1.cpf = t2.cpf;

/*O comando LEFT JOIN é utilizado para combinar duas tabelas baseado em uma coluna em comum entre elas, 
chamada de chave primária.

Note que o uso do LEFT JOIN é útil quando se quer retornar todas as linhas da tabela da esquerda
(temp_tables.tabela_1) e apenas as linhas da tabela da direita (temp_tables.tabela_2) que correspondem 
à condição de junção especificada. Se não houver correspondência, a coluna da tabela da direita será 
preenchida com valores nulos (NULL).*/

-- (2) Utilize o INNER JOIN para fazer JOIN entre as tabelas:  temp_tables_1 , temp.tamble_2
SELECT t1.cpf,t1.name, t2.state
FROM temp_tables.tabela_1 AS t1
INNER JOIN temp_tables.tabela_2 AS t2
ON t1.cpf = t2.cpf;

/*Ao usar o INNER JOIN, apenas as linhas que possuem correspondência em ambas as tabelas serão 
retornadas. Em outras palavras, a junção ocorrerá apenas quando houver valores em ambas as 
tabelas que sejam iguais na coluna "cpf"

É importante lembrar que o INNER JOIN é uma junção bastante utilizada quando queremos buscar 
informações que só existem nas duas tabelas e não queremos perder dados. Caso não haja 
correspondência na tabela 2, a linha correspondente da tabela 1 não será retornada.*/

-- (3) Utilize o  RIGHT JOIN para fazer JOIN entre as tabelas:  temp_tables_1 , temp.tamble_2
SELECT * FROM temp_tables.tabela_2;
SELECT * FROM temp_tables.tabela_1;

SELECT t1.cpf,t1.name, t2.cpf, t2.state	
FROM temp_tables.tabela_1 AS t1
RIGHT JOIN temp_tables.tabela_2 AS t2
ON t1.cpf = t2.cpf;

/*A cláusula RIGHT JOIN é utilizada para selecionar todas as linhas da tabela à 
direita (tabela_2) e as correspondentes da tabela à esquerda (tabela_1), quando houver
uma correspondência na chave primária definida na condição ON.

No exemplo fornecido, a consulta irá selecionar todas as linhas da tabela_2 e as 
correspondentes da tabela_1 onde a chave primária (cpf) é a mesma em ambas as tabelas.

O resultado final terá quatro colunas: cpf e name da tabela_1 e cpf e state da tabela_2. 
Se não houver correspondência entre as tabelas, os valores da tabela_1 serão nulos.*/

-- (4) Utilize o  FULL JOIN para fazer JOIN entre as tabelas:  temp_tables_1 , temp.tamble_2
SELECT t1.cpf,t1.name, t2.cpf, t2.state	
FROM temp_tables.tabela_1 AS t1
FULL JOIN temp_tables.tabela_2 AS t2
ON t1.cpf = t2.cpf;

/*O FULL JOIN é uma combinação de LEFT JOIN e RIGHT JOIN, que retorna todas as linhas
de ambas as tabelas, incluindo as que não possuem correspondências nas outras tabelas. Quando 
uma linha não possui correspondência na outra tabela, os valores NULL são retornados para
as colunas da tabela ausente.*/


------------------------------------------25. Exemplos---------------------------------
--------------------------------------Exercícios----------------------------------
-- EXERCÍCIOS ########################################################################


-- (Exemplo 1) Identifique qual é o gênero mais frequente nos clientes que compraram
-- automóveis no site. Obs: Utilizar a tabela temp_tables.ibge_genders
SELECT * FROM temp_tables.ibge_genders LIMIT 10;

SELECT cus.professional_status,
       COUNT(fun.paid_date) AS pagamentos
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id
GROUP BY cus.professional_status
ORDER BY pagamentos DESC;


-- (Exemplo 2) Identifique de quais regiões são os clientes que mais visitam o site
-- Obs: Utilizar a tabela temp_tables.regions
SELECT * FROM temp_tables.ibge_genders LIMIT 10;

SELECT ibge.gender,
       COUNT(fun.paid_date)
FROM sales.funnel AS fun
LEFT JOIN sales .customers AS cus
ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.ibge_genders AS ibge
ON LOWER(cus.first_name) = ibge.first_name
GROUP BY ibge.gender;


-- (Exemplo 3) Identifique de quais regiões são os clientes que mais visitam o site 
-- obs: Utilizar a tabela temp_tables.regions
SELECT * FROM sales.customers LIMIT 10;
SELECT * FROM temp_tables.regions LIMIT 10;

SELECT reg.region,
    COUNT(fun.visit_page_date) AS visitas
FROM sales.funnel AS fun
LEFT JOIN sales.customers AS cus
    ON fun.customer_id = cus.customer_id
LEFT JOIN temp_tables.regions AS reg 
    ON LOWER(cus.city) = LOWER(reg.city) AND LOWER(cus.state) = LOWER(reg.state)
GROUP BY reg.region
ORDER BY visitas DESC;


--------------------------------------------26. Desafio-------------------------------------
-- EXERCÍCIOS ########################################################################
-- (Exercício 1) Identifique quais as marcas de veículo mais visitada na tabela sales.funnel
SELECT pro.brand,
	   COUNT(*) AS visitas
FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
	ON fun.product_id = pro.product_id
GROUP BY pro.brand
ORDER BY visitas DESC;


-- (Exercício 2) Identifique quais as lojas de veículo mais visitadas na tabela sales.funnel
SELECT sto.store_name,
	   COUNT(*) AS visitas
FROM sales.funnel AS fun
LEFT JOIN sales.stores AS sto
	ON fun.store_id = sto.store_id
GROUP BY sto.store_name
ORDER BY visitas DESC;

-- (Exercício 3) Identifique quantos clientes moram em cada tamanho de cidade (o porte da cidade
-- consta na coluna "size" da tabela temp_tables.regions)
SELECT
	reg.size,
	COUNT(*) AS contagem
FROM sales.customers AS cus
LEFT JOIN temp_tables.regions AS reg
	ON LOWER(cus.city) = lower(reg.city) AND LOWER(cus.state) = LOWER(reg.state)
GROUP BY reg.size
ORDER BY contagem;

--------------------------------------------28. Tipos de Union-------------------------------------

/********************************UNION
UNION: A cláusula UNION em SQL é usada para combinar o resultado de duas
ou mais consultas SQL em um único conjunto de resultados. É importante notar 
que a cláusula UNION só é usada para combinar resultados de consultas que têm a 
mesma estrutura de coluna, ou seja, as mesmas colunas e tipos de dados.
Nessa sintaxe, as duas consultas selecionam as mesmas colunas de duas tabelas 
diferentes (table1 e table2)e as combinam em um único conjunto de resultados.

A cláusula UNION remove automaticamente quaisquer linhas duplicadas que aparecem nos resultados 
de ambas as consultas. Se você quiser incluir essas linhas duplicadas, use a cláusula UNION ALL em 
vez de UNION.
*/

SELECT column1, column2, ... FROM table1
UNION
SELECT column1, column2, ... FROM table2


/******************************UNION ALL
 UNION ALL: A cláusula UNION ALL em SQL é semelhante à cláusula UNION, mas não remove as
 linhas duplicadas que aparecem nos resultados de ambas as consultas. Em vez disso, a cláusula 
 UNION ALL combina todos os resultados das consultas, incluindo as linhas duplicadas.

 Nessa sintaxe, as duas consultas selecionam as mesmas colunas de duas tabelas diferentes (table1 e table2) e as combinam em um único conjunto de resultados, sem remover as linhas duplicadas.

A cláusula UNION ALL pode ser útil em casos em que você deseja incluir todas as linhas das duas consultas,
mesmo que existam linhas duplicadas. Isso pode ser útil, por exemplo, ao combinar dados de várias fontes 
ou ao realizar análises de dados em que as linhas duplicadas podem ser importantes para a análise.

No entanto, é importante lembrar que a cláusula UNION ALL pode resultar em um conjunto de resultados 
maior do que o necessário, o que pode afetar negativamente o desempenho da consulta. Portanto, é 
importante avaliar cuidadosamente se a cláusula UNION ALL é apropriada para sua situação específica.
*/
SELECT column1, column2, ... FROM table1
UNION ALL
SELECT column1, column2, ... FROM table2

--------------------------------------------29. Exemplos-------------------------------------
-- (Exemplo 1) União simples de duas tabelas 
-- Uma tabela sales.products com a tabela temp_tables.products_2

SELECT * FROM sales.products;
SELECT * FROM  temp_table.products_2;

SELECT * FROM sales.products
UNION ALL
SELECT * FROM  temp_tables.products_2;


--------------------------------------------30. Tipos de Subquery-------------------------------------
-- PARA QUE SERVE 
-- Servem para consultar dados de outras consultas

-- TIPOS
-- Subquery no WHERE 
-- Subquery com WITH
-- Subquery no FROM
-- Subquery no SELECT

-- EXEMPLOS 
-- (Exemplo 1) Subquery no WHERE
-- Informe qual é o veículo mais barato da tabela products
SELECT *
FROM sales.products
WHERE price = (SELECT MIN(price) FROM sales.products);

SELECT MIN(price) FROM sales.products;

-- (EXEMPLO 2) Subquery com WITH
-- Calcular a idade média dos clientes por status profissional
-- Utilizamos o if para podermos fazer como se fosse um group by com utilizando uma funções de agregacões.Mas devemos sempre utlizar duas colunas/mesma QTD

--(ETAPA 1)
SELECT professional_status,
       (current_date - birth_date)/365 AS idade
FROM sales.customers;

--(ETAPA 2) Essa etapa eu montei uma nova "tabela" para poder deixar no jeito para colocar dentro do WITH. Esse comando executado sozinho não funciona
SELECT professional_status,
       AVG(idade) AS Idade Media
FROM alguma_tabela
GROUP BY professional_status;


--(ETAPA 3)
WITH alguma_tabela AS(
SELECT professional_status,
       (CURRENT_DATE - birth_date)/365 AS idade
FROM sales.customers
)
SELECT professional_status,
       AVG(idade) AS idade_media
FROM alguma_tabela
GROUP BY professional_status;
--Obs: O comando WITH conseguimos utilizar os resultados de uma subquery em uma query que foi escrita posteriomente
-- Comando WITH é muito utilizado em  análise de dados 


-- (EXEMPLO 3) Subquery no FROM
-- Calcule a idades  media dos clientes por status profissional
SELECT
    professional_status, 
    AVG(idade) AS idade_media
FROM (
    SELECT 
    professional_status,
    (CURRENT_DATE - birth_date)/365 AS idade
    FROM sales.customers
) AS alguma_tabela
GROUP BY professional_status;
-- Tem a mesma função do WITH porém não é aconselhado fazer dessa forma. Com WITH fica muito mais legível


-- (EXEMPLO 4) Subquery no SELECT
-- Na tabela sales.funnel crie uma coluna que informe o nº de visitas acumuladas
-- que a loja visitada recebeu até o momento
SELECT 
    fun.visit_id, -- Coluna que identifica a visita
    fun.visit_page_date, -- Coluna que informa a data que foi feita essa vísita
    sto.store_name, -- Coluna que informa o nome da loja que está sendo visitada 
    ( SELECT COUNT(*) -- Dentro dessa subquery estarei trazendo uma coluna que me informa quantas visitas a loja recebeu até a data daquela visit_page_date 
        FROM sales.funnel AS fun2
        WHERE fun2.visit_page_date  <= visit_page_date -- Só irei contar as linhas da tabela sales.funnel cuja a data da visita  <= a data da visita atual 
        AND fun2.store_id = fun.store_id -- E essa contagem vai ser apenas por loja
    ) AS visitas_acumuladas
FROM sales.funnel AS fun
LEFT JOIN sales.stores AS sto -- Para pegar o nome da loja
    ON fun.store_id = sto.store_id
ORDER BY sto.store_name, fun.visit_page_date;

-- RESUMO 
-- (1) Servem para consultar dados de outros consultados.
-- (2) Para que as subqueries no WHERE e no SELECT funcionem, elas devem retornar apenas um único valor
-- (3) Não é recomendado utilizar subqueries diretamente dentro do FROM pois isso dificuta a legibilidade da query



--------------------------------------------31. EXEMPLOS Tipos de Subquery-------------------------------------
-- (Exemplos 1) Análise de recorrência dos leads
-- Calcule o volume de visitas por dia ao site separado por 1º visita e demais vísitas

WITH primeira_visita AS (

    SELECT customer_id,MIN(visit_page_date) AS visit_1
    FROM sales.funnel
    GROUP BY customer_id
)
SELECT
    fun.visit_page_date,
    (fun.visit_page_date <> primeira_visita.visit_1) AS lead_recorrente,
    COUNT(*)
FROM sales.funnel AS fun
LEFT JOIN primeira_visita
    ON fun.customer_id = primeira_visita.customer_id
GROUP BY fun.visit_page_date, lead_recorrente
ORDER BY fun.visit_page_date DESC, lead_recorrente;


-- (EXEMPLO 2 ) Análise do preço versus o preço médio
-- Calcule, para cada visita ao site, quanto o preço do um veículo visitado pelo cliente
-- estava acima ou baixo do preço médio dos veículos daquela marca
-- (levar em consideração o desconto dado no veículo)

WITH preco_medio AS (
    SELECT brand, AVG(price) AS preco_medio_da_marca
    FROM sales.products
    GROUP BY brand
)
SELECT fun.visit_id,
       fun.visit_page_date,
       pro.brand,
       (pro.price * (1 + fun.discount)) AS preco_final,
       preco_medio.preco_medio_da_marca,
       (pro.price * (1 + fun.discount)) - preco_medio.preco_medio_da_marca AS preco_vs_media
FROM sales.funnel AS fun
LEFT JOIN sales.products AS pro
    ON fun.product_id = pro.product_id
LEFT JOIN preco_medio
    ON pro.brand = preco_medio.brand



 --------------------------------------------SEÇÃO 9 - TRAYAMENTO DE DADOS -------------------------------------
    --33. Guia de comandos
-------------------------------------------- 34. Conversão de unidades ----------------------------------------
    
--(EXEMPLO 1) Conversão de texto em data
-- Corrija a query abaixo utilizando o operador ::
    SELECT '2021-10-01'::date - '2021-02-01'::date;

-- (Exemplo 2 ) Conversão de texto em número
-- Corrija a query abaixo utilizando o operador ::
SELECT '100'::numeric - '10'::numeric;


-- (Exemplo 3) Conversão de número em texto
-- Corrija a query abaixo utilizado o operador :: 
SELECT REPLACE(112122::text,'1','A')

-- (Exemplo 4) Conversão de texto em data
-- Corrija a query abaixo utilizando a função CAST
SELECT CAST('2021-10-01' AS date) - CAST('2021-02-01' AS date);


-- RESUMO
-- (1) O perador :: e o CAST() são funções utilizadas para converter um dado para a unidade desejada.
-- (2) O operador :: é mais "clean", porém, em algumas ocasiões não funciona, sendo necessário utilizar a função CAST()
-- (3) Use o Guia de comandos para consultar a lista de unidades mais utilizadas 




