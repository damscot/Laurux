-- gridvi : historique de factures sur 2 exercices (2017, 2018) pour les statistiques mensuelles.
-- Client 411003, tournée T1, famille FA01 (sous-famille FA0102), article 001, main d'oeuvre 01.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES
('G00001', '411003', '2017-03-10 00:00:00'),
('G00002', '411003', '2017-11-20 00:00:00'),
('G00003', '411003', '2018-01-15 00:00:00'),
('G00004', '411003', '2018-04-05 00:00:00'),
('G00005', '411004', '2018-04-25 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, mrgart_ligfac, mrgmo_ligfac, fam_ligfac, tour_ligfac, typel_ligfac) VALUES
('G00001', '1', '001', 'Produit', '2', '20,00', '5,00', NULL, 'FA01', 'T1', 'A'),
('G00001', '2', '01', 'Mo', '1,5', '42,00', NULL, '12,00', 'FA01', 'T1', 'M'),
('G00002', '1', '001', 'Produit', '3', '30,00', '7,50', NULL, 'FA0102', 'T1', 'A'),
('G00003', '1', '001', 'Produit', '1', '10,00', '2,50', NULL, 'FA01', 'T1', 'A'),
('G00003', '2', NULL, 'Commentaire', NULL, NULL, NULL, NULL, NULL, NULL, 'C'),
('G00004', '1', '001', 'Produit', '4', '40,00', '10,00', NULL, 'FA0102', 'T1', 'A'),
('G00004', '2', '01', 'Mo', '2', '56,00', NULL, '16,00', 'FA01', 'T1', 'M'),
('G00005', '1', '001', 'Produit', '1', '10,00', '2,50', NULL, 'FA01', 'T2', 'A');
