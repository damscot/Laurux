-- Jeu Histocliart : ventes (BL en cours, factures historisées) sur 2018, clients 411001-411003, articles 001-003.
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, dtefac, totalht) VALUES
('000101', 'B', '411001', 'A Divers', '2018-04-10 00:00:00', NULL, 30),
('000102', 'F', '411002', 'B Divers', '2018-04-12 00:00:00', '2018-05-02 00:00:00', 14),
('000103', 'D', '411001', 'A Divers', '2018-05-20 00:00:00', NULL, 99);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, qte_ligbl, netht_ligbl, typel_ligbl, mrgart_ligbl, mrgmo_ligbl) VALUES
('000101', '000001', '001', 'Produit 2.10', '01', '3', '30,00', 'A', 7.500, 0),
('000101', '000002', '002', 'Produit 7.00', '02', '1,5', '10,50', 'A', NULL, 1.000),
('000102', '000001', '002', 'Produit 7.00', '02', '2', '14,00', 'A', 4.000, 0),
('000103', '000001', '003', 'produit 20.00', '03', '5', '99,00', 'A', 10.000, 0);
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac, totfac) VALUES
('0000201', '411001', 'A Divers', '2018-02-15 00:00:00', 44),
('0000202', '411003', 'C Divers', '2018-03-01 00:00:00', 60),
('0000203', '411002', 'B Divers', '2017-11-30 00:00:00', 21);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, fam_ligfac, qte_ligfac, netht_ligfac, typel_ligfac, mrgart_ligfac, mrgmo_ligfac) VALUES
('0000201', '000001', '001', 'Produit 2.10', '01', '2', '20,00', 'A', 5.000, 0),
('0000201', '000002', '002', 'Produit 7.00', '02', '3', '24,00', 'A', 6.000, 2.000),
('0000201', '000003', '', 'Commentaire', '', NULL, NULL, 'C', NULL, NULL),
('0000202', '000001', '003', 'produit 20.00', '03', '3', '60,00', 'A', 12.000, 0),
('0000203', '000001', '001', 'Produit 2.10', '01', '7', '21,00', 'A', 3.000, 0);
-- Tickets : bloc 000001 en versions A et S (la version S est retenue), ticket 0000002 supprimé.
INSERT INTO Fiches_HisEntTickets (caisse, numero, client, mht, suppr, type, date) VALUES
('01', '0000001', '411001', '9,10', 0, 'T', '2018-05-05 11:00:00'),
('01', '0000002', '411002', '180,00', 1, 'T', '2018-05-06 11:00:00');
INSERT INTO Fiches_HisLigTickets (numero, numlig, code, intitule, montant, qte, type, fam, mht, block, date) VALUES
('0000001', '000001', '001', 'Produit 2.10', '2,52', '2', 'A', '01', '4,20', '000001', '2018-05-05 11:00:00'),
('0000001', '000001', '001', 'Produit 2.10', '2,52', '1', 'S', '01', '2,10', '000001', '2018-05-05 11:00:00'),
('0000001', '000002', '002', 'Produit 7.00', '8,40', '1', 'A', '02', '7,00', '000002', '2018-05-05 11:00:00'),
('0000002', '000001', '003', 'produit 20.00', '24,00', '9', 'A', '03', '180,00', '000001', '2018-05-06 11:00:00');
