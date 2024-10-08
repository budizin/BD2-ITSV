/*
For all the exercises include the queries in the class file.

Create two or three queries using address table in sakila db:

include postal_code in where (try with in/not it operator)
eventually join the table with city/country tables.
measure execution time.
Then create an index for postal_code on address table.
measure execution time again and compare with the previous ones.
Explain the results
Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?

Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.
*/

-- Query 1: Select addresses with specific postal codes using IN
SELECT a.address_id, a.address, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code IN ('10001', '90210');

-- Query 2: Select addresses excluding specific postal codes using NOT IN
SELECT a.address_id, a.address, a.postal_code, c.city, co.country
FROM address a
JOIN city c ON a.city_id = c.city_id
JOIN country co ON c.country_id = co.country_id
WHERE a.postal_code NOT IN ('12345', '54321');

-- Create index for postal_code on address table
CREATE  FULLTEXT INDEX  idx_postal_code ON address(postal_code);


SELECT first_name FROM actor WHERE first_name LIKE 'A%';
SELECT last_name FROM actor WHERE last_name LIKE 'A%';

-- Usando LIKE para buscar texto en la descripción de la película
SELECT title, description 
FROM film 
WHERE description LIKE '%action%';

-- Usando MATCH ... AGAINST para búsqueda de texto completo
SELECT title, description 
FROM film 
WHERE MATCH(description) AGAINST('action' IN NATURAL LANGUAGE MODE);

/*
Se comparan dos enfoques para buscar texto en la columna description de la tabla film: uno con LIKE y otro con MATCH ... AGAINST. 
LIKE es más lento, especialmente en textos grandes, ya que puede requerir escaneos completos. 
En cambio, MATCH ... AGAINST está optimizado para búsquedas de texto completo, ofreciendo mejor rendimiento y relevancia en los resultados.
*/



