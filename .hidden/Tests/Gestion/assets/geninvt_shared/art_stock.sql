-- Jeu GENINVT : aucune table Fiches_InvT (première génération).
-- Articles stockés : 001 (fam 01, four 401001, casier 20, stock 10), 002 (fam 02, four 401002, casier 10, stock 7),
-- 003 (fam 03, four 401001, casier 30, stock 0) ; 004 copie de 003 non stockée (fam 03, casier 15, exclue).
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_casier = '20', art_four = '401001' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7, art_casier = '10', art_four = '401002' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_casier = '30', art_four = '401001' WHERE art_code = '003';
CREATE TEMPORARY TABLE tmp_geninvt AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_geninvt SET art_code = '004', art_design = 'Produit non stocke', art_stocke = 0, art_casier = '15', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_geninvt;
DROP TEMPORARY TABLE tmp_geninvt;
DROP TABLE IF EXISTS Fiches_InvT;
