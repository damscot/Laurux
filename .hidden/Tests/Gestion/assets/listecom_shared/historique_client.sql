-- Listecom : historique d'achats de clients (appliqué après Laurux01.sql, tables d'historique vides).
-- 411003 : 12 dates d'achat (8 factures, 4 BL), un BL à totalht 0 (exclu), une facture et un BL « M » (Fiches_HistoFacM,
--          Fiches_BlM) aux dates d'une facture ; lignes A (001, 002, ZZZ absent de Fiches_Art/Fiches_Mo), M (01) et C.
-- 411004 : 3 factures dont celle du 2018-05-10 ne contient que des lignes de commentaire (C).
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES
('F00001', '411003', '2018-01-05 00:00:00'),
('F00002', '411003', '2018-02-05 00:00:00'),
('F00003', '411003', '2018-03-05 00:00:00'),
('F00004', '411003', '2018-04-05 00:00:00'),
('F00005', '411003', '2018-05-05 00:00:00'),
('F00006', '411003', '2018-06-05 00:00:00'),
('F00007', '411003', '2018-07-05 00:00:00'),
('F00008', '411003', '2018-08-05 00:00:00'),
('F00011', '411004', '2018-04-10 00:00:00'),
('F00012', '411004', '2018-05-10 00:00:00'),
('F00013', '411004', '2018-06-10 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('F00001', '1', '001', 'Produit 2.10', '2', '20,00', 'A'),
('F00001', '2', NULL, 'Commentaire', NULL, NULL, 'C'),
('F00002', '1', '002', 'Produit 7.00', '1', '7,50', 'A'),
('F00003', '1', '001', 'Produit 2.10', '3', '30,00', 'A'),
('F00003', '2', '01', 'Mo T1', '1,5', '42,00', 'M'),
('F00004', '1', 'ZZZ', 'Article supprime', '4', '10,00', 'A'),
('F00005', '1', '002', 'Produit 7.00', '2', '15,00', 'A'),
('F00006', '1', '001', 'Produit 2.10', '1', '10,00', 'A'),
('F00006', '2', '001', 'Produit 2.10', '1', '12,00', 'A'),
('F00007', '1', '01', 'Mo T1', '2', '56,00', 'M'),
('F00008', '1', '002', 'Produit 7.00', '5', '37,50', 'A'),
('F00011', '1', '001', 'Produit 2.10', '1', '10,00', 'A'),
('F00012', '1', NULL, 'Commentaire seul', NULL, NULL, 'C'),
('F00013', '1', '002', 'Produit 7.00', '2', '14,00', 'A');
INSERT INTO Fiches_Bl (numbl, cdclibl, datebl, totalht) VALUES
('B00001', '411003', '2018-09-05 00:00:00', 20),
('B00002', '411003', '2018-10-05 00:00:00', 30),
('B00003', '411003', '2018-11-05 00:00:00', 40),
('B00004', '411003', '2018-12-05 00:00:00', 50),
('B00005', '411003', '2018-12-20 00:00:00', 0);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, netht_ligbl, typel_ligbl) VALUES
('B00001', '1', '001', 'Produit 2.10', '2', '20,00', 'A'),
('B00002', '1', '002', 'Produit 7.00', '4', '30,00', 'A'),
('B00003', '1', '001', 'Produit 2.10', '4', '40,00', 'A'),
('B00004', '1', '02', 'Mo T2', '1', '31,00', 'M'),
('B00004', '2', '001', 'Produit 2.10', '2', '19,00', 'A'),
('B00005', '1', '001', 'Produit 2.10', '9', '0', 'A');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, datefac) VALUES
('M00001', '411003', '2018-06-05 00:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('M00001', '1', '003', 'produit 20.00', '1', '20,00', 'A');
INSERT INTO Fiches_BlM (numbl, cdclibl, datebl, totalht) VALUES
('N00001', '411003', '2018-11-05 00:00:00', 15);
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, netht_ligbl, typel_ligbl) VALUES
('N00001', '1', '001', 'Produit 2.10', '1', '15,00', 'A');
