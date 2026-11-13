-- FacturefmA : BL d'abonnement (type A) au 15.06.2018, période en cours 06.2018.
-- 411911 Mensuel jamais facturé ; 411912 Mensuel facturé en mai, jour d'abonnement 10 ; 411913 Mensuel facturé en mai,
-- jour 20 ; 411914 Mensuel facturé en juin ; 411915 sans périodicité (cli_aban nul).
UPDATE Fiches_Parametres SET dtepec = '06.2018';
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411911, cli_nom = 'ABO UN', cli_div = 0, cli_aban = '1- Mensuel', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411912, cli_nom = 'ABO DEUX', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411913, cli_nom = 'ABO TROIS', cli_datab = '20';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411914, cli_nom = 'ABO QUATRE', cli_datab = '10';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411915, cli_nom = 'ABO SANS', cli_aban = NULL, cli_datab = NULL;
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, dtefac) VALUES
('A00001', 'A', '411911', 'ABO UN', '75001', 'PARIS', '2018-01-10 00:00:00', 10, 12, 0, NULL),
('A00002', 'A', '411912', 'ABO DEUX', '75002', 'PARIS', '2018-01-10 00:00:00', 20, 24, 0, '2018-05-05 00:00:00'),
('A00003', 'A', '411913', 'ABO TROIS', '75003', 'PARIS', '2018-01-10 00:00:00', 30, 36, 0, '2018-05-05 00:00:00'),
('A00004', 'A', '411914', 'ABO QUATRE', '75004', 'PARIS', '2018-01-10 00:00:00', 40, 48, 0, '2018-06-02 00:00:00'),
('A00005', 'A', '411915', 'ABO SANS', '75005', 'PARIS', '2018-01-10 00:00:00', 50, 60, 0, NULL);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES
('A00001', '1', 'ABO', 'Abonnement', '10', '1', '10', '1', 'A'),
('A00002', '1', 'ABO', 'Abonnement', '20', '1', '20', '1', 'A'),
('A00003', '1', 'ABO', 'Abonnement', '30', '1', '30', '1', 'A'),
('A00004', '1', 'ABO', 'Abonnement', '40', '1', '40', '1', 'A'),
('A00005', '1', 'ABO', 'Abonnement', '50', '1', '50', '1', 'A');
