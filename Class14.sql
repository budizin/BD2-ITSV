#Alejo-Vaquero-DB

#1. Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.

SELECT concat(cu.first_name, ' ', cu.last_name),a.address, ci.city FROM customer cu INNER JOIN address a USING(address_id) INNER JOIN city ci USING(city_id) INNER JOIN country co USING(country_id) where co.country='Argentina';

#Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use CASE.
SELECT title, CASE rating
        WHEN 'G' THEN 'G (General Audiences) – All ages admitted.'
        WHEN 'PG' THEN 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
        WHEN 'PG-13' THEN 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
        WHEN 'R' THEN 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
        WHEN 'NC-17' THEN 'NC-17 (Adults Only) – No one 17 and under admitted.'
        ELSE 'Not Rated'
    END AS rating_formated,
    l.`name` FROM film INNER JOIN `language` l USING(language_id);
    
#Write a search query that shows all the films (title and release year) an actor was part of. 
#Assume the actor comes FROM a text box introduced by hand FROM a web page. 
#Make sure to "adjust" the input text to try to find the films as effectively as you think is possible
SELECT f.title, f.release_year, concat(a.first_name, ' ',a.last_name) as nombre FROM film_actor fa INNER JOIN film f USING(film_id) INNER JOIN actor a USING(actor_id) where lower(concat(a.first_name, ' ',a.last_name)) = lower('PENELOPE GUINESS');

#Find all the rentals done in the months of May and June.
# Show the film title, customer name and if it was returned or not. 
#There should be returned column with two possible values 'Yes' and 'No'.

SELECT f.title, c.first_name, CASE 
WHEN r.return_date  is not null THEN 'Yes'
ELSE 'No' END AS Returned
 FROM rental r 
 INNER JOIN inventory USING(inventory_id)
 INNER JOIN film f USING(film_id)
 INNER JOIN customer c USING(customer_id)
 WHERE MONTH(rental_date)=5 or month(rental_date)=6;
 
 #4 
 #Cast es utilizado para cambiar de un tipo de dato a otro, es mas global, signed es para enteros, unsigned para naturales
 SELECT title, cast(rental_rate as signed) as rental_rate_int FROM film;
 #convert es utilizado para lo mismo pero acepta formateo de fechas y hora
 SELECT title, convert(rental_rate, signed) as rental_rate_int FROM film;
 
 #5
 /*NVL Function(no soportado en mysql)
es usado en sql oraqle para reemplazar null por un valor con la siguiente sintaxis:
NVL(expresion, valor_a_reemplazar)

ISNULL(no soportado en mysql)
es usado en sql server para reemplazar null por un valor con la siguiente sintaxis:
isnull(expresion, valor_a_reemplazar)

IFNULL
es usado en mysql para reemplazar null por un valor con la siguiente sintaxis:
ifnull(expresion, valor_a_reemplazar)

COALESCE
es usado en la mayoria de bases de datos sql para reemplazar el primer null por un valor con la siguiente sintaxis:
coalesce(expresion, expresion2..., valor_a_reemplazar)
*/
SELECT ifnull(rental_rate, 0) AS rental_rate
FROM film;

SELECT COALESCE(rental_rate, 0) AS rental_rate
FROM film;



