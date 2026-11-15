-- Jeu Statbase-T02 : tickets en cours (2) et archivés (3), factures archivées (2) et d'entretien (1), BL B/B/D/F.
INSERT INTO Fiches_EntTicketz (caisse, numero, date, mttc, statut, suppr) VALUES
('01', '1001', '2018-06-14 09:00:00', 10.00, '0', 0),
('01', '1002', '2018-06-14 10:00:00', 20.00, 'V', 0);
INSERT INTO Fiches_HisEntTickets (caisse, numero, date, mttc, suppr) VALUES
('01', '900', '2018-05-01 09:00:00', 11.00, 0),
('01', '901', '2018-05-01 10:00:00', 12.00, 0),
('02', '902', '2018-05-02 11:00:00', 13.00, 0);
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac, totfac) VALUES
('F18201', '411001', '2018-03-05 00:00:00', 100.00),
('F18202', '411002', '2018-03-06 00:00:00', 50.00);
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, datefac, totfac) VALUES
('M18201', '411003', '2018-03-07 00:00:00', 70.00);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, datebl) VALUES
('900001', 'B', '411001', '2018-06-01 00:00:00'),
('900002', 'B', '411002', '2018-06-02 00:00:00'),
('900003', 'D', '411001', '2018-06-03 00:00:00'),
('900004', 'F', '411003', '2018-06-04 00:00:00');
