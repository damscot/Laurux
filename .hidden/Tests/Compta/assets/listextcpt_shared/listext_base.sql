-- Jeu de données Listextcpt (agent 10, vague 3) : écritures sur 3 exercices (2016 = Fiches_Mvt2, 2017 = Fiches_Mvt1,
-- 2018 = Fiches_Mvt). Lot L1 lettré à cheval sur 2016/2017 (411001) ; à-nouveau jdr '90' en 2018 ; lot A lettré
-- équilibré, lot B non lettré déséquilibré de 0,01 ; règlement banque pointé (nrlv 1) ; une écriture provisoire.
INSERT INTO Fiches_Mvt2 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',101,101,'411001',0,'A Divers','2016-05-10 00:00:00','F016','L1','Facture F016',50.00,0.00,1,0,0,0,NULL,1,1),
('70',101,101,'707000',0,'Ventes','2016-05-10 00:00:00','F016',NULL,'Facture F016',0.00,50.00,1,0,0,0,NULL,0,1);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('50',201,201,'411001',0,'A Divers','2017-02-01 00:00:00','CHQ16','L1','Reglement F016',0.00,50.00,1,0,1,0,NULL,1,1),
('50',201,201,'512000',0,'Banque','2017-02-01 00:00:00','CHQ16',NULL,'Reglement F016',50.00,0.00,1,0,1,1,1,0,1),
('70',202,202,'411001',0,'A Divers','2017-06-01 00:00:00','F017',NULL,'Facture F017',80.00,0.00,1,0,0,0,NULL,0,1),
('70',202,202,'707000',0,'Ventes','2017-06-01 00:00:00','F017',NULL,'Facture F017',0.00,80.00,1,0,0,0,NULL,0,1);
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('90',1,1,'411001',0,'A Divers','2018-01-01 00:00:00','AN',NULL,'A nouveau',80.00,0.00,1,0,0,0,NULL,0,0),
('90',1,1,'890000',0,'Bilan','2018-01-01 00:00:00','AN',NULL,'A nouveau',0.00,80.00,1,0,0,0,NULL,0,0),
('70',2,2,'411001',0,'A Divers','2018-02-10 00:00:00','F001','A','Facture F001',120.00,0.00,1,0,0,0,NULL,1,0),
('70',2,2,'707000',0,'Ventes','2018-02-10 00:00:00','F001',NULL,'Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('50',3,3,'411001',0,'A Divers','2018-03-05 00:00:00','CHQ1','A','Reglement F001',0.00,120.00,1,0,1,0,NULL,1,0),
('50',3,3,'512000',0,'Banque','2018-03-05 00:00:00','CHQ1',NULL,'Reglement F001',120.00,0.00,1,0,1,1,1,0,0),
('70',4,4,'411001',0,'A Divers','2018-04-12 00:00:00','F002','B','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',4,4,'707000',0,'Ventes','2018-04-12 00:00:00','F002',NULL,'Facture F002',0.00,60.00,1,0,0,0,NULL,0,0),
('50',5,5,'411001',0,'A Divers','2018-05-02 00:00:00','CHQ2','B','Reglement F002',0.00,59.99,1,0,1,0,NULL,0,0),
('50',5,5,'512000',0,'Banque','2018-05-02 00:00:00','CHQ2',NULL,'Reglement F002',59.99,0.00,1,0,1,0,NULL,0,0),
('70',6,6,'411001',0,'A Divers','2018-06-01 00:00:00','F003',NULL,'Facture provisoire',30.00,0.00,0,1,0,0,NULL,0,0),
('60',7,7,'401001',0,'A Divers','2018-05-20 00:00:00','A001',NULL,'Achat A001',0.00,40.00,1,0,0,0,NULL,0,0),
('60',7,7,'606100',0,'Fournitures','2018-05-20 00:00:00','A001',NULL,'Achat A001',40.00,0.00,1,0,0,0,NULL,0,0);
