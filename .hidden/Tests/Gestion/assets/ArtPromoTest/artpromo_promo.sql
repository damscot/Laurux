-- Jeu ArtPromoTest : promotions P1 et P2 actives simultanément, deux articles dans P1 (qte renseignée, qte Null),
-- un article de P2 seule, l'article ART9 hors promotion.
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P1', 'Promo ete', '2018-06-01', '2018-06-30');
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('P2', 'Promo juin', '2018-06-10', '2018-06-20');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P1', 'ART1', 'Article un promo', 5.000, 10.500, 12.600, 7.000);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P1', 'ART2', 'Article deux promo', 2.000, 3.333, 4.000, NULL);
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('P2', 'ART3', 'Article trois promo', 1.000, 8.000, 9.600, 0.000);
