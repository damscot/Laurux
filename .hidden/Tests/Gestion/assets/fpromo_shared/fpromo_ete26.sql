-- Jeu de données FPROMO-T02/T04/T05 (et FpromoArt) : une promotion ETE26 et deux articles associés (tables vides dans Laurux01.sql).
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('ETE26', 'Promo ete', '2026-06-01', '2026-08-31');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES
('ETE26', '001', 'Produit 2.10', 1.000, 2.000, 2.042, 10.000),
('ETE26', '002', 'Produit 7.00', 1.500, 3.000, 3.210, 5.000);
