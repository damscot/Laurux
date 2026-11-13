-- Jeu EDDOCS : 3 clients 411801 à 411803 et 8 documents de juin 2018 (2 devis D, 2 commandes C, 2 BL B, 2 factures F).
-- C00002 daté du 15/06/2018 à 10:30 ; F00001 imprimée (imp = 1, FA0001 du 08/06/2018) ; C00001 avec un commentaire YY sur 2 lignes.
INSERT INTO Fiches_Cli (cli_code, cli_nom, cli_pnm, cli_tel_bur, cli_pble) VALUES (411801, 'DUPONT', 'Jean', '0102030405', ''), (411802, 'LEGRAND', 'Anne', '', '0611223344'), (411803, 'MOREAU', 'Luc', '', '');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, adr1bl, adr2bl, cpbl, villebl, datebl, totalht, totalttc, imp, numfac, dtefac, livraison) VALUES
('D00001', 'D', '411801', 'M.', 'DUPONT', 'Jean', '1 rue Haute', '', '85000', 'LA ROCHE', '2018-06-02 00:00:00', 100, 120, 0, NULL, NULL, 0),
('D00002', 'D', '411803', 'M.', 'MOREAU', 'Luc', '3 rue Basse', '', '44000', 'NANTES', '2018-06-14 00:00:00', 50, 60, 0, NULL, NULL, 0),
('C00001', 'C', '411801', 'M.', 'DUPONT', 'Jean', '1 rue Haute', '', '85000', 'LA ROCHE', '2018-06-03 00:00:00', 200, 240, 0, NULL, NULL, 0),
('C00002', 'C', '411802', 'Mme', 'LEGRAND', 'Anne', '2 place Ronde', 'Bat B', '49000', 'ANGERS', '2018-06-15 10:30:00', 30, 36, 0, NULL, NULL, 1),
('B00001', 'B', '411802', 'Mme', 'LEGRAND', 'Anne', '2 place Ronde', 'Bat B', '49000', 'ANGERS', '2018-06-05 00:00:00', 80, 96, 0, NULL, NULL, 0),
('B00002', 'B', '411803', 'M.', 'MOREAU', 'Luc', '3 rue Basse', '', '44000', 'NANTES', '2018-06-10 00:00:00', 40, 48, 0, NULL, NULL, 1),
('F00001', 'F', '411801', 'M.', 'DUPONT', 'Jean', '1 rue Haute', '', '85000', 'LA ROCHE', '2018-06-07 00:00:00', 70, 84, 1, 'FA0001', '2018-06-08 00:00:00', 0),
('F00002', 'F', '411802', 'Mme', 'LEGRAND', 'Anne', '2 place Ronde', 'Bat B', '49000', 'ANGERS', '2018-06-09 00:00:00', 10, 12, 0, NULL, NULL, 0);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, nettc_ligbl, typel_ligbl, com_ligbl) VALUES
('D00001', '1', '001', 'Produit 2.10', '5', '120', 'A', NULL),
('D00002', '1', '002', 'Produit 7.00', '3', '60', 'A', NULL),
('C00001', '1', '001', 'Produit 2.10', '10', '240', 'A', NULL),
('C00001', '2', 'YY', '', '0', '0', 'C', 'Livrer le matin\nAppeler avant'),
('C00002', '1', '003', 'produit 20.00', '1', '36', 'A', NULL),
('B00001', '1', '002', 'Produit 7.00', '4', '96', 'A', NULL),
('B00002', '1', '001', 'Produit 2.10', '2', '48', 'A', NULL),
('F00001', '1', '001', 'Produit 2.10', '3', '84', 'A', NULL),
('F00002', '1', '003', 'produit 20.00', '1', '12', 'A', NULL);
