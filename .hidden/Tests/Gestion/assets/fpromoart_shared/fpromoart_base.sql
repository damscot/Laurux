-- Jeu de données FpromoArt : articles 001 et 002 rendus stockés (art_stocke = 0 dans Laurux01.sql, FpromoArt ne retient que les articles stockés),
-- promotion ETE26 avec l'article 001, et une ligne de BL sur l'article 001 (FPROMOART-T05). L'article 003 reste non stocké (T06).
UPDATE Fiches_Art SET art_stocke = 1 WHERE art_code IN ('001', '002');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('ETE26', 'Promo ete', '2026-06-01', '2026-08-31');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('ETE26', '001', 'Produit 2.10', 10.000, 18.000, 18.378, NULL);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl) VALUES ('999999', '1', '001');
