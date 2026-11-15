-- FacturefmA-T05 : clients mensuels jamais facturés : 411961 (BL A00401 et A00402), 411962 (A00403),
-- 411963 (A00404) ; période 06.2018.
UPDATE Fiches_Parametres SET dtepec = '06.2018';
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411961, cli_nom = 'RET UN', cli_div = 0, cli_aban = '1- Mensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411962, cli_nom = 'RET DEUX', cli_div = 0, cli_aban = '1- Mensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411963, cli_nom = 'RET TROIS', cli_div = 0, cli_aban = '1- Mensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, dtefac) VALUES
('A00401', 'A', '411961', 'RET UN', '75000', 'PARIS', '2017-01-10 00:00:00', 10, 12, 0, NULL),
('A00402', 'A', '411961', 'RET UN', '75000', 'PARIS', '2017-01-10 00:00:00', 20, 24, 0, NULL),
('A00403', 'A', '411962', 'RET DEUX', '75000', 'PARIS', '2017-01-10 00:00:00', 30, 36, 0, NULL),
('A00404', 'A', '411963', 'RET TROIS', '75000', 'PARIS', '2017-01-10 00:00:00', 40, 48, 0, NULL);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES
('A00401', '1', 'ABO', 'Abonnement', '10', '1', '10', '1', 'A'),
('A00402', '1', 'ABO', 'Abonnement', '20', '1', '20', '1', 'A'),
('A00403', '1', 'ABO', 'Abonnement', '30', '1', '30', '1', 'A'),
('A00404', '1', 'ABO', 'Abonnement', '40', '1', '40', '1', 'A');
