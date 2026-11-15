-- FacturefmA-T03 : clients annuels, période 06.2018 (scénario au 15.06.2018) : 411951 facturé le 15.06.2017
-- (un an jour pour jour, jour d'abonnement 10), 411952 idem jour 20, 411953 facturé le 05.06.2016, 411954 le 05.05.2017,
-- 411955 le 05.07.2017.
UPDATE Fiches_Parametres SET dtepec = '06.2018';
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411951, cli_nom = 'ANN UN', cli_div = 0, cli_aban = '5- Annuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411952, cli_nom = 'ANN DEUX', cli_div = 0, cli_aban = '5- Annuel', cli_datab = '20';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411953, cli_nom = 'ANN TROIS', cli_div = 0, cli_aban = '5- Annuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411954, cli_nom = 'ANN QUATRE', cli_div = 0, cli_aban = '5- Annuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411955, cli_nom = 'ANN CINQ', cli_div = 0, cli_aban = '5- Annuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, dtefac) VALUES
('A00301', 'A', '411951', 'ANN UN', '75000', 'PARIS', '2017-01-10 00:00:00', 10, 12, 0, '2017-06-15 00:00:00'),
('A00302', 'A', '411952', 'ANN DEUX', '75000', 'PARIS', '2017-01-10 00:00:00', 20, 24, 0, '2017-06-15 00:00:00'),
('A00303', 'A', '411953', 'ANN TROIS', '75000', 'PARIS', '2017-01-10 00:00:00', 30, 36, 0, '2016-06-05 00:00:00'),
('A00304', 'A', '411954', 'ANN QUATRE', '75000', 'PARIS', '2017-01-10 00:00:00', 40, 48, 0, '2017-05-05 00:00:00'),
('A00305', 'A', '411955', 'ANN CINQ', '75000', 'PARIS', '2017-01-10 00:00:00', 50, 60, 0, '2017-07-05 00:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES
('A00301', '1', 'ABO', 'Abonnement', '10', '1', '10', '1', 'A'),
('A00302', '1', 'ABO', 'Abonnement', '20', '1', '20', '1', 'A'),
('A00303', '1', 'ABO', 'Abonnement', '30', '1', '30', '1', 'A'),
('A00304', '1', 'ABO', 'Abonnement', '40', '1', '40', '1', 'A'),
('A00305', '1', 'ABO', 'Abonnement', '50', '1', '50', '1', 'A');
