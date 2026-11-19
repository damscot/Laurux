-- Jeu GENINV-T11 : stocks particuliers (001 Null, 002 négatif, 003 trois décimales) ; pas de Fiches_Inv.
-- Le cas « art_qte vide » n'est pas représentable (colonne double).
UPDATE Fiches_Art SET art_stocke = 1, art_qte = NULL WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = -4.5 WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 2.346 WHERE art_code = '003';
