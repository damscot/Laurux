-- RUBIMP-T02 : exercice 2018 en perte (charges 606100 + 613200 > ventes 707000), une écriture non validée
-- (validee = 0) ; exercice 2017 (Fiches_Mvt1) en bénéfice.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('60',2,2,'606100',0,'Fournitures','2018-03-02 00:00:00','A001','Achat A001',250.00,0.00,1,0,0,0,NULL,0,0),
('60',2,2,'401001',0,'A Divers','2018-03-02 00:00:00','A001','Achat A001',0.00,250.00,1,0,0,0,NULL,0,0),
('60',3,3,'613200',0,'Locations','2018-04-02 00:00:00','A002','Loyer avril',80.00,0.00,1,0,0,0,NULL,0,0),
('60',3,3,'401002',0,'B Divers','2018-04-02 00:00:00','A002','Loyer avril',0.00,80.00,1,0,0,0,NULL,0,0),
('70',4,NULL,'707000',0,'Ventes','2018-05-02 00:00:00','F002','Facture non validee',0.00,500.00,0,1,0,0,NULL,0,0),
('70',4,NULL,'411002',0,'B Divers','2018-05-02 00:00:00','F002','Facture non validee',500.00,0.00,0,1,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2017-06-01 00:00:00','F000','Facture F000',300.00,0.00,1,0,0,0,NULL,0,1),
('70',1,1,'707000',0,'Ventes','2017-06-01 00:00:00','F000','Facture F000',0.00,300.00,1,0,0,0,NULL,0,1),
('60',2,2,'606100',0,'Fournitures','2017-07-01 00:00:00','A000','Achat A000',90.00,0.00,1,0,0,0,NULL,0,1),
('60',2,2,'401001',0,'A Divers','2017-07-01 00:00:00','A000','Achat A000',0.00,90.00,1,0,0,0,NULL,0,1);
