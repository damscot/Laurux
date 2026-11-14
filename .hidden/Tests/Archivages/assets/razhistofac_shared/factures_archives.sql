-- Jeu RAZHISTOFAC : factures archivées avant, le jour même et après 2018-06-15, avec lignes ;
-- factures entretien (Fiches_HistoFacM) avant/après.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac, totfac) VALUES
('F900001', '411000', 'FACTURE ANCIENNE', '2018-05-02 09:00:00', 100.00),
('F900002', '411000', 'FACTURE DU JOUR', '2018-06-15 08:00:00', 200.00),
('F900003', '411000', 'FACTURE FUTURE', '2018-07-01 09:00:00', 300.00);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac) VALUES
('F900001', '1', 'ART1', 'Ligne 1 facture ancienne'),
('F900001', '2', 'ART2', 'Ligne 2 facture ancienne'),
('F900002', '1', 'ART1', 'Ligne facture du jour'),
('F900003', '1', 'ART1', 'Ligne facture future');
INSERT INTO Fiches_HistoFacM (numfac, datefac) VALUES
('M900001', '2018-05-02 09:00:00'),
('M900002', '2018-07-01 09:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac) VALUES
('M900001', '1'), ('M900002', '1');
