-- Jeu de données UTILS-T17 (Utils.orientation, option bois), appliqué après Laurux01.sql.
-- Les tables de l'option bois n'existent pas dans Laurux01.sql et leur DDL n'est pas versionné dans le
-- dépôt (création par l'option) : tables minimales limitées aux colonnes lues par orientation.
--   000001 : consigne de type F ; 000002 : BL facturé (F00002) avec une ligne de régie ;
--   000003 : BL non facturé dont la ligne porte un article à droits (art_dra non nul) ; 999999 : rien.
CREATE TABLE Fiches_ligcons (num varchar(10), numlig varchar(6), type char(1), codecons varchar(15),
  nb decimal(9,3), montant decimal(12,3)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
CREATE TABLE Fiches_ligregie (num varchar(10), numlig varchar(6), codeart varchar(15), qte decimal(9,3))
  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
ALTER TABLE Fiches_Art ADD art_dra varchar(10) DEFAULT NULL;
UPDATE Fiches_Art SET art_dra = 'D1' WHERE art_code = '001';
INSERT INTO Fiches_ligcons (num, numlig, type, codecons, nb, montant) VALUES ('000001', 'D', 'F', 'C1', 1, 0.5);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, numfac) VALUES ('000002', 'B', 'C001', 'F00002'), ('000003', 'B', 'C001', NULL);
INSERT INTO Fiches_ligregie (num, numlig, codeart, qte) VALUES ('F00002', '1', '002', 1);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl) VALUES ('000003', '1', '001', '2');
