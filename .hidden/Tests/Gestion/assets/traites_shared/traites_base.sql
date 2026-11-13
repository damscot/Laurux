-- Traites : 3 traites (411001 et 411002 avec coordonnées bancaires, 999999 client inexistant : ligne non imprimée).
UPDATE Fiches_Cli SET cli_cd_bq = '30004', cli_cd_gch = '00123', cli_num_cpt = '00012345678', cli_cle_rib = '45', cli_dmln = 'BNP PARIS', cli_adr1 = '1 rue A', cli_adr2 = '', cli_cd_ptl = '75001', cli_ville = 'PARIS' WHERE cli_code IN (411001, 411002);
INSERT INTO Fiches_Traites (code, montant, date, datech, numfac, imp, nom, acceptee, ecartee) VALUES
('411001','120.00','2018-06-01','2018-07-31','F00101',0,'A Divers',0,0),
('411002','80.50','2018-06-05','2018-08-31','F00102',0,'B Divers',0,0),
('999999','10.00','2018-06-10','2018-07-10','F00103',0,'Inconnu',0,0);
