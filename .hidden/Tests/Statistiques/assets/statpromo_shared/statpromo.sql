-- Jeu StatPromo (lot Statistiques) : promotions et articles en promotion (quantités vendues fixées).
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES
('P1', 'PROMO UN', '2018-03-01', '2018-03-31'),
('P2', 'PROMO DEUX', '2018-04-01', '2018-04-30'),
('P3', 'PROMO NULL', '2018-05-01', '2018-05-31');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES
('P1', 'ART01', 'ARTICLE UN', 1.000, 2.000, 2.400, 10.000),
('P1', 'ART02', 'ARTICLE DEUX', 3.000, 5.000, 6.000, NULL),
('P2', 'ART03', 'ARTICLE TROIS', 4.500, 7.250, 8.700, 3.000),
('P2', 'ART04', 'ARTICLE QUATRE', 10.000, 12.000, 14.400, 2.500),
('P3', 'ART05', 'ARTICLE CINQ', 1.000, NULL, NULL, 1.000);
