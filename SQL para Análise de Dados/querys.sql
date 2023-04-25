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


