-- ClotureF T02 (CLOTUREF-T02) : borne de fin de mois (A01).
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
-- Factures « entretien » (Fiches_BlM) et standard (Fiches_Bl) du dernier jour du mois et de la veille
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, numfac, dtefac, ech, totalht, totalttc, imp, gestbl) VALUES
('B00211', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-31 00:00:00', 'F00211', '2018-05-31 00:00:00', '2018-05-31 00:00:00', 10, 12.0, 1, 0.00),
('B00212', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-30 00:00:00', 'F00212', '2018-05-30 00:00:00', '2018-05-30 00:00:00', 20, 24.0, 1, 0.00);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, dec_ligbl, typel_ligbl, dte_ligbl) VALUES
('B00211', '0001', '003', 'produit 20.00', '03', '10', '1', '10', '0', '10', '3', '20.00', '12.00', '2', 'A', '2018-05-31 00:00:00'),
('B00212', '0001', '003', 'produit 20.00', '03', '20', '1', '20', '0', '20', '3', '20.00', '24.00', '2', 'A', '2018-05-30 00:00:00');
INSERT INTO Fiches_BlM (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, numfac, dtefac, ech, totalht, totalttc, imp, gestbl) VALUES
('E00213', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-31 00:00:00', 'F00213', '2018-05-31 00:00:00', '2018-05-31 00:00:00', 30, 36.0, 1, 0.00),
('E00214', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-05-30 00:00:00', 'F00214', '2018-05-30 00:00:00', '2018-05-30 00:00:00', 40, 48.0, 1, 0.00);
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, dec_ligbl, typel_ligbl, dte_ligbl) VALUES
('E00213', '0001', '003', 'produit 20.00', '03', '30', '1', '30', '0', '30', '3', '20.00', '36.00', '2', 'A', '2018-05-31 00:00:00'),
('E00214', '0001', '003', 'produit 20.00', '03', '40', '1', '40', '0', '40', '3', '20.00', '48.00', '2', 'A', '2018-05-30 00:00:00');
