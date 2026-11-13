-- Jeu MAJTARIFP : 001 et 002 du fournisseur 401001 (002 avec étiquette et stock 3 : étiquettes préparées),
-- 003 passé au fournisseur 401002 (sélection par la liste).
UPDATE Fiches_Art SET art_etiq = 0, art_qte = 0, art_tr = 10, art_txconv = 1, art_frais = 0.5, art_coef = 1.5 WHERE art_code = '001';
UPDATE Fiches_Art SET art_etiq = 1, art_qte = 3, art_tr = 0, art_txconv = 1, art_frais = 0, art_coef = 2 WHERE art_code = '002';
UPDATE Fiches_Art SET art_four = '401002', art_pbht = 7.77, art_pvht = 12, art_prvt = 7.5, art_tr = 5, art_txconv = 1, art_frais = 0, art_coef = 1.8 WHERE art_code = '003';
