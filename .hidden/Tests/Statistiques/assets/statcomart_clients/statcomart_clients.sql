-- Jeu StatComArt / VisStatComArt : factures archivées et lignes article par commercial.
-- 411001, 411002 -> commercial 01 ; 411003 -> 02 ; 411004 sans commercial.
-- F18103 existe dans HistoFac (411003) et HistoFacM (411002) : lignes lues dans HistoLigfac (A02).
-- M18101 n'a de lignes que dans HistoLigfacM (ignorées, A02). F18105 hors période (juillet).
INSERT INTO Fiches_Commerciaux (code, nom, prenom, comm) VALUES
('01', 'DUPONT', 'Jean', 0),
('02', 'MARTIN', 'Paul', 5.5);
UPDATE Fiches_Cli SET cli_comm = '01' WHERE cli_code IN (411001, 411002);
UPDATE Fiches_Cli SET cli_comm = '02' WHERE cli_code = 411003;
UPDATE Fiches_Cli SET cli_comm = NULL WHERE cli_code = 411004;
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18101', '411001', 'A Divers', 'Alain', '2018-03-05 00:00:00', '0', '0', 180.50),
('F18102', '411002', 'B Divers', 'Bruno', '2018-04-02 00:00:00', '0', '0', 150.00),
('F18103', '411003', 'C Divers', 'Claire', '2018-05-10 00:00:00', '0', '0', 140.00),
('F18104', '411004', 'D Divers', 'Denis', '2018-05-11 00:00:00', '0', '0', 999.00),
('F18105', '411002', 'B Divers', 'Bruno', '2018-07-01 00:00:00', '0', '0', 777.00);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('F18101', '1', 'ART1', 'Article un', '2', '100.00', 'A'),
('F18101', '2', 'MO1', 'Main d oeuvre', '1', '50.00', 'M'),
('F18101', '3', 'ART2', 'Article deux', '1', '30,50', 'A'),
('F18102', '1', 'ART1', 'Article un', '3', '150.00', 'A'),
('F18103', '1', 'ART1', 'Article un', '1', '60.00', 'A'),
('F18103', '2', 'ART3', 'Article trois', '4', '80.00', 'A'),
('F18104', '1', 'ART1', 'Article un', '9', '999.00', 'A'),
('F18105', '1', 'ART4', 'Article quatre', '1', '777.00', 'A');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18103', '411002', 'B Divers', 'Bruno', '2018-02-15 00:00:00', '0', '0', 140.00),
('M18101', '411001', 'A Divers', 'Alain', '2018-03-01 00:00:00', '0', '0', 40.00);
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('M18101', '1', 'ART5', 'Article cinq', '1', '40.00', 'A');
-- StatComArt-T04 : facture d'un client supprimé (absent de Fiches_Cli), après les autres.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18106', '411999', 'Z Supprime', 'Zoe', '2018-06-01 00:00:00', '0', '0', 10.00);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('F18106', '1', 'ART1', 'Article un', '1', '10.00', 'A');
