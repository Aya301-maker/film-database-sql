-- Création des tables
CREATE TABLE categorie (
    id_categorie INT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);

CREATE TABLE film (
    id_film INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    date_sortie DATE,
    id_categorie INT,
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

CREATE TABLE acteur (
    id_acteur INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL
);

CREATE TABLE film_acteur (
    id_film INT,
    id_acteur INT,
    PRIMARY KEY (id_film, id_acteur),
    FOREIGN KEY (id_film) REFERENCES film(id_film),
    FOREIGN KEY (id_acteur) REFERENCES acteur(id_acteur)
);

-- Insertion des données
INSERT INTO categorie VALUES (1, 'SF');
INSERT INTO categorie VALUES (2, 'Western');
INSERT INTO categorie VALUES (3, 'Drame');
INSERT INTO categorie VALUES (4, 'Comédie');

INSERT INTO acteur VALUES (1, 'Pitt', 'Brad');
INSERT INTO acteur VALUES (2, 'Clooney', 'George');
INSERT INTO acteur VALUES (3, 'DiCaprio', 'Leonardo');
INSERT INTO acteur VALUES (4, 'Robbie', 'Margot');
INSERT INTO acteur VALUES (5, 'Jolie', 'Angelina');
INSERT INTO acteur VALUES (6, 'Johansson', 'Scarlett');

INSERT INTO film VALUES (1, 'Interstellar', '2014-11-07', 1);
INSERT INTO film VALUES (2, 'Ocean''s Eleven', '2001-12-07', 4);
INSERT INTO film VALUES (3, 'Fight Club', '1999-10-15', 3);
INSERT INTO film VALUES (4, 'Gravity', '2013-10-04', 1);
INSERT INTO film VALUES (5, 'The Assassination of Jesse James', '2007-09-21', 2);
INSERT INTO film VALUES (6, 'Inception', '2010-07-16', 1);
INSERT INTO film VALUES (7, 'Seven', '1995-09-22', 3);
INSERT INTO film VALUES (8, 'The Matrix', '1999-03-31', 1);
INSERT INTO film VALUES (9, 'Django Unchained', '2012-12-25', 2);
INSERT INTO film VALUES (10, 'The Proposal', '2009-06-19', 4);

INSERT INTO film_acteur VALUES (1, 1);
INSERT INTO film_acteur VALUES (1, 2);
INSERT INTO film_acteur VALUES (2, 1);
INSERT INTO film_acteur VALUES (2, 2);
INSERT INTO film_acteur VALUES (2, 3);
INSERT INTO film_acteur VALUES (3, 1);
INSERT INTO film_acteur VALUES (4, 2);
INSERT INTO film_acteur VALUES (5, 3);
INSERT INTO film_acteur VALUES (6, 1);
INSERT INTO film_acteur VALUES (7, 3);
INSERT INTO film_acteur VALUES (8, 6);
INSERT INTO film_acteur VALUES (9, 5);
INSERT INTO film_acteur VALUES (10, 4);

-- Requête 1 : Films SF avec Brad Pitt et George Clooney
SELECT nom
FROM film
WHERE id_categorie = 1
  AND id_film IN (SELECT id_film FROM film_acteur WHERE id_acteur = 1)
  AND id_film IN (SELECT id_film FROM film_acteur WHERE id_acteur = 2);

-- Requête 2 : Acteurs ayant joué dans Western et Drame
SELECT nom, prenom
FROM acteur
WHERE id_acteur IN (
    SELECT id_acteur FROM film_acteur WHERE id_film IN (
        SELECT id_film FROM film WHERE id_categorie = 2
    )
)
AND id_acteur IN (
    SELECT id_acteur FROM film_acteur WHERE id_film IN (
        SELECT id_film FROM film WHERE id_categorie = 3
    )
);

-- Requête 3 : Nombre de films par catégorie
SELECT c.libelle AS Categorie,
       COUNT(*) AS NbFilms
FROM categorie c, film f
WHERE c.id_categorie = f.id_categorie
GROUP BY c.libelle;
