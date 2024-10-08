/*
Create a view named list_of_customers, it should contain the following columns:
customer id
customer full name,
address
zip code
phone
city
country
status (when active column is 1 show it as 'active', otherwise is 'inactive')
store id
*/

CREATE OR REPLACE VIEW list_of_customers AS
	SELECT c.customer_id, CONCAT(c.first_name, c.last_name), a.address, a.postal_code, a.phone, ci.city, co.country, s.store_id,
    CASE
		WHEN c.active = 1 THEN 'active'
        ELSE 'inactive'
	END AS 'status'
	FROM customer c
    INNER JOIN store s ON s.store_id = c.store_id
    INNER JOIN address a ON a.address_id = s.address_id
    INNER JOIN city ci ON ci.city_id = a.city_id
    INNER JOIN country co ON co.country_id = ci.country_id;
    
/*
Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT
*/

CREATE OR REPLACE VIEW film_details AS
	SELECT f.film_id, f.title, f.description, f.length, f.rating, GROUP_CONCAT(a.first_name, ' ', a.last_name) as name , c.name
    FROM film f
    INNER JOIN film_category fc ON fc.film_id = f.film_id
    INNER JOIN category c ON c.category_id = fc.category_id
    INNER JOIN film_actor fa ON fa.film_id = f.film_id
    INNER JOIN actor a ON a.actor_id = fa.actor_id
    GROUP BY f.film_id, f.title, f.description, f.length, f.rating, c.name;
    
/*Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.*/
    
CREATE OR REPLACE VIEW sales_by_film_category AS
	SELECT c.name AS category, SUM(p.amount) AS total_rental
	FROM category c
	JOIN film_category fc ON c.category_id = fc.category_id
	JOIN film f ON fc.film_id = f.film_id
	JOIN inventory i ON f.film_id = i.film_id
	JOIN rental r ON i.inventory_id = r.inventory_id
	JOIN payment p ON r.rental_id = p.rental_id
	GROUP BY c.name;
    
    
/*Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.*/
    
CREATE OR REPLACE VIEW actor_information AS
	SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count
	FROM actor a
	JOIN film_actor fa ON a.actor_id = fa.actor_id
	JOIN film f ON fa.film_id = f.film_id
	GROUP BY a.actor_id, a.first_name, a.last_name;

/* Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each. */
    
    
CREATE OR REPLACE VIEW actor_info AS
	SELECT a.actor_id, a.first_name, a.last_name, GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ', f.title) ORDER BY c.name, f.title SEPARATOR '; ') AS film_info, COUNT(f.film_id) AS total_films
	FROM actor a
	LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
	LEFT JOIN film f ON fa.film_id = f.film_id
	LEFT JOIN film_category fc ON f.film_id = fc.film_id
	LEFT JOIN category c ON fc.category_id = c.category_id
	GROUP BY a.actor_id, a.first_name, a.last_name;
    
/*
El query de la vista actor_info selecciona los datos básicos del actor (ID, nombre, apellido) 
y usa GROUP_CONCAT para concatenar las categorías y títulos de las películas en las que ha actuado, 
asegurando que no se repitan y separando cada entrada con punto y coma. 
También cuenta cuántas películas ha hecho cada actor usando COUNT(f.film_id). 
Los LEFT JOIN permiten unir las tablas necesarias (actor, film_actor, film, film_category, category) para obtener toda esta información, 
incluso si un actor no tiene películas asociadas. Finalmente, se agrupan los resultados por actor para consolidar toda la información.
*/

/*
Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.
*/

/*
Las vistas materializadas son objetos de base de datos que almacenan los resultados de consultas en el disco, permitiendo un acceso más rápido a esos datos precomputados. Se utilizan para mejorar el rendimiento en consultas complejas, manejar grandes volúmenes de datos, facilitar análisis y reducir la carga en el servidor.

Como alternativas, existen las vistas normales, que se generan dinámicamente en cada consulta, y las tablas temporales, que requieren manejo manual y no se actualizan automáticamente.

Las vistas materializadas son compatibles con varios sistemas de gestión de bases de datos, 
como Oracle Database, PostgreSQL, SQL Server, MySQL (desde la versión 8.0) e IBM Db2. 
*/
    
    
    
    
    
    
    
    