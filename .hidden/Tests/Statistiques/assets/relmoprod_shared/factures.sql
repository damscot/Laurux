-- Jeu RelMoprod : factures historisées (MO, articles, commentaire, code répété dans une facture), factures F en cours imprimées et non imprimées, client 411003 sans facture.
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac, totfac) VALUES
('0000401', '411001', 'A Divers', '2018-02-10 00:00:00', 104),
('0000402', '411002', 'B Divers', '2018-03-12 00:00:00', 31);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, fam_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('0000401', '000001', '01', 'Mo T1', '10', '2', '56,00', 'M'),
('0000401', '000002', '001', 'Produit 2.10', '01', '3', '30,00', 'A'),
('0000401', '000003', '001', 'Produit 2.10', '01', '1', '10,00', 'A'),
('0000401', '000004', '', 'Commentaire', '', NULL, NULL, 'C'),
('0000401', '000005', '002', 'Produit 7.00', '02', '1', '8,00', 'A'),
('0000402', '000001', '02', 'Mo T2', '10', '1', '31,00', 'M');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, imp, numfac, totalht) VALUES
('000401', 'F', '411001', 'A Divers', '2018-04-02 00:00:00', 1, '0000451', 35),
('000402', 'F', '411002', 'B Divers', '2018-04-03 00:00:00', 0, '0000452', 28);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, qte_ligbl, netht_ligbl, typel_ligbl) VALUES
('000401', '000001', '03', 'Mo T3', '10', '1', '35,00', 'M'),
('000402', '000001', '01', 'Mo T1', '10', '1', '28,00', 'M');
