-- Jeu GENINV / SAISIEINV : 6 articles stockés aux familles, fournisseurs, casiers et désignations croisés (l'ordre
-- diffère selon chaque tri), un article non stocké (007), stocks connus ; pas de Fiches_Inv.
-- Articles 004 à 007 copiés de 001.
CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '001';
UPDATE tmp_art SET art_code = '004', art_design = 'Ecrou', art_cbarre = '', art_cequ = 'EQ004', art_refcentrale = 'RC004';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '005', art_design = 'Boulon', art_cbarre = '2000000000053', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '006', art_design = 'Agrafe', art_cbarre = '', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '007', art_design = 'Article non stocke', art_cbarre = '', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '03', art_four = '401002', art_casier = 'B1', art_qte = 10, art_dec = '0' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '01', art_four = '401003', art_casier = 'A1', art_qte = 4, art_dec = '2' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '02', art_four = '401001', art_casier = 'C1', art_qte = 2.5, art_dec = '2' WHERE art_code = '003';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '01', art_four = '401002', art_casier = 'C1', art_qte = 7, art_dec = '3' WHERE art_code = '004';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '03', art_four = '401001', art_casier = 'A1', art_qte = 3, art_dec = '0' WHERE art_code = '005';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '02', art_four = '401003', art_casier = 'B1', art_qte = 6, art_dec = '0' WHERE art_code = '006';
UPDATE Fiches_Art SET art_stocke = 0, art_fam = '01', art_four = '401001', art_casier = 'A1', art_qte = 9 WHERE art_code = '007';
