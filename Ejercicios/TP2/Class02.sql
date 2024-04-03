DROP DATABASE IF EXISTS IMDB;
CREATE DATABASE IF NOT EXISTS IMDB;
USE IMDB;

CREATE TABLE IF NOT EXISTS Film(
ID INT AUTO_INCREMENT PRIMARY KEY,
Title VARCHAR(255),
Descriptionn TEXT,
Releaseyear DATETIME,
Lastupdate DATETIME
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS Actor(
ID INT AUTO_INCREMENT PRIMARY KEY,
Firstname VARCHAR(255),
Lastname VARCHAR(255),
Lastupdate DATETIME
)ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS FilmXActor(
IDFilm INT AUTO_INCREMENT NOT NULL,
IDActor INT AUTO_INCREMENT NOT NULL,
PRIMARY KEY(IDFilm, IDActor)
)ENGINE=INNODB;

ALTER TABLE Film ADD COLUMN Lastupdate DATETIME;
ALTER TABLE Actor ADD COLUMN Lastupdate DATETIME;
 
ALTER TABLE FilmXActor
ADD CONSTRAINT FK_FilmXActor_Film FOREIGN KEY (IDFilm) REFERENCES Film(ID),
ADD CONSTRAINT FK_FilmXActor_Actor FOREIGN KEY (IDActor) REFERENCES Actor(ID);

INSERT INTO Film (Title, Descriptionn, Releaseyear) VALUES
('Pulp Fiction', 'A crime film with multiple intertwined stories.', '1994-10-14'),
('The Shawshank Redemption', 'A story of hope and friendship in prison.', '1994-09-23'),
('The Godfather', 'A mafia family saga.', '1972-03-24');

INSERT INTO Actor (Firstname, Lastname) VALUES
('John', 'Travolta'),
('Tim', 'Robbins'),
('Marlon', 'Brando');

INSERT INTO FilmXActor (IDFilm, IDActor) VALUES
(1, 1),
(1, 3),
(2, 2);


