-- Jeu MAJFBTARIF2 : articles 001, 002, 003 à future base tarif au 15.06.2018, sans étiquette ni stock ;
-- 002 avec taux de conversion 1,5 et frais 0,40 (mode net) ; remises, coefficients et TVA variés.
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 10, art_tr = 10, art_txconv = 1, art_frais = 0.5, art_coef = 1.5, art_tva = '3', art_etiq = 0, art_qte = 0 WHERE art_code = '001';
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 20, art_tr = 0, art_txconv = 1.5, art_frais = 0.4, art_coef = 2, art_tva = '1', art_etiq = 0, art_qte = 0 WHERE art_code = '002';
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 7.77, art_tr = 5, art_txconv = 1, art_frais = 0, art_coef = 1.8, art_tva = '2', art_etiq = 0, art_qte = 0 WHERE art_code = '003';
