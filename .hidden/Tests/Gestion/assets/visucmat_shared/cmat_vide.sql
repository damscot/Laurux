-- Visucmat : options boissons sans mouvement de régie.
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
