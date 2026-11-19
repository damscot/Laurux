-- Jeu de données des options métier « bois » (boissons) et « pp » (produits pétroliers) :
-- structure créée par modfichier.fichierboisson et modfichier.fichiercarbu (MySQL), reproduite
-- sans passer par les préférences (écrans Tregie, Tregion, Ttarfioul, atribvignette...).
CREATE TABLE Fiches_regie (code char(2) NOT NULL, nom varchar(30), tauxa decimal(9,4), degres integer,
  tauxss decimal(9,4), type char(1), suspendu boolean, ap boolean, drfac boolean, cdcompt integer, ttva char(2),
  PRIMARY KEY (code)) ENGINE=InnoDB;
CREATE TABLE Fiches_consigne (code char(2) NOT NULL, libelle varchar(30), prix decimal(6,2), type char(1),
  PRIMARY KEY (code)) ENGINE=InnoDB;
CREATE TABLE Fiches_ligcons (num char(15), numlig char(12), type char(1), codecons char(2), nb int,
  montant decimal(8,2), envaleur boolean, bloc varchar(33), code int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (code)) ENGINE=InnoDB;
CREATE TABLE Fiches_ligregie (dtmouv date, num char(15), numlig char(12), type char(1), codeart char(15),
  coderegie char(2), qte decimal(8,3), volume decimal(7,2), degres decimal(5,2), volumeap decimal(6,2),
  montdr decimal(8,2), txtvadr char(5), montss decimal(7,2), txtvass char(5), vignette char(25), cloture boolean,
  code int NOT NULL AUTO_INCREMENT, volumess decimal(7,2), PRIMARY KEY (code)) ENGINE=InnoDB;
CREATE TABLE Fiches_region (code char(2) NOT NULL, cart char(15) NOT NULL, libelle varchar(30), taux decimal(6,2),
  PRIMARY KEY (code, cart)) ENGINE=InnoDB;
CREATE TABLE Fiches_tarpp (code char(15) NOT NULL, margez decimal(7,2), supqs decimal(6,2), PRIMARY KEY (code)) ENGINE=InnoDB;
CREATE TABLE Fiches_ligtarpp (code char(15) NOT NULL, ligne integer NOT NULL, binf decimal(6,3), bsup decimal(6,3),
  marht decimal(7,2), normht decimal(7,2), supht decimal(7,2), PRIMARY KEY (code, ligne)) ENGINE=InnoDB;
CREATE TABLE Art_Tipp (code char(15) NOT NULL, ticpe integer, PRIMARY KEY (code)) ENGINE=InnoDB;
ALTER TABLE Fiches_Art ADD art_trsp decimal(7,3) DEFAULT 0.000, ADD art_ecof decimal(7,3) DEFAULT 0.000,
  ADD art_trspa decimal(7,3) DEFAULT 0.000, ADD art_trspr decimal(7,3) DEFAULT 0.000,
  ADD art_tsuc decimal(7,3) DEFAULT 0.000, ADD art_remv decimal(7,3) DEFAULT 0.000, ADD art_dra char(2),
  ADD art_volm decimal(7,2) DEFAULT 0.00, ADD art_deg decimal(5,2) DEFAULT 0.00,
  ADD art_montdr decimal(6,3) DEFAULT 0.000, ADD art_montss decimal(6,3) DEFAULT 0.000, ADD art_consp char(2),
  ADD art_nbcol integer, ADD art_consc char(2), ADD art_nbbou integer, ADD art_consb char(2);
ALTER TABLE Fiches_Cli ADD cli_cons boolean DEFAULT TRUE, ADD cli_tipp char(2), ADD cli_dfin char(1),
  ADD numtipp char(14), ADD numagri char(14), ADD dtagri DATE;
ALTER TABLE Fiches_Parametres ADD conscli char(8), ADD consfou char(8), ADD nvign char(25), ADD css char(8),
  ADD tvass char(2), ADD arrete char(7);
