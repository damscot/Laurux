-- Jeu ETIGOND : format « Z- Test » (sans mot-clé), articles de stock variés, poids et unité pour le prix au kg.
-- 001 stocké qté 0 ; 002 stocké qté 0,5 ; 003 non stocké ; 004 stocké qté 3 ; 005 sans étiquette (art_etiq 0).
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Portrait');
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_poids = 0.5, art_vol = 'kg', art_cfour = 'REF001', art_casier = 'B2' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0.5, art_poids = 2, art_vol = 'l', art_cfour = 'REF002', art_casier = 'A1' WHERE art_code = '002';
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cfour, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte, art_etiq, art_casier, art_poids, art_vol) VALUES ('004', 'Article stock trois', 'Second libelle', '01', '401001', 'REF004', '3000000000004', 10, '3', 12, '2', 1, 3, 1, 'C1', 1, 'kg');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cfour, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte, art_etiq, art_casier, art_poids, art_vol) VALUES ('005', 'Article sans etiquette', '', '02', '401001', '', '', 5, '3', 6, '2', 0, 0, 0, 'A9', 0, '');
