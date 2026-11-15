-- Jeu Imp_Sig T02/T05 (agent 3, vague 7) : exercice 2018 (Fiches_Mvt) : vente 707000 175,00, achat 607000 40,00 ;
-- exercice N-2 2016 (Fiches_Mvt2) : ventes 707000 300,00 validée et 50,00 non validée, achat 607000 120,00 validé
-- et 30,00 non validé, charge 625100 20,00 validée.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',175.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,175.00,1,0,0,0,NULL,0,0),
('60',2,2,'401001',0,'A Divers','2018-03-01 00:00:00','A002','Achat A002',0.00,40.00,1,0,0,0,NULL,0,0),
('60',2,2,'607000',0,'Achats','2018-03-01 00:00:00','A002','Achat A002',40.00,0.00,1,0,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt2 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',11,11,'411001',0,'A Divers','2016-04-10 00:00:00','F011','Facture F011',300.00,0.00,1,0,0,0,NULL,0,0),
('70',11,11,'707000',0,'Ventes','2016-04-10 00:00:00','F011','Facture F011',0.00,300.00,1,0,0,0,NULL,0,0),
('70',12,12,'411001',0,'A Divers','2016-05-10 00:00:00','F012','Facture F012',50.00,0.00,0,0,0,0,NULL,0,0),
('70',12,12,'707000',0,'Ventes','2016-05-10 00:00:00','F012','Facture F012',0.00,50.00,0,0,0,0,NULL,0,0),
('60',13,13,'401001',0,'A Divers','2016-06-01 00:00:00','A013','Achat A013',0.00,120.00,1,0,0,0,NULL,0,0),
('60',13,13,'607000',0,'Achats','2016-06-01 00:00:00','A013','Achat A013',120.00,0.00,1,0,0,0,NULL,0,0),
('60',14,14,'401001',0,'A Divers','2016-07-01 00:00:00','A014','Achat A014',0.00,30.00,0,0,0,0,NULL,0,0),
('60',14,14,'607000',0,'Achats','2016-07-01 00:00:00','A014','Achat A014',30.00,0.00,0,0,0,0,NULL,0,0),
('60',15,15,'401001',0,'A Divers','2016-08-01 00:00:00','A015','Frais A015',0.00,20.00,1,0,0,0,NULL,0,0),
('60',15,15,'625100',0,'Deplacements','2016-08-01 00:00:00','A015','Frais A015',20.00,0.00,1,0,0,0,NULL,0,0);
