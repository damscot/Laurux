-- Jeu partagé Btqart : table de travail Art_Saisis avec une ligne périmée (doit être recréée vide à l'ouverture),
-- photos des articles 001 (chemin avec espace) et 002, article 901 de famille ZZ absente de Fiches_Fam.
CREATE TABLE Art_Saisis (code char(15) NOT NULL, PRIMARY KEY (code)) ENGINE=InnoDB;
INSERT INTO Art_Saisis (code) VALUES ('PERIME');
UPDATE Fiches_Art SET art_photo = '/tmp/photos/img 1.jpg' WHERE art_code = '001';
UPDATE Fiches_Art SET art_photo = '/tmp/photos/img2.jpg' WHERE art_code = '002';
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_tva, art_pvht, art_paht) VALUES ('901', 'Article sans famille', 'ZZ', '401001', '3', 10, 5);
