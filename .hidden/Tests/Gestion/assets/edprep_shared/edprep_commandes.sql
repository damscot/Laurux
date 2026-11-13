-- Jeu EdPrep (agent 6, vague 5) : 3 commandes (type C) et un BL (type B, exclu).
-- C00001 (411001, DUPONT, PARIS) : adresse de livraison client Fiches_AdrlivC (LYON) ; 2 lignes article (002 avec
--   four_ligbl 401002 différent de art_four), commentaire YY sur 2 lignes, véhicule XX complet.
-- C00002 (411002, MARTIN, NANTES, livraison 1) : adresse de livraison du document Fiches_AdrlivBL (RENNES) ;
--   1 ligne article, véhicule XX incomplet (immatriculation seule), ligne « Reliquat ».
-- C00003 (411003, BERNARD, BREST) : aucune ligne.
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, adr1bl, adr2bl, cpbl, villebl, datebl, totalht, totalttc, imp, livraison) VALUES
('C00001', 'C', '411001', 'M.', 'DUPONT', 'Jean', '1 rue de la Paix', 'Bat A', '75001', 'PARIS', '2018-06-10 00:00:00', 100, 120, 0, 0),
('C00002', 'C', '411002', 'Mme', 'MARTIN', 'Anne', '2 quai de Loire', '', '44000', 'NANTES', '2018-06-05 00:00:00', 50, 60, 0, 1),
('C00003', 'C', '411003', 'M.', 'BERNARD', 'Luc', '3 place du Port', '', '29200', 'BREST', '2018-06-12 00:00:00', 0, 0, 0, 0),
('B00001', 'B', '411001', 'M.', 'DUPONT', 'Jean', '1 rue de la Paix', '', '75001', 'PARIS', '2018-06-11 00:00:00', 10, 12, 0, 0);
INSERT INTO Fiches_AdrlivC (code, rs_soc, nom, pnm, adr1, adr2, cd_ptl, ville) VALUES
(411001, 'SARL', 'DUPONT LIVRAISON', '', '10 avenue Foch', 'Entrepot 2', '69001', 'LYON');
INSERT INTO Fiches_AdrlivBL (numbl, nom, adr1, adr2, cp, ville) VALUES
('C00002', 'CHANTIER MARTIN', '5 rue du Chantier', 'Lot 4', '35000', 'RENNES');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, pu_ligbl, netht_ligbl, nettc_ligbl, typel_ligbl, com_ligbl, four_ligbl) VALUES
('C00001', '1', '001', 'Produit 2.10', '2', '10', '20', '24', 'A', NULL, NULL),
('C00001', '2', '002', 'Produit 7.00', '1', '80', '80', '96', 'A', NULL, '401002'),
('C00001', '3', 'YY', '', '0', '0', '0', '0', 'C', 'Livrer le matin\nSonner deux fois', NULL),
('C00001', '4', 'XX', '', '0', '0', '0', '0', 'C', 'VEHICULE\nIMMAT --------> AB-123-CD\nMODELE -----> CLIO\nSERIE ---------> VF1234', NULL),
('C00002', '1', '001', 'Produit 2.10', '5', '10', '50', '60', 'A', NULL, NULL),
('C00002', '2', 'XX', '', '0', '0', '0', '0', 'C', 'VEHICULE\nIMMAT --------> EF-456-GH', NULL),
('C00002', '3', '', '', '0', '0', '0', '0', 'C', 'Reliquat de la commande C00001', NULL),
('B00001', '1', '001', 'Produit 2.10', '1', '10', '10', '12', 'A', NULL, NULL);
