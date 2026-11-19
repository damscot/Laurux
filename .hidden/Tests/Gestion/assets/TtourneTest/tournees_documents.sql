-- Ttourne T10 : tournées T3, T1, T2 (comme tournees_base) + documents portant une tournée (exercice 2018, dtepec 06.2018).
-- T1 : BL B20001 (03/2018, art 100 HT, marge 20, qte 2 + MO 30 HT), BL d'entretien B20002 (04/2018, 40 HT),
-- facture archivée F20001 (05/2017, 50 HT) et F20002 en HistoFacM (06/2018, 25 HT) ; T2 : BL B20003 (03/2018, exclu de T1).
INSERT INTO Fiches_tourne VALUES ('T3', 'Tournee du vendredi');
INSERT INTO Fiches_tourne VALUES ('T1', 'Tournee du lundi');
INSERT INTO Fiches_tourne VALUES ('T2', 'Tournee du mercredi');
UPDATE Fiches_Parametres SET dtepec = '06.2018';
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, imp) VALUES
('B20001', 'B', '411001', 'CLIENT', '2018-03-10 00:00:00', 0),
('B20003', 'B', '411001', 'CLIENT', '2018-03-12 00:00:00', 0);
INSERT INTO Fiches_BlM (numbl, type, cdclibl, nmclibl, datebl, imp) VALUES
('B20002', 'B', '411001', 'CLIENT', '2018-04-10 00:00:00', 0);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, netht_ligbl, mrgart_ligbl, mrgmo_ligbl, typel_ligbl, tour_ligbl) VALUES
('B20001', '1', '003', '2', '100', 20, NULL, 'A', 'T1'),
('B20001', '2', '01', '1', '30', NULL, 10, 'M', 'T1'),
('B20001', '3', NULL, NULL, NULL, NULL, NULL, 'C', 'T1'),
('B20003', '1', '003', '1', '70', 7, NULL, 'A', 'T2');
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, netht_ligbl, mrgart_ligbl, typel_ligbl, tour_ligbl) VALUES
('B20002', '1', '003', '1', '40', 4, 'A', 'T1');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac) VALUES ('F20001', '411001', 'CLIENT', '2017-05-10 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, qte_ligfac, netht_ligfac, mrgart_ligfac, typel_ligfac, tour_ligfac) VALUES
('F20001', '1', '003', '1', '50', 5, 'A', 'T1');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, datefac) VALUES ('F20002', '411001', 'CLIENT', '2018-06-05 00:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, qte_ligfac, netht_ligfac, mrgmo_ligfac, typel_ligfac, tour_ligfac) VALUES
('F20002', '1', '01', '1', '25', 5, 'M', 'T1');
