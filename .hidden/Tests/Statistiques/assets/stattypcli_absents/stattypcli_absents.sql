-- Jeu StatComm (lot Statistiques) : commerciaux, clients rattachés, factures archivées N (2018) et N-1 (2017).
-- Période N par défaut de StatComm : 01.01.2018 (dteclec1 + 1 mois) au 15.06.2018 (date figée du scénario).
INSERT INTO Fiches_Commerciaux (code, nom, prenom, comm) VALUES
('01', 'DUPONT', 'Jean', 0),
('02', 'MARTIN', 'Paul', 5.5);
UPDATE Fiches_Cli SET cli_comm = '01' WHERE cli_code IN (411001, 411002);
UPDATE Fiches_Cli SET cli_comm = '02' WHERE cli_code = 411003;
UPDATE Fiches_Cli SET cli_comm = NULL WHERE cli_code = 411004;
-- Factures hors entretien (HistoFac)
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18001', '411001', 'A Divers', 'Alain', '2018-03-05 00:00:00', '12,50', '0', 100.00),
('F18002', '411001', 'A Divers', 'Alain', '2018-03-20 00:00:00', NULL, '7.50', 200.00),
('F18003', '411002', 'B Divers', 'Bruno', '2018-04-02 00:00:00', '0', '0', 50.00),
('F18004', '411003', 'C Divers', 'Claire', '2018-05-10 00:00:00', '10,00', '5,00', 300.00),
('F18005', '411004', 'D Divers', 'Denis', '2018-05-11 00:00:00', '0', '0', 40.00),
('F18007', '411002', 'B Divers', 'Bruno', '2018-07-01 00:00:00', '0', '0', 999.00),
('F17001', '411001', 'A Divers', 'Alain', '2017-03-05 00:00:00', '0', '0', 80.00),
('F17002', '411001', 'A Divers', 'Alain', '2017-06-01 00:00:00', '0', '0', 20.00),
('F17003', '411003', 'C Divers', 'Claire', '2017-02-01 00:00:00', '0', '0', 150.00),
('F17004', '411005', 'E Divers', 'Eric', '2017-04-01 00:00:00', '0', '0', 60.00),
('F17005', '411002', 'B Divers', 'Bruno', '2017-08-01 00:00:00', '0', '0', 33.00);
-- Factures d'entretien (HistoFacM), dont un numéro identique à une facture HistoFac
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('M18001', '411002', 'B Divers', 'Bruno', '2018-02-15 00:00:00', '5,00', '0', 120.00),
('F18001', '411003', 'C Divers', 'Claire', '2018-03-01 00:00:00', '0', '0', 80.00),
('M17001', '411002', 'B Divers', 'Bruno', '2017-02-15 00:00:00', '0', '0', 45.00);
-- Ajout StatTypCli : types clients (Laurux01 : 01 Macon, 02 Plombier, 03 Agriculteur), un client sans type,
-- une remise au format « 12.50 », 3 factures N et 2 factures N-1 pour 411002.
UPDATE Fiches_Cli SET cli_typec = '01' WHERE cli_code IN (411001, 411004);
UPDATE Fiches_Cli SET cli_typec = '02' WHERE cli_code IN (411002, 411005);
UPDATE Fiches_Cli SET cli_typec = NULL WHERE cli_code = 411003;
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18010', '411002', 'B Divers', 'Bruno', '2018-04-10 00:00:00', '12.50', '0', 25.00),
('F18011', '411002', 'B Divers', 'Bruno', '2018-04-11 00:00:00', '0', '0', 25.00),
('F17010', '411002', 'B Divers', 'Bruno', '2017-04-10 00:00:00', '0', '0', 11.00),
('F17011', '411002', 'B Divers', 'Bruno', '2017-04-11 00:00:00', '0', '0', 9.00);
-- Ajout STATTYPCLI-T04 : facture d'un client absent de Fiches_Cli
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES ('F18020', '4110035', 'Supprime', 'Zoe', '2018-05-12 00:00:00', '0', '0', 70.00);
