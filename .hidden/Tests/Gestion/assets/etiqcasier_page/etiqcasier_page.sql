-- Jeu ETIQCASIER-T02 : jeu etiqart_base + format Z également en A4 Paysage (même code, deux pages).
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Portrait');
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0 WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0.5 WHERE art_code = '002';
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte, art_etiq, art_casier) VALUES ('004', 'Article stock trois', 'Second libelle', '01', '401001', '3000000000004', 10, 20, 12, '2', 1, 3, 1, 'C1');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd, art_stocke, art_qte, art_etiq, art_casier) VALUES ('005', 'Article sans etiquette', '', '02', '401001', '', 5, 20, 6, '2', 0, 0, 0, 'A9');
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 4, 5, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Paysage');
