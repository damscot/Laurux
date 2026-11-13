-- Jeu Edittipp : option TIPP (structure de modfichier : Fiches_region, tipp_ligbl, tipp_ligfac, cli_dfin) ; article
-- 001 présent dans deux régions (R1, R2) ; mars 2018 : BL B00001 facturé F0001 (présent aussi en historique de
-- factures), BL B00002 non facturé ; un BL d'avril hors période.
CREATE TABLE Fiches_region (code char(2), cart char(15), libelle varchar(30), taux decimal(6,2), PRIMARY KEY (code, cart));
INSERT INTO Fiches_region VALUES ('R1', '001', 'Région 1', 1.50), ('R2', '001', 'Région 2', 2.00);
ALTER TABLE Fiches_Cli ADD cli_dfin char(1);
UPDATE Fiches_Cli SET cli_dfin = 'A', cli_siret = '12345678900011' WHERE cli_code = 411001;
ALTER TABLE Fiches_Ligbl ADD tipp_ligbl char(2);
ALTER TABLE Fiches_HistoLigfac ADD tipp_ligfac char(2);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, numfac) VALUES ('B00001', 'F', '411001', 'F0001'), ('B00002', 'B', '411001', NULL), ('B00003', 'B', '411001', NULL);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, dte_ligbl, tipp_ligbl) VALUES ('B00001', '001', '001', '100', '2018-03-10 00:00:00', 'R1'), ('B00002', '001', '001', '50', '2018-03-20 00:00:00', 'R2'), ('B00003', '001', '001', '30', '2018-04-02 00:00:00', 'R1');
INSERT INTO Fiches_HistoFac (numfac, cdclifac) VALUES ('F0001', '411001');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, qte_ligfac, dtligbl_ligfac, tipp_ligfac) VALUES ('F0001', '001', '001', '100', '2018-03-10 00:00:00', 'R1');
