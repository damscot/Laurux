-- Jeu CecritTest : écritures (collectif NULL) validées / non validées, de trésorerie ou non, provisoires ou non.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('50',2,2,'512000',NULL,'Banque','2018-03-05 00:00:00','CHQ1','Reglement F001',120.00,0.00,1,0,1,0,NULL,0,0),
('50',2,2,'411001',NULL,'A Divers','2018-03-05 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,0,0),
('60',3,0,'606100',NULL,'Fournitures','2018-05-02 00:00:00','A001','Achat A001',40.00,0.00,0,0,0,0,NULL,0,0),
('60',3,0,'401001',NULL,'A Divers','2018-05-02 00:00:00','A001','Achat A001',0.00,40.00,0,0,0,0,NULL,0,0),
('50',4,0,'512000',NULL,'Banque','2018-04-01 00:00:00','VIR2','Virement recu',75.50,0.00,0,1,1,0,NULL,0,0),
('50',4,0,'411002',NULL,'B Divers','2018-04-01 00:00:00','VIR2','Virement recu',0.00,75.50,0,1,1,0,NULL,0,0),
('10',5,5,'512000',NULL,'Banque','2018-01-15 00:00:00','RB1','Remise banque',10.00,0.00,1,1,1,0,NULL,0,0),
('10',5,5,'580000',0,'Virements','2018-01-15 00:00:00','RB1','Remise banque',0.00,10.00,1,1,1,0,NULL,0,0);
