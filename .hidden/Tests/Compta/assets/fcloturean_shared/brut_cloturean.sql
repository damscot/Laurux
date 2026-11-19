-- FClotureAn (jeu brut, clés NULL) : généré par Compta/assets/fcloturean_shared/gen_fcloturean.py.
UPDATE Fiches_Parametres SET dtepc = '2018-12-31', numecriture = 9, numecriture2 = 9;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numcol,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee,lind,control) VALUES
('70',1,1,'512000',0,'Banque','2018-01-05 00:00:00','0','C001','','Ecriture 1',1000.00,0.00,1,0,0,0,0,1,1,NULL),
('70',1,1,'101000',0,'Capital','2018-01-05 00:00:00','0','C001','','Ecriture 1',0.00,1000.00,1,0,0,0,0,1,2,NULL),
('60',2,2,'607000',0,'Achat','2018-03-10 00:00:00','0','A002','','Ecriture 2',300.00,0.00,1,0,0,0,0,1,3,NULL),
('70',2,2,'512000',0,'Banque','2018-03-10 00:00:00','0','A002','','Ecriture 2',0.00,300.00,1,0,0,0,0,1,4,NULL),
('70',3,3,'512000',0,'Banque','2018-06-20 00:00:00','0','V003','','Ecriture 3',800.00,0.00,1,0,0,0,0,1,5,NULL),
('70',3,3,'707000',0,'Ventes','2018-06-20 00:00:00','0','V003','','Ecriture 3',0.00,800.00,1,0,0,0,0,1,6,NULL),
('70',4,4,'411001',0,'A Divers','2018-09-15 00:00:00','0','F004','','Ecriture 4',120.00,0.00,1,0,0,0,0,1,7,NULL),
('60',4,4,'401001',0,'A Divers','2018-09-15 00:00:00','0','F004','','Ecriture 4',0.00,120.00,1,0,0,0,0,1,8,NULL),
('70',5,5,'411000',1,'Collectif client','2018-09-15 00:00:00','0','F005','','Ecriture 5',120.00,0.00,1,0,0,0,0,1,9,NULL),
('60',5,5,'401000',1,'Collectif fournisseur','2018-09-15 00:00:00','0','F005','','Ecriture 5',0.00,120.00,1,0,0,0,0,1,10,NULL),
('70',6,6,'411001',0,'A Divers','2019-01-10 00:00:00','0','V006','','Ecriture 6',50.00,0.00,1,0,0,0,0,1,11,NULL),
('70',6,6,'707000',0,'Ventes','2019-01-10 00:00:00','0','V006','','Ecriture 6',0.00,50.00,1,0,0,0,0,0,12,NULL),
('70',7,7,'512000',0,'Banque','2019-01-12 00:00:00','0','A007','','Ecriture 7',30.00,0.00,1,0,0,0,0,0,13,NULL),
('60',7,7,'401001',0,'A Divers','2019-01-12 00:00:00','0','A007','','Ecriture 7',0.00,30.00,1,0,0,0,0,0,14,NULL),
('60',8,0,'607000',0,'Achat','2019-01-20 00:00:00','0','A008','','Ecriture 8',20.00,0.00,0,1,0,0,0,0,15,NULL),
('70',8,0,'512000',0,'Banque','2019-01-20 00:00:00','0','A008','','Ecriture 8',0.00,20.00,0,1,0,0,0,0,16,NULL),
('70',9,9,'999999',0,'Compte absent','2019-02-01 00:00:00','0','D009','','Ecriture 9',10.00,0.00,1,0,0,0,0,0,17,NULL),
('70',9,9,'512000',0,'Banque','2019-02-01 00:00:00','0','D009','','Ecriture 9',0.00,10.00,1,0,0,0,0,0,18,NULL),
('60',10,10,'606100',0,'Fournitures','2018-11-30 00:00:00','0','D010','','Ecriture 10',15.00,0.00,1,0,0,0,0,1,19,NULL);
INSERT INTO Fiches_MvtA (numero,compte,intitule,dte,numdoc,libelle,pourcent,montantd,montantc,jour,poste,validee) VALUES
(2,'607000','Achat','2018-03-10 00:00:00','A002','Analytique 2018',100,300.00,0.00,'60','P1',1),
(6,'707000','Ventes','2019-01-10 00:00:00','V006','Analytique 2019',100,0.00,50.00,'70','P2',1);
INSERT INTO Fiches_MvtM (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,lettree,cloturee,pointee,control,lind2,lind,datem,supprimee) VALUES
('70',50,50,'707000',0,'Ventes','2018-05-02 00:00:00','M050','','Modifiee 2018',0.00,40.00,1,0,0,0,1,0,'MODIF2018',1,1,'2018-05-03 00:00:00',0),
('70',51,51,'707000',0,'Ventes','2019-01-15 00:00:00','M051','','Modifiee 2019',0.00,60.00,1,0,0,0,0,0,'MODIF2019',2,2,'2019-01-16 00:00:00',1);
