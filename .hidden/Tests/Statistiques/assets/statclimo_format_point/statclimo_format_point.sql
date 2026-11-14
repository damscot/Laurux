-- Jeu STATCLIMO-T04 : statclimo_ventes + ligne M archivée au format point (brut 12.50).
-- Jeu de données STATCLIMO / VISSTATCLIMO : factures archivées (HistoFac, HistoFacM) et BL en cours (Bl, BlM)
-- avec lignes A (pièces) et M (main-d'oeuvre), dans et hors période. Appliqué après Laurux01.sql (tables vides).
-- Période par défaut au 15.06.2018 : du 01.01.2018 (dteclec1 = 2017-12-31) au 15.06.2018.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac) VALUES
('H00001', '411001', 'A Divers', 'Alain', '2018-02-01 00:00:00'),
('H00002', '411002', 'B Divers', 'Bruno', '2018-03-01 00:00:00'),
('H00003', '411001', 'A Divers', 'Alain', '2017-10-01 00:00:00'),
('H00004', '411001', 'A Divers', 'Alain', '2018-04-10 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, brut_ligfac, netht_ligfac) VALUES
('H00001', '1', 'ART1', 'A', '100,00', '90,00'),
('H00001', '2', '01', 'M', '50,00', '45,00'),
('H00001', '3', NULL, 'C', NULL, NULL),
('H00002', '1', 'ART2', 'A', '200.00', '200.00'),
('H00003', '1', 'ART1', 'A', '999,00', '999,00'),
('H00004', '1', 'ART1', 'A', '10,00', '8,00');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, pnmclifac, datefac) VALUES
('M00001', '411003', 'C Divers', 'Claire', '2018-04-01 00:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, brut_ligfac, netht_ligfac) VALUES
('M00001', '1', '02', 'M', '30,00', '27,00'),
('M00001', '2', 'ART1', 'A', '20,00', '18,00');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, pnmclibl, datebl, imp) VALUES
('B00001', 'F', '411001', 'A Divers', 'Alain', '2018-05-01 00:00:00', 1),
('B00002', 'B', '411002', 'B Divers', 'Bruno', '2017-11-01 00:00:00', 0),
('B00003', 'D', '411003', 'C Divers', 'Claire', '2018-05-02 00:00:00', 0),
('B00004', 'B', '411004', 'D Divers', 'Denis', '2018-05-03 00:00:00', 0);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, typel_ligbl, brut_ligbl, netht_ligbl) VALUES
('B00001', '1', 'ART1', 'A', '10,00', '10,00'),
('B00001', '2', '01', 'M', '20,00', '15,00'),
('B00002', '1', 'ART2', 'A', '70,00', '70,00'),
('B00003', '1', 'ART2', 'A', '5,00', '5,00'),
('B00004', '1', '03', 'M', '12,00', '12,00');
INSERT INTO Fiches_BlM (numbl, type, cdclibl, nmclibl, pnmclibl, datebl) VALUES
('BM0001', 'F', '411003', 'C Divers', 'Claire', '2018-05-03 00:00:00');
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, typel_ligbl, brut_ligbl, netht_ligbl) VALUES
('BM0001', '1', '02', 'M', '40,00', '36,00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, brut_ligfac, netht_ligfac) VALUES
('H00002', '2', '01', 'M', '12.50', '12.50');
