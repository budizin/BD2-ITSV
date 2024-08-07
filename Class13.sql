USE sakila;

INSERT INTO customer(store_id, address_id, first_name, last_name, email)
VALUES(
    1,
    (SELECT MAX(address_id) 
     FROM address a 
     INNER JOIN city c ON c.city_id = a.city_id 
     INNER JOIN country co ON c.country_id = co.country_id 
     WHERE co.country = 'Canada'),
    'MARIA INSERTADA',
    'INSERTADA',
    'MARIA.INSERTADA@gmail.com'
);

INSERT INTO rental (rental_date, inventory_id, staff_id, customer_id)
VALUES(
    NOW(),
    (SELECT inventory_id FROM inventory i INNER JOIN film f ON f.film_id = i.film_id WHERE f.title = 'ACADEMY DINOSAUR' LIMIT 1),
    (SELECT MAX(staff_id) FROM staff WHERE store_id = 2),
    4
);

UPDATE film
SET release_year = '2015'
WHERE rating = 'G';

UPDATE film
SET release_year = '2016'
WHERE rating = 'PG';

UPDATE film
SET release_year = '2017'
WHERE rating = 'NC-17';

UPDATE film
SET release_year = '2018'
WHERE rating = 'PG-13';

UPDATE film
SET release_year = '2019'
WHERE rating = 'R';

SELECT * FROM film ORDER BY rating;

UPDATE rental 
SET return_date = NOW()
WHERE rental_id = (SELECT MAX(rental_id) FROM rental WHERE return_date IS NULL);

SELECT * FROM rental WHERE rental_id = (SELECT MAX(rental_id) FROM rental WHERE return_date IS NOT NULL);

DELETE FROM film WHERE film_id = 2;

DELETE FROM film_actor WHERE film_id = 2;
DELETE FROM film_category WHERE film_id = 2;
DELETE FROM rental WHERE inventory_id IN (SELECT inventory_id FROM inventory WHERE film_id = 2);
DELETE FROM inventory WHERE film_id = 2;
DELETE FROM film WHERE film_id = 2;

SELECT * FROM film ORDER BY film_id ASC;

SELECT inventory_id 
FROM inventory i 
LEFT OUTER JOIN rental r USING(inventory_id) 
WHERE r.rental_id IS NULL 
LIMIT 1;

INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (
    NOW(), 
    (SELECT inventory_id FROM inventory i LEFT OUTER JOIN rental r USING(inventory_id) WHERE r.rental_id IS NULL LIMIT 1), 
    (SELECT customer_id FROM customer LIMIT 1), 
    (SELECT staff_id FROM staff LIMIT 1)
);

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM rental WHERE inventory_id = (SELECT inventory_id FROM inventory i LEFT OUTER JOIN rental r USING(inventory_id

