-- Jeu ETIQPROMO : format « Z- Test », promotions P1 (001, 002), P2 (002, 003 : 002 en double), P3 vide, P4 (article 999 absent de Fiches_Art).
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 700, 370, 0, 0, 0, 0, 'Test', 'A4 Portrait');
UPDATE Fiches_Art SET art_poids2 = 2, art_vol = 'kg' WHERE art_code = '001';
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P1', 'Promo printemps', '2018-06-01', '2018-06-30');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P2', 'Promo ete', '2018-07-01', '2018-07-31');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P3', 'Promo vide', '2018-08-01', '2018-08-31');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P4', 'Promo orpheline', '2018-09-01', '2018-09-30');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P1', '001', 'Produit 2.10', 5, 18, 18.38, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P1', '002', 'Produit 7.00', 5, 15, 16.05, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P2', '002', 'Produit 7.00', 5, 12, 12.84, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P2', '003', 'produit 20.00', 5, 8, 9.60, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P4', '999', 'Article supprime', 5, 1, 1.20, 0);
