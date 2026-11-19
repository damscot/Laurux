-- ObjFac (gb.test par instanciation directe) : jeu de facturation dérivé de Laurux01 (date des tests : 2018-06-15).
-- Clients : 411801 MARTIN (SARL, chèque, échéance 30 j fin de mois, 3 exemplaires), 411802 PETIT (auto-entrepreneur),
-- 411803 DUPONT (règlement inconnu « ZZ », exemplaires NULL, copie GED), 411804 LEROY (BL acquitté).
-- BL : B10001 simple (2 articles TVA 20 % et 2,10 % + 1 MO, remise ligne), B10002 types de lignes (C, R, T, O, E, D, P),
-- B10003 frais de gestion, B10004 frais + exonéré, B10005 frais auto-entrepreneur, B10006 avoir (négatif),
-- B10007 BL d'entretien (Fiches_BlM), B10008 facturé (F00010, imp = 1, acquitté), B10009 réglé par ticket non mouliné,
-- B10010 frais + exonéré + auto-entrepreneur (411802), B10011 client divers 411001 (« CLIENT X »).
-- exobl = -1 (valeur écrite par Facture : CheckBox Exo.Value).
-- Archives : F00020 (Fiches_HistoFac), F00030 (Fiches_HistoFacM). Écotaxes sur l'article 001, article composé 002.
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411801, cli_rs_soc = 'SARL', cli_nom = 'MARTIN', cli_pnm = 'Jean', cli_adr1 = '1 rue Haute', cli_adr2 = 'Bat A', cli_cd_ptl = '75001', cli_ville = 'PARIS', cli_pays = 'France', cli_div = 0, cli_expl = '3', cli_autoent = 0, cli_cdech = '01', cli_copie = 0, cli_reg = '05', tag_def = NULL;
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411802, cli_rs_soc = '', cli_nom = 'PETIT', cli_pnm = 'Paul', cli_cd_ptl = '69001', cli_ville = 'LYON', cli_expl = '1', cli_autoent = 1, cli_cdech = '00', cli_reg = '01';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411803, cli_rs_soc = 'SA', cli_nom = 'DUPONT', cli_pnm = '', cli_cd_ptl = '13001', cli_ville = 'MARSEILLE', cli_expl = NULL, cli_autoent = 0, cli_cdech = NULL, cli_reg = 'ZZ', cli_copie = 1, tag_def = 'TAGA,TAGB';
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
UPDATE tmp_cli SET cli_code = 411804, cli_rs_soc = '', cli_nom = 'LEROY', cli_pnm = 'Luc', cli_cd_ptl = '44000', cli_ville = 'NANTES', cli_expl = '2', cli_cdech = '00', cli_reg = '05', cli_copie = 0, tag_def = NULL;
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
UPDATE Fiches_Art SET art_ect = 1, art_eco = 0.5, art_ect2 = 1, art_eco2 = 0.2, art_vol = 'Kg' WHERE art_code = '001';
UPDATE Fiches_Art SET art_prdcomp = 1, art_impdetail = 1 WHERE art_code = '002';
UPDATE Fiches_Parametres SET cptfrais = '706110', tvafrais = '3', dtepec = '06.2018';
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, adr1bl, adr2bl, cpbl, villebl, datebl, exobl, totalht, totalttc, imp, reg, ech, numfac, dtefac, retro, acquitte, numtick, gestbl) VALUES
('B10001', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-10 00:00:00', 0, 61, 70.92, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 0.00),
('B10002', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-11 00:00:00', 0, 40, 42.80, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 0.00),
('B10003', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-12 00:00:00', 0, 10, 12, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 5.00),
('B10004', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-12 00:00:00', -1, 10, 10, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 5.00),
('B10005', 'B', '411802', '', 'PETIT', 'Paul', '', '', '69001', 'LYON', '2018-06-12 00:00:00', 0, 10, 10, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 5.00),
('B10006', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-13 00:00:00', 0, -10, -12, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 0.00),
('B10008', 'F', '411804', '', 'LEROY', 'Luc', '', '', '44000', 'NANTES', '2018-06-05 00:00:00', 0, 10, 12, 1, 'Chèque', '2018-06-05 00:00:00', 'F00010', '2018-06-05 00:00:00', 0, 1, NULL, 0.00),
('B10009', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-14 00:00:00', 0, 10, 12, 0, NULL, NULL, NULL, NULL, 0, 0, '0000012', 0.00),
('B10010', 'B', '411802', '', 'PETIT', 'Paul', '', '', '69001', 'LYON', '2018-06-12 00:00:00', -1, 10, 10, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 5.00),
('B10011', 'B', '411001', '', 'CLIENT X', '', '', '', '44000', 'NANTES', '2018-06-12 00:00:00', 0, 10, 12, 0, NULL, NULL, NULL, NULL, 0, 0, NULL, 0.00);
INSERT INTO Fiches_BlM (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, adr1bl, adr2bl, cpbl, villebl, datebl, exobl, totalht, totalttc, imp, numfac, retro, acquitte, gestbl) VALUES
('B10007', 'B', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2018-06-09 00:00:00', 0, 28, 33.60, 0, NULL, 0, 0, 0.00);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, typel_ligbl, com_ligbl) VALUES
('B10001', '1', '003', 'produit 20.00', '03', '10', '2', '20', '10', '18', '3', '20.00', '21.60', 'A', NULL),
('B10001', '2', '001', 'Produit 2.10', '01', '5', '3', '15', '0', '15', '1', '2.10', '15.32', 'A', NULL),
('B10001', '3', '01', 'Mo T1', '10', '28', '1', '28', '0', '28', '3', '20.00', '33.60', 'M', NULL),
('B10002', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'C', 'Commentaire ligne 1\nCommentaire ligne 2\nCommentaire ligne 3'),
('B10002', '2', '002', 'Produit 7.00', '02', '20', '2', '40', '0', '40', '2', '7.00', '42.80', 'A', NULL),
('B10002', '3', '001', 'Composant 1', '01', '0', '1', '0', '0', '0', '1', '2.10', '0', 'O', NULL),
('B10002', '4', NULL, 'Seconde ligne article', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'T', NULL),
('B10002', '5', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', 'Reserve unique'),
('B10002', '6', 'E1', 'eco-participation', NULL, '0.5', '2', NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL),
('B10002', '7', 'D1', 'droits', NULL, '1.25', '2', NULL, NULL, NULL, NULL, NULL, NULL, 'D', NULL),
('B10002', '8', 'P1', 'consigne', NULL, '0.1', '3', NULL, NULL, NULL, NULL, NULL, NULL, 'P', NULL),
('B10003', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10004', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10005', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10006', '1', '003', 'produit 20.00', '03', '10', '-1', '-10', '0', '-10', '3', '20.00', '-12', 'A', NULL),
('B10008', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10009', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10010', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL),
('B10011', '1', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A', NULL);
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, typel_ligbl) VALUES
('B10007', '1', '01', 'Mo T1', '10', '28', '1', '28', '0', '28', '3', '20.00', '33.60', 'M'),
('B10007', '2', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12', 'A');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, cvclifac, nmclifac, pnmclifac, adr1fac, adr2fac, cpfac, villefac, datefac, exofac, totfac, reg, ech, numerobl, totfacttc, acquitte, gestfac) VALUES
('F00020', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2017-03-10 00:00:00', 0, 20.00, 'Chèque', '2017-04-30 00:00:00', 'B00500', 24.00, 0, 0.00);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, fam_ligfac, pu_ligfac, qte_ligfac, brut_ligfac, rem_ligfac, netht_ligfac, tx_ligfac, mtx_ligfac, nettc_ligfac, typel_ligfac) VALUES
('F00020', '1', '003', 'produit 20.00', '03', '10', '2', '20', '0', '20', '3', '20.00', '24', 'A');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, cvclifac, nmclifac, pnmclifac, adr1fac, adr2fac, cpfac, villefac, datefac, exofac, totfac, reg, ech, numerobl, totfacttc, acquitte, gestfac) VALUES
('F00030', '411801', 'SARL', 'MARTIN', 'Jean', '1 rue Haute', 'Bat A', '75001', 'PARIS', '2017-05-10 00:00:00', 0, 28.00, 'Chèque', '2017-06-30 00:00:00', 'B00600', 33.60, 0, 0.00);
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, fam_ligfac, pu_ligfac, qte_ligfac, brut_ligfac, rem_ligfac, netht_ligfac, tx_ligfac, mtx_ligfac, nettc_ligfac, typel_ligfac) VALUES
('F00030', '1', '01', 'Mo T1', '10', '28', '1', '28', '0', '28', '3', '20.00', '33.60', 'M');
INSERT INTO Fiches_Suivis (code, nom, numdev, datedev) VALUES ('411801', 'MARTIN', 'B10001', '2018-06-01');
-- Comptes clients (sauf 411803, sans compte : écriture refusée par EcrAuto)
INSERT INTO Fiches_Comptes (compte_cc, intitule_cc, type_cc, coll, coll_cc, cent_cc, comptr_cc, gen_tv, gen_ta, solde, soldep, cprincipal, lettrable) VALUES
(411801, 'MARTIN', 'C', 0, '411000', 0, 0, 0, 0, 0, 0, 0, 1),
(411802, 'PETIT', 'C', 0, '411000', 0, 0, 0, 0, 0, 0, 0, 1),
(411804, 'LEROY', 'C', 0, '411000', 0, 0, 0, 0, 0, 0, 0, 1);
