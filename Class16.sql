#1
insert into employees (employeeNumber,lastName,firstName, extension,officeCode,reportsTo,jobTitle,email)
values (9999,"Martinez","Juan","1", 1, 1,"Worker",null);

#Error Column 'email' cannot be null
#Esto ocurre porque el campo email está definido con la restricción NOT NULL, lo que significa que no se permite insertar un valor nulo en esa columna.


#2- Run the first the query
UPDATE employees SET employeeNumber = employeeNumber - 20;
# Se le resta 20 al valor de employeeNumber en todas las filas 

UPDATE employees SET employeeNumber = employeeNumber + 20;

# Se le suma 20 al valor de employeeNumber en todas las filas 

#3- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.
  
alter table employees 
add column age int DEFAULT 16, 
add constraint check_age check (age between 16 and 70);

#Error Code: 3819. Check constraint 'chek_age' is violated.
#Esto sucede porque existen valores que no cumplen con esa condición; al establecer un valor predeterminado, los registros que no cumplen se actualizarán automáticamente con dicho valor.


#4- Describe the referential integrity between tables film, actor and film_actor in sakila db.
/*
La integridad referencial entre esas tablas se establece a través de una clave externa 
que conecta las tablas film y actor mediante una tabla intermedia. Esta tabla intermedia 
almacena las claves primarias de ambas y evita que se elimine un film o un actor sin antes eliminar 
el registro correspondiente en la tabla intermedia.
*/

#5

alter table employees add column lastUpdate datetime default now();
alter table employees add column lastUpdateUser varchar(255) default "root";
select * from employees;

delimiter $$
create trigger before_update_employees
before update on employees
for each row
begin
	set new.lastUpdate=now();
    set new.lastUpdateUser= current_user();
end$$
delimiter ;

delimiter $$
create trigger before_insert_employees
before insert on employees
for each row
begin
	set new.lastUpdate=now();
    set new.lastUpdateUser= current_user();
end$$
delimiter ;

#6

select * from film_text;
select * from film;

#cuando se crea
DELIMITER $$

CREATE TRIGGER ins_film
AFTER INSERT ON film
FOR EACH ROW
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (NEW.film_id, NEW.title, NEW.description);
END$$

DELIMITER ;
#cuando se cambia
DELIMITER $$

CREATE TRIGGER upd_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
    IF (OLD.title != NEW.title) OR (OLD.description != NEW.description) OR (OLD.film_id != NEW.film_id)
    THEN
        UPDATE film_text
            SET title = NEW.title,
                description = NEW.description,
                film_id = NEW.film_id
        WHERE film_id = OLD.film_id;
    END IF;
END$$

DELIMITER ;
#cuando se borra
DELIMITER $$

CREATE TRIGGER del_film
AFTER DELETE ON film
FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = OLD.film_id;
END$$

DELIMITER ;
