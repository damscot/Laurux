-- FacturefmA-T02 : BL d'abonnement (type A), clients bimensuels (41192x), trimestriels (41193x),
-- semestriels (41194x), jour d'abonnement 10, facturés le 05.07.2017, 05.10.2017, 05.11.2017, 05.12.2017 ;
-- période en cours 07.2018 (date du scénario dans ce mois).
UPDATE Fiches_Parametres SET dtepec = '07.2018';
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411921, cli_nom = 'PER 21', cli_div = 0, cli_aban = '2- Bimensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411922, cli_nom = 'PER 22', cli_div = 0, cli_aban = '2- Bimensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411923, cli_nom = 'PER 23', cli_div = 0, cli_aban = '2- Bimensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411924, cli_nom = 'PER 24', cli_div = 0, cli_aban = '2- Bimensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411931, cli_nom = 'PER 31', cli_div = 0, cli_aban = '3- Trimestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411932, cli_nom = 'PER 32', cli_div = 0, cli_aban = '3- Trimestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411933, cli_nom = 'PER 33', cli_div = 0, cli_aban = '3- Trimestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411934, cli_nom = 'PER 34', cli_div = 0, cli_aban = '3- Trimestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411941, cli_nom = 'PER 41', cli_div = 0, cli_aban = '4- Semestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411942, cli_nom = 'PER 42', cli_div = 0, cli_aban = '4- Semestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411943, cli_nom = 'PER 43', cli_div = 0, cli_aban = '4- Semestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411944, cli_nom = 'PER 44', cli_div = 0, cli_aban = '4- Semestriel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, dtefac) VALUES
('A00201', 'A', '411921', 'PER 21', '75000', 'PARIS', '2017-01-10 00:00:00', 10, 12, 0, '2017-07-05 00:00:00'),
('A00202', 'A', '411922', 'PER 22', '75000', 'PARIS', '2017-01-10 00:00:00', 20, 24, 0, '2017-10-05 00:00:00'),
('A00203', 'A', '411923', 'PER 23', '75000', 'PARIS', '2017-01-10 00:00:00', 30, 36, 0, '2017-11-05 00:00:00'),
('A00204', 'A', '411924', 'PER 24', '75000', 'PARIS', '2017-01-10 00:00:00', 40, 48, 0, '2017-12-05 00:00:00'),
('A00205', 'A', '411931', 'PER 31', '75000', 'PARIS', '2017-01-10 00:00:00', 50, 60, 0, '2017-07-05 00:00:00'),
('A00206', 'A', '411932', 'PER 32', '75000', 'PARIS', '2017-01-10 00:00:00', 60, 72, 0, '2017-10-05 00:00:00'),
('A00207', 'A', '411933', 'PER 33', '75000', 'PARIS', '2017-01-10 00:00:00', 70, 84, 0, '2017-11-05 00:00:00'),
('A00208', 'A', '411934', 'PER 34', '75000', 'PARIS', '2017-01-10 00:00:00', 80, 96, 0, '2017-12-05 00:00:00'),
('A00209', 'A', '411941', 'PER 41', '75000', 'PARIS', '2017-01-10 00:00:00', 90, 108, 0, '2017-07-05 00:00:00'),
('A00210', 'A', '411942', 'PER 42', '75000', 'PARIS', '2017-01-10 00:00:00', 100, 120, 0, '2017-10-05 00:00:00'),
('A00211', 'A', '411943', 'PER 43', '75000', 'PARIS', '2017-01-10 00:00:00', 110, 132, 0, '2017-11-05 00:00:00'),
('A00212', 'A', '411944', 'PER 44', '75000', 'PARIS', '2017-01-10 00:00:00', 120, 144, 0, '2017-12-05 00:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES
('A00201', '1', 'ABO', 'Abonnement', '10', '1', '10', '1', 'A'),
('A00202', '1', 'ABO', 'Abonnement', '20', '1', '20', '1', 'A'),
('A00203', '1', 'ABO', 'Abonnement', '30', '1', '30', '1', 'A'),
('A00204', '1', 'ABO', 'Abonnement', '40', '1', '40', '1', 'A'),
('A00205', '1', 'ABO', 'Abonnement', '50', '1', '50', '1', 'A'),
('A00206', '1', 'ABO', 'Abonnement', '60', '1', '60', '1', 'A'),
('A00207', '1', 'ABO', 'Abonnement', '70', '1', '70', '1', 'A'),
('A00208', '1', 'ABO', 'Abonnement', '80', '1', '80', '1', 'A'),
('A00209', '1', 'ABO', 'Abonnement', '90', '1', '90', '1', 'A'),
('A00210', '1', 'ABO', 'Abonnement', '100', '1', '100', '1', 'A'),
('A00211', '1', 'ABO', 'Abonnement', '110', '1', '110', '1', 'A'),
('A00212', '1', 'ABO', 'Abonnement', '120', '1', '120', '1', 'A');