ALTER TABLE Fiches_Ligcom ADD palet integer DEFAULT 0, ADD coli integer DEFAULT 0;
ALTER TABLE Fiches_Societes ADD ident varchar(20), ADD caution varchar(25), ADD tipp char(2);
ALTER TABLE Fiches_AdrlivC ADD tipp char(2), ADD numtipp char(14), ADD numagri char(14), ADD dtagri DATE;
ALTER TABLE Fiches_Ligbl ADD tipp_ligbl char(2), ADD numagri_ligbl char(14), ADD numadr_ligbl integer DEFAULT -1;
ALTER TABLE Fiches_LigblM ADD tipp_ligbl char(2), ADD numagri_ligbl char(14), ADD numadr_ligbl integer DEFAULT -1;
ALTER TABLE Fiches_HistoLigfac ADD tipp_ligfac char(2), ADD numagri_ligfac char(14), ADD numadr_ligfac integer DEFAULT -1;
ALTER TABLE Fiches_HistoLigfacM ADD tipp_ligfac char(2), ADD numagri_ligfac char(14), ADD numadr_ligfac integer DEFAULT -1;
-- Deux régies et une consigne de référence
INSERT INTO Fiches_regie VALUES ('01', 'Vins tranquilles', 1.8000, 0, 0.0000, 'V', 1, 0, 0, 445710, '3');
INSERT INTO Fiches_regie VALUES ('02', 'Alcools', 1800.0000, 18, 590.0000, 'A', 0, 1, 0, 445710, '3');
INSERT INTO Fiches_consigne VALUES ('01', 'Bouteille', 0.20, 'B');
-- TVA de la sécurité sociale (Calculdroit) et deux articles soumis à la régie 02 (alcools, droits en volume AP)
UPDATE Fiches_Parametres SET tvass = '3', css = '445730';
UPDATE Fiches_Art SET art_dra = '02', art_volm = 70, art_deg = 40, art_trsp = 0.5, art_trspr = 0.2, art_trspa = 0.1,
  art_tsuc = 0, art_remv = 0.05, art_frais = 1.5, art_montdr = 0.5, art_montss = 0.3, art_prvt = 11.5, art_ecof = 0.25
  WHERE art_code = '001';
UPDATE Fiches_Art SET art_dra = '02', art_volm = 100, art_deg = 45, art_trsp = 1, art_trspr = 0, art_trspa = 0,
  art_tsuc = 0.15, art_remv = 0, art_frais = 2, art_montdr = 1.2, art_montss = 0.4, art_prvt = 12, art_ecof = 0.3,
  art_tr = 5 WHERE art_code = '002';
-- Régions TIPP (Tregion, rechtipp) : R1 (intitulé + 2 articles), R2 (intitulé seul)
INSERT INTO Fiches_region VALUES ('R1', '0', 'Region un', 0), ('R1', '001', 'Region un', 1.50),
  ('R1', '002', 'Region un', 2.00), ('R2', '0', 'Region deux', 0);
