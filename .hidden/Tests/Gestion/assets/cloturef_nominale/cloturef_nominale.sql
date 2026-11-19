-- ClotureF T01 (CLOTUREF-T01) : clôture nominale de mai 2018.
-- Client 411901 DURAND et son compte ; période à clôturer mai 2018 (dtepp 04.2018, dtepec 05.2018).
UPDATE Fiches_Parametres SET dtepp = '04.2018', dtepec = '05.2018';
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411901, cli_nom = 'DURAND', cli_cd_ptl = '75001', cli_ville = 'PARIS', cli_div = 0;
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
CREATE TEMPORARY TABLE tmp_cpt AS SELECT * FROM Fiches_Comptes WHERE compte_cc = 411001;
UPDATE tmp_cpt SET compte_cc = 411901, intitule_cc = 'DURAND', solde = 0;
INSERT INTO Fiches_Comptes SELECT * FROM tmp_cpt;
DROP TEMPORARY TABLE tmp_cpt;
-- Écriture validée de la facture F00201 (recalcul des soldes)
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('70',1,1,'411901',NULL,'DURAND','2018-05-10 00:00:00','F00201','FACTURE DURAND',120.00,0.00,1,0,0,0,0,0),
('70',1,1,'707020',NULL,'Ventes','2018-05-10 00:00:00','F00201','FACTURE DURAND',0.00,100.00,1,0,0,0,0,0),
('70',1,1,'445730',NULL,'Tva','2018-05-10 00:00:00','F00201','FACTURE DURAND',0.00,20.00,1,0,0,0,0,0);
-- 3 factures imprimées à archiver (mai x 2, avril x 1), 1 non imprimée, 1 imprimée en juin (hors période)
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, numfac, dtefac, ech, totalht, totalttc, imp, gestbl) VALUES
('B00201', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-10 00:00:00', 'F00201', '2018-05-10 00:00:00', '2018-05-10 00:00:00', 100, 120.0, 1, 0.00),
('B00202', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-20 00:00:00', 'F00202', '2018-05-20 00:00:00', '2018-05-20 00:00:00', 50, 60.0, 1, 0.00),
('B00203', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-04-15 00:00:00', 'F00203', '2018-04-15 00:00:00', '2018-04-15 00:00:00', 30, 36.0, 1, 0.00),
('B00204', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-25 00:00:00', 'F00204', NULL, NULL, 40, 48.0, 0, 0.00),
('B00205', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-05 00:00:00', 'F00205', '2018-06-05 00:00:00', '2018-06-05 00:00:00', 60, 72.0, 1, 0.00);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, dec_ligbl, typel_ligbl, dte_ligbl) VALUES
('B00201', '0001', '003', 'produit 20.00', '03', '100', '1', '100', '0', '100', '3', '20.00', '120.00', '2', 'A', '2018-05-10 00:00:00'),
('B00202', '0001', '003', 'produit 20.00', '03', '50', '1', '50', '0', '50', '3', '20.00', '60.00', '2', 'A', '2018-05-20 00:00:00'),
('B00203', '0001', '003', 'produit 20.00', '03', '30', '1', '30', '0', '30', '3', '20.00', '36.00', '2', 'A', '2018-04-15 00:00:00'),
('B00204', '0001', '003', 'produit 20.00', '03', '40', '1', '40', '0', '40', '3', '20.00', '48.00', '2', 'A', '2018-05-25 00:00:00'),
('B00205', '0001', '003', 'produit 20.00', '03', '60', '1', '60', '0', '60', '3', '20.00', '72.00', '2', 'A', '2018-06-05 00:00:00');
