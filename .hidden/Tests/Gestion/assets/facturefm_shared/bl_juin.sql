-- Facturefm : clients et BL non facturés de juin 2018 (date des scénarios : 2018-06-15, fin proposée 30.06.2018).
-- 411901 DURAND (S, type 01, commercial 01) : 3 BL dont 2 avec frais de gestion 5,00 + 1 facture déjà imprimée (exclue).
-- 411902 MARTIN (S, type 02) : 1 BL. 411903 PETIT (M) : 2 BL (01/06 et 16/06). 411001 « A Divers » : 2 BL (CLIENT X, CLIENT Y).
INSERT INTO Fiches_Commerciaux (lind, code, nom, prenom, comm) VALUES (1, '01', 'VENDU', 'Paul', 0.00);
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411901, cli_nom = 'DURAND', cli_cd_ptl = '75001', cli_ville = 'PARIS', cli_div = 0, cli_regr = 'S', cli_typec = '01', cli_comm = '01';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411902, cli_nom = 'MARTIN', cli_cd_ptl = '69001', cli_ville = 'LYON', cli_typec = '02', cli_comm = '';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411903, cli_nom = 'PETIT', cli_cd_ptl = '13001', cli_ville = 'MARSEILLE', cli_typec = '01', cli_regr = 'M';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, totalht, totalttc, imp, gestbl) VALUES
('B00001', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-05 00:00:00', 100, 120, 0, 0.00),
('B00002', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-20 00:00:00', 55, 66, 0, 5.00),
('B00003', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-25 00:00:00', 35, 42, 0, 5.00),
('B00004', 'B', '411902', 'MARTIN', '69001', 'LYON', '2018-06-10 00:00:00', 200, 240, 0, 0.00),
('B00005', 'B', '411903', 'PETIT', '13001', 'MARSEILLE', '2018-06-01 00:00:00', 80, 96, 0, 0.00),
('B00006', 'B', '411903', 'PETIT', '13001', 'MARSEILLE', '2018-06-16 00:00:00', 20, 24, 0, 0.00),
('B00007', 'B', '411001', 'CLIENT X', '44000', 'NANTES', '2018-06-12 00:00:00', 10, 12, 0, 0.00),
('B00008', 'B', '411001', 'CLIENT Y', '35000', 'RENNES', '2018-06-13 00:00:00', 15, 18, 0, 0.00),
('B00009', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-08 00:00:00', 70, 84, 1, 0.00);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, netht_ligbl, tx_ligbl, typel_ligbl) VALUES
('B00001', '1', 'ART1', 'Article', '100', '1', '100', '1', 'A'),
('B00002', '1', 'ART1', 'Article', '50', '1', '50', '1', 'A'),
('B00003', '1', 'ART1', 'Article', '30', '1', '30', '1', 'A'),
('B00004', '1', 'ART1', 'Article', '200', '1', '200', '1', 'A'),
('B00005', '1', 'ART1', 'Article', '80', '1', '80', '1', 'A'),
('B00006', '1', 'ART1', 'Article', '20', '1', '20', '1', 'A'),
('B00007', '1', 'ART1', 'Article', '10', '1', '10', '1', 'A'),
('B00008', '1', 'ART1', 'Article', '15', '1', '15', '1', 'A'),
('B00009', '1', 'ART1', 'Article', '70', '1', '70', '1', 'A');
-- Période de facturation en cours : juin 2018 (VerifDate.ClotGestion accepte du 01.06.2018 au 31.07.2018).
UPDATE Fiches_Parametres SET dtepec = '06.2018';