-- ObjFacB : jeu « facturation boisson » (dérivé de modfichier_shared/options_bois_pp, recopié ci-dessus).
-- Régie 03 : bières (type B), droit sur facture (drfac), non suspendue (cassise). Consignes P/C.
INSERT INTO Fiches_regie VALUES ('03', 'Bieres', 3.0000, 0, 0.0000, 'B', 0, 0, 1, 445710, '3');
INSERT INTO Fiches_consigne VALUES ('02', 'Palette', 10.00, 'P'), ('03', 'Caisse', 2.50, 'C');
UPDATE Fiches_Parametres SET conscli = '419700', dtepec = '06.2018', nvign = '100';
-- 001 : régie 02 (alcool, secu), bouteille consignée ; 002 : régie 01 (vin, suspendue) ; 003 : régie 03 (bière)
UPDATE Fiches_Art SET art_consb = '01', art_nbbou = 1 WHERE art_code = '001';
UPDATE Fiches_Art SET art_dra = '01', art_volm = 75, art_deg = 12.5 WHERE art_code = '002';
UPDATE Fiches_Art SET art_dra = '03', art_volm = 33, art_deg = 5 WHERE art_code = '003';
-- 004 : article sans droit ni consigne (copie de 003)
CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_art SET art_code = '004', art_design = 'Sans droit', art_dra = NULL, art_volm = 0, art_deg = 0;
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;
-- Client 411901 (non divers)
CREATE TEMPORARY TABLE tmp_cli AS SELECT * FROM Fiches_Cli WHERE cli_code = 411001;
UPDATE tmp_cli SET cli_code = 411901, cli_nom = 'DURAND', cli_cd_ptl = '75001', cli_ville = 'PARIS', cli_div = 0, cli_cons = 1;
INSERT INTO Fiches_Cli SELECT * FROM tmp_cli;
DROP TEMPORARY TABLE tmp_cli;
-- Lignes : mtx_ligfac renseigné (NULL → Type mismatch à ObjFac.calc:675, cause d'OBJFAC-A09)
-- B00101 : BL boisson non édité (001 x 6 consigné, 002 x 12, 003 x 24)
-- B00102 : BL avec déconsigne seule (article 004) ; B00103 : BL sans droit ni consigne (004)
-- B00104 : facture éditée F00104 (lignes de régie existantes)
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, numfac, totalht, totalttc, imp, gestbl) VALUES
('B00101', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-05 00:00:00', '', 360, 432, 0, 0.00),
('B00102', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-06 00:00:00', '', 10, 12, 0, 0.00),
('B00103', 'B', '411901', 'DURAND', '75001', 'PARIS', '2018-06-07 00:00:00', '', 10, 12, 0, 0.00),
('B00104', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-08 00:00:00', 'F00104', 60, 72, 1, 0.00);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, dec_ligbl, typel_ligbl, dte_ligbl) VALUES
('B00101', '0001', '001', 'Produit 2.10', '01', '10', '6', '60', '0', '60', '1', '2.10', '61.26', '2', 'A', '2018-06-05 00:00:00'),
('B00101', '0002', '002', 'Produit 7.00', '02', '10', '12', '120', '0', '120', '2', '7.00', '128.40', '2', 'A', '2018-06-05 00:00:00'),
('B00101', '0003', '003', 'produit 20.00', '03', '10', '24', '240', '0', '240', '3', '20.00', '288.00', '2', 'A', '2018-06-05 00:00:00'),
('B00102', '0001', '004', 'Sans droit', '03', '10', '1', '10', '0', '10', '3', '20.00', '12.00', '2', 'A', '2018-06-06 00:00:00'),
('B00103', '0001', '004', 'Sans droit', '03', '10', '1', '10', '0', '10', '3', '20.00', '12.00', '2', 'A', '2018-06-07 00:00:00'),
('B00104', '0001', '001', 'Produit 2.10', '01', '10', '6', '60', '0', '60', '1', '2.10', '61.26', '2', 'A', '2018-06-08 00:00:00');
INSERT INTO Fiches_ligcons (num, numlig, type, codecons, nb, montant, envaleur, bloc) VALUES
('B00101', 'B001010001', 'B', '01', 6, 1.20, 1, ''),
('B00101', 'B001010003', 'B', '03', 1, 2.50, 1, ''),
('B00102', 'D', 'B', '01', -12, -2.40, 1, ''),
('B00104', 'B001040001', 'B', '01', 6, 1.20, 1, '');
INSERT INTO Fiches_ligregie (dtmouv, num, numlig, type, codeart, coderegie, qte, volume, degres, volumeap, montdr, txtvadr, montss, txtvass, vignette, cloture, volumess) VALUES
('2018-06-08', 'F00104', 'F001040001', 'B', '001', '02', 6, 4.20, 40, 1.68, 30.24, '20.00', 9.91, '20.00', '', 0, 1.68);
-- Poids (poid) : 001 = 1,5 kg ; 004 = 0,5 kg
UPDATE Fiches_Art SET art_poids = 1.5 WHERE art_code = '001';
UPDATE Fiches_Art SET art_poids = 0.5 WHERE art_code = '004';
-- B00105 : facture F00105 boisson non imprimée (001 x 6 consigné + déconsigne, 002 x 12 régie suspendue)
-- B00106 : facture F00106 sans alcool, numéro déjà présent dans Fiches_HistoFac
-- B00107 : facture F00107 avec dépôt de sortie (cdep, OBJFACB-A01)
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, cpbl, villebl, datebl, numfac, totalht, totalttc, imp, gestbl, cdep) VALUES
('B00105', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-09 00:00:00', 'F00105', 180, 189.66, 0, 0.00, NULL),
('B00106', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-10 00:00:00', 'F00106', 10, 12, 0, 0.00, NULL),
('B00107', 'F', '411901', 'DURAND', '75001', 'PARIS', '2018-06-11 00:00:00', 'F00107', 10, 10.21, 0, 0.00, '01 Depot un');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, fam_ligbl, pu_ligbl, qte_ligbl, brut_ligbl, rem_ligbl, netht_ligbl, tx_ligbl, mtx_ligfac, nettc_ligbl, dec_ligbl, typel_ligbl, dte_ligbl) VALUES
('B00105', '0001', '001', 'Produit 2.10', '01', '10', '6', '60', '0', '60', '1', '2.10', '61.26', '2', 'A', '2018-06-09 00:00:00'),
('B00105', '0002', '002', 'Produit 7.00', '02', '10', '12', '120', '0', '120', '2', '7.00', '128.40', '2', 'A', '2018-06-09 00:00:00'),
('B00106', '0001', '004', 'Sans droit', '03', '10', '1', '10', '0', '10', '3', '20.00', '12.00', '2', 'A', '2018-06-10 00:00:00'),
('B00107', '0001', '001', 'Produit 2.10', '01', '10', '1', '10', '0', '10', '1', '2.10', '10.21', '2', 'A', '2018-06-11 00:00:00');
INSERT INTO Fiches_ligcons (num, numlig, type, codecons, nb, montant, envaleur, bloc) VALUES
('B00105', 'B001050001', 'B', '01', 6, 1.20, 1, ''),
('B00105', 'D', 'B', '01', -6, -1.20, 1, '');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac, totfac) VALUES ('F00106', '411901', 'DURAND', '2018-05-31 00:00:00', 10);
UPDATE Fiches_Parametres SET arrete = '12.2017';
-- Compte comptable du client 411901 (écritures de facturation)
CREATE TEMPORARY TABLE tmp_cpt AS SELECT * FROM Fiches_Comptes WHERE compte_cc = 411001;
UPDATE tmp_cpt SET compte_cc = 411901, intitule_cc = 'DURAND';
INSERT INTO Fiches_Comptes SELECT * FROM tmp_cpt;
DROP TEMPORARY TABLE tmp_cpt;
