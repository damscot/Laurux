-- Jeu de données des tests RenumBl (RENUMBL-T01/T02), appliqué après Laurux01.sql.
-- 3 BL facturés dont deux avec le même numéro de facture (doublon), 1 BL non facturé ; lignes de BL avec
-- montants à virgule et à point ; lignes de factures de types variés.
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, numfac, dtefac, totalht, totalttc) VALUES ('000001', 'B', '411001', 'Client Un', '2024-01-10 00:00:00', '240001', '2024-01-31 00:00:00', 100, 120);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, numfac, dtefac, totalht, totalttc) VALUES ('000002', 'B', '411001', 'Client Un', '2024-01-15 00:00:00', '240001', '2024-01-31 00:00:00', 50, 60);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, numfac, dtefac, totalht, totalttc) VALUES ('000003', 'B', '411002', 'Client Deux', '2024-02-03 00:00:00', '240002', '2024-02-29 00:00:00', 30, 36);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, numfac, dtefac, totalht, totalttc) VALUES ('000004', 'B', '411002', 'Client Deux', '2024-02-10 00:00:00', NULL, NULL, 10, 12);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES ('000001', '000001', '001', 'Produit 2.10', '12,50', '8', '100,00', '0', '100,00', '1', '120,00', 'A');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES ('000002', '000001', '002', 'Produit 7.00', '25.5', '2', '51', '1.5', '50.235', '1', '60.28', 'A');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES ('000003', '000001', '003', 'produit 20.00', '30', '1', '30', '', '30', '2', '36', 'T');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES ('000004', '000001', '001', 'Produit 2.10', '10', '1', '10', '0', '10', '1', '12', 'A');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, pu_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES ('240001', '000001', '001', 'Produit 2.10', '12,50', '8', '100,00', 'A');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, pu_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES ('240001', '000002', '', 'Commentaire', '', '', '', 'C');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, pu_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES ('240002', '000001', '003', 'produit 20.00', '30', '1', '30', 'T');
