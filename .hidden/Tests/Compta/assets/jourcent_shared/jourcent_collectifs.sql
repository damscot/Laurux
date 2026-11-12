-- Jeu Jourcent T02 (agent 5, vague 3) : journal 70 (VE) avec collectif 411000 + détail 411001/411002,
-- journal 60 (AC) avec collectif 401000 + détail 401001 ; deux pièces par journal (cumul des collectifs).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411000',1,'Collectif client','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('70',2,2,'411000',1,'Collectif client','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',0,'B Divers','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-03-12 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',2,2,'445730',0,'Tva','2018-03-12 00:00:00','F002','Facture F002',0.00,10.00,1,0,0,0,NULL,0,0),
('60',3,3,'401000',1,'Collectif fournisseur','2018-04-05 00:00:00','A001','Achat A001',0.00,48.00,1,0,0,0,NULL,0,0),
('60',3,3,'401001',0,'A Divers','2018-04-05 00:00:00','A001','Achat A001',0.00,48.00,1,0,0,0,NULL,0,0),
('60',3,3,'607000',0,'Achats','2018-04-05 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0),
('60',3,3,'445660',0,'Tva deductible','2018-04-05 00:00:00','A001','Achat A001',8.00,0.00,1,0,0,0,NULL,0,0),
('60',4,4,'401000',1,'Collectif fournisseur','2018-05-07 00:00:00','A002','Achat A002',0.00,24.00,1,0,0,0,NULL,0,0),
('60',4,4,'401001',0,'A Divers','2018-05-07 00:00:00','A002','Achat A002',0.00,24.00,1,0,0,0,NULL,0,0),
('60',4,4,'607000',0,'Achats','2018-05-07 00:00:00','A002','Achat A002',20.00,0.00,1,0,0,0,NULL,0,0),
('60',4,4,'445660',0,'Tva deductible','2018-05-07 00:00:00','A002','Achat A002',4.00,0.00,1,0,0,0,NULL,0,0);
