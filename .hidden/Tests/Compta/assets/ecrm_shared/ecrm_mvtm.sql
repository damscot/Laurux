-- Jeu de données EcrM (agent 3, vague 3) : écritures modifiées/supprimées (Fiches_MvtM, exercice 2018)
-- et une écriture dans Fiches_MvtM1 (exercice 2017). supprimee NULL / 0 = modifiée, 1 = supprimée.
-- Toutes les lignes ont un datem renseigné (le cas datem NULL est un jeu à part).
INSERT INTO Fiches_MvtM (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,lind2,datem,supprimee) VALUES
('70',1,1,'411001',1,'A Divers','2018-02-10 00:00:00','F001','Fac F001',120.00,0.00,1,0,0,0,NULL,0,0,1,'2018-02-12 09:00:00',NULL),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Fac F001',0.00,100.00,1,0,0,0,NULL,0,0,2,'2018-02-12 09:00:00',NULL),
('70',1,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Fac F001',0.00,20.00,1,0,0,0,NULL,0,0,3,'2018-02-12 09:00:00',NULL),
('60',2,2,'401001',1,'A Divers','2018-03-01 00:00:00','A002','Fac A002',0.00,240.00,1,0,0,0,NULL,0,0,1,'2018-03-02 10:00:00',0),
('60',2,2,'607000',0,'Achats','2018-03-01 00:00:00','A002','Fac A002',200.00,0.00,1,0,0,0,NULL,0,0,2,'2018-03-02 10:00:00',0),
('60',2,2,'445660',0,'Tva','2018-03-01 00:00:00','A002','Fac A002',40.00,0.00,1,0,0,0,NULL,0,0,3,'2018-03-02 10:00:00',0),
('70',3,3,'411001',1,'A Divers','2018-01-20 00:00:00','F003','Avo F003',0.00,60.00,1,0,0,0,NULL,0,0,1,'2018-04-01 11:00:00',1),
('70',3,3,'707000',0,'Ventes','2018-01-20 00:00:00','F003','Avo F003',50.00,0.00,1,0,0,0,NULL,0,0,2,'2018-04-01 11:00:00',1),
('70',3,3,'445730',0,'Tva','2018-01-20 00:00:00','F003','Avo F003',10.00,0.00,1,0,0,0,NULL,0,0,3,'2018-04-01 11:00:00',1),
('50',4,4,'411001',1,'A Divers','2018-05-05 00:00:00','CHQ4','Reglement F001',0.00,120.00,1,0,1,0,NULL,0,0,1,'2018-05-06 08:00:00',1),
('50',4,4,'512000',0,'Banque','2018-05-05 00:00:00','CHQ4','Reglement F001',120.00,0.00,1,0,1,0,NULL,0,0,2,'2018-05-06 08:00:00',1);
INSERT INTO Fiches_MvtM1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,lind2,datem,supprimee) VALUES
('70',9,9,'411002',1,'B Divers','2017-06-10 00:00:00','F009','Fac F009',30.00,0.00,1,0,0,0,NULL,0,0,1,'2017-06-11 09:00:00',NULL),
('70',9,9,'707000',0,'Ventes','2017-06-10 00:00:00','F009','Fac F009',0.00,30.00,1,0,0,0,NULL,0,0,2,'2017-06-11 09:00:00',NULL);
