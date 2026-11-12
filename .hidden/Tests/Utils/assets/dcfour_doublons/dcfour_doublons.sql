-- Jeu de données DCFOUR-T01 (Dcfour) : références fournisseurs (art_cfour) en double.
-- REF-A : 001, 002, 003 ; REF-B : D01, D02 ; REF-C : D03 (unique). Articles D0x copiés de l'article 003.
UPDATE Fiches_Art SET art_cfour = 'REF-A' WHERE art_code IN ('001', '002', '003');
CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_art SET art_code = 'D01', art_design = 'Doublon B1', art_cfour = 'REF-B', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = 'D02', art_design = 'Doublon B2', art_cfour = 'REF-B';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = 'D03', art_design = 'Unique C', art_cfour = 'REF-C';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;
