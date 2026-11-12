-- Jeu de données CHANGEFAM-T01 à T07, T10 (Changefam) : tables de travail absentes de Laurux01.sql mais
-- verrouillées par Changefam.verrou() (Rupture, RuptureC créées comme Crupt.Rupture ; Fiches_Inv, Fiches_InvT
-- réduites aux colonnes utilisées), et historique des articles 001 / 002 (BL, facture, ticket, réception,
-- inventaire, tarif client, promotion, rupture). Les familles 01, 02, 03 et les codes-barres viennent de Laurux01.sql.
CREATE TABLE Rupture (codea Char(15) NOT NULL, intitulea Char(50), four Char(8), qtecli FLOAT, qtefour FLOAT,
  qtecom FLOAT, codec Char(8) NOT NULL, intitulec Char(50), numcom Char(50),
  PRIMARY KEY (codea, codec, intitulea, four)) ENGINE = InnoDB;
CREATE TABLE RuptureC (codea Char(15) NOT NULL, intitulea Char(50), four Char(8), qtecom FLOAT, qte FLOAT,
  codec Char(8), intitulec Char(50), numcom Char(50), PRIMARY KEY (codea, codec, numcom, intitulea, four)) ENGINE = InnoDB;
CREATE TABLE Fiches_Inv (inv_nlig int(11) NOT NULL, inv_code varchar(15) DEFAULT NULL, PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
CREATE TABLE Fiches_InvT (inv_code varchar(15) NOT NULL, inv_comptee tinyint(1) DEFAULT 0, PRIMARY KEY (inv_code)) ENGINE = InnoDB;

INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, fam_ligbl) VALUES ('B00001', '1', '001', '01'), ('B00001', '2', '002', '02');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, fam_ligfac) VALUES ('F0000001', '1', '001', '01'), ('F0000001', '2', '003', '03');
INSERT INTO Fiches_HisLigTickets (numero, numlig, code, fam) VALUES ('T000001', '1', '001', '01'), ('T000001', '2', '002', '02');
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne) VALUES ('001', 'R0001', '401001', '2025-01-10 00:00:00', '1');
INSERT INTO Fiches_Tarcli (ccli, cart, coef) VALUES ('411002', '001', 1.5);
INSERT INTO Fiches_Promo (code, libelle, datedeb, datefin) VALUES ('PRO1', 'Promo', '2025-01-01', '2026-12-31');
INSERT INTO Fiches_ArtPromo (code_promo, code, libelle, pmp, pht, pttc, qte) VALUES ('PRO1', '001', 'Promo', 0, 5, 6, 0);
INSERT INTO Fiches_Inv (inv_nlig, inv_code) VALUES (1, '001'), (2, '002');
INSERT INTO Fiches_InvT (inv_code, inv_comptee) VALUES ('001', 0);
INSERT INTO Rupture (codea, intitulea, four, qtecli, qtefour, qtecom, codec, intitulec, numcom) VALUES ('001', 'Produit 2.10', '401001', 1, 0, 0, '411001', 'A Divers', 'C1');
INSERT INTO RuptureC (codea, intitulea, four, qtecom, qte, codec, intitulec, numcom) VALUES ('001', 'Produit 2.10', '401001', 0, 1, '411001', 'A Divers', 'C1');
