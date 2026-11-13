-- Jeu Echeancier : factures 411/401 validées non lettrées avec dateech sur l'exercice 2018, règlements de lot
-- (tresorerie = 1), clients de deux modes (cli_reg 05 Chèque, 20 Virement), une ligne lettrée et une ligne
-- collective (exclues).
UPDATE Fiches_Cli SET cli_reg = '05' WHERE cli_code = '411001';
UPDATE Fiches_Cli SET cli_reg = '20' WHERE cli_code = '411002';
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, dateech, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, lettree, cloturee) VALUES
('01',1,'411001',NULL,'A Divers','2018-03-01','2018-03-31','F1','L000000001','Facture F1',120.00,0.00,1,0,0,0,0,0),
('03',2,'411001',NULL,'A Divers','2018-03-15','2018-03-15','R1','L000000001','Acompte F1',0.00,50.00,1,0,1,0,0,0),
('01',3,'411002',NULL,'B Divers','2018-02-01','2018-02-28','F2','L000000002','Facture F2',200.00,0.00,1,0,0,0,0,0),
('01',4,'411001',NULL,'A Divers','2018-04-15','2018-05-15','F3','L000000003','Facture F3',80.00,0.00,1,0,0,0,0,0),
('01',5,'411003',NULL,'C Divers','2018-04-20','2018-05-20','F4','L000000004','Facture F4 lettree',40.00,0.00,1,0,0,0,1,0),
('01',6,'411000',1,'Collectif','2018-04-20','2018-05-20','F4','L000000004','Ligne collective',40.00,0.00,1,0,0,0,0,0),
('02',7,'401001',NULL,'A Divers','2018-04-01','2018-04-30','A1','L000000011','Achat A1',0.00,300.00,1,0,0,0,0,0),
('03',8,'401001',NULL,'A Divers','2018-04-10','2018-04-10','P1','L000000011','Paiement partiel A1',100.00,0.00,1,0,1,0,0,0),
('02',9,'401002',NULL,'B Divers','2018-01-05','2018-01-31','A2','L000000012','Achat A2',0.00,60.00,1,0,0,0,0,0);
