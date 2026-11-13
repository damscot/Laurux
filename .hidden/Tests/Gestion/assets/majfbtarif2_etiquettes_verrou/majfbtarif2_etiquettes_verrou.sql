-- Jeu MAJFBTARIF2-T02 : 001 sans étiquette ni stock, 002 avec étiquette (art_etiq 1) et stock 4, 003 stock 2.
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 10, art_tr = 10, art_txconv = 1, art_frais = 0.5, art_coef = 1.5, art_tva = '3', art_etiq = 0, art_qte = 0 WHERE art_code = '001';
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 20, art_tr = 0, art_txconv = 1, art_frais = 0, art_coef = 2, art_tva = '1', art_etiq = 1, art_qte = 4 WHERE art_code = '002';
UPDATE Fiches_Art SET art_datefbt = '2018-06-15', art_pbfbt = 7.77, art_tr = 5, art_txconv = 1, art_frais = 0, art_coef = 1.8, art_tva = '2', art_etiq = 0, art_qte = 2 WHERE art_code = '003';
