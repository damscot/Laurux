-- Jeu Consigne : tables de l'option boisson (structure de modfichier.fichierboisson, absentes de Laurux01.sql),
-- trois consignes (palette P1 10,00 ; casier C1 1,50 ; bouteille B1 0,20) et deux lignes de consigne d'achat
-- (bloc BLOC1, ligne 003 : 2 palettes et 5 colis).
CREATE TABLE Fiches_consigne (code char(2), libelle varchar(30), prix decimal(6,2), type char(1), PRIMARY KEY (code));
CREATE TABLE Fiches_ligcons (num char(15), numlig char(12), type char(1), codecons char(2), nb int, montant decimal(8,2), envaleur boolean, bloc varchar(33), code integer NOT NULL AUTO_INCREMENT, PRIMARY KEY (code));
INSERT INTO Fiches_consigne (code, libelle, prix, type) VALUES ('P1', 'Palette', 10.00, 'P'), ('C1', 'Casier', 1.50, 'C'), ('B1', 'Bouteille', 0.20, 'B');
INSERT INTO Fiches_ligcons (num, numlig, type, codecons, nb, montant, envaleur, bloc) VALUES ('R1', '003', 'A', 'P1', 2, 20.00, 1, 'BLOC1'), ('R1', '003', 'A', 'C1', 5, 7.50, 1, 'BLOC1');
