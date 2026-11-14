-- Jeu Histovmo : lignes de main-d'oeuvre (typel M) en factures historisées et en documents en cours, MO 01 à 03 de Laurux01.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac, totfac) VALUES
('0000301', '411001', 'A Divers', '2018-03-10 00:00:00', 102.5),
('0000302', '411002', 'B Divers', '2017-10-10 00:00:00', 28);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, fam_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('0000301', '000001', '01', 'Mo T1', '10', '2', '56,00', 'M'),
('0000301', '000002', '02', 'Mo T2', '10', '1,5', '46,50', 'M'),
('0000301', '000003', '001', 'Produit 2.10', '01', '1', '10,00', 'A'),
('0000302', '000001', '01', 'Mo T1', '10', '1', '28,00', 'M');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, totalht) VALUES
('000301', 'F', '411001', 'A Divers', '2018-04-02 00:00:00', 28),
('000302', 'B', '411003', 'C Divers', '2018-05-03 00:00:00', 35);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, qte_ligbl, netht_ligbl, typel_ligbl) VALUES
('000301', '000001', '01', 'Mo T1', '10', '1', '28,00', 'M'),
('000302', '000001', '03', 'Mo T3', '10', '1', '35,00', 'M');
