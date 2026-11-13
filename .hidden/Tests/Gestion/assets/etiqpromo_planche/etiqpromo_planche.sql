-- ETIQPROMO-T04 : format « Z- Test » avec espace en largeur (50) et promotion P5 de 9 articles (27 étiquettes).
INSERT INTO Fiches_Etiquettes (code, nblargeur, nbhauteur, largeur, hauteur, mrghaut, mrgauche, esplargeur, esphauteur, libelle, page) VALUES ('Z', 3, 8, 600, 370, 0, 0, 50, 0, 'Test', 'A4 Portrait');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P5', 'Promo planche', '2018-06-01', '2018-06-30');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('007', 'Article 007', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('008', 'Article 008', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('009', 'Article 009', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('010', 'Article 010', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('011', 'Article 011', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_Art (art_code, art_design, art_design2, art_fam, art_four, art_cbarre, art_pvht, art_tva, art_pvttc, art_nbd) VALUES ('012', 'Article 012', '', '01', '401001', '', 10, '3', 12, '2');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '001', 'Article 001', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '002', 'Article 002', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '003', 'Article 003', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '007', 'Article 007', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '008', 'Article 008', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '009', 'Article 009', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '010', 'Article 010', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '011', 'Article 011', 5, 9, 10.80, 0);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P5', '012', 'Article 012', 5, 9, 10.80, 0);
