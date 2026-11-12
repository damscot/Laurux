-- Jeu de données Verbal (agent 10, vague 3) : écritures validées équilibrées de l'exercice 2018 (Fiches_Mvt) sur des
-- comptes C (411001), F (401001), G (707000, 606100), B (445710, 512000) et collectifs B coll = 1 (411000, 401000) ;
-- une écriture non validée (ignorée) ; une écriture 2017 dans Fiches_Mvt1 (exercice antérieur).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'411000',1,'Collectif client','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445710',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('60',2,2,'606100',0,'Fournitures','2018-05-02 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0),
('60',2,2,'401001',0,'A Divers','2018-05-02 00:00:00','A001','Achat A001',0.00,40.00,1,0,0,0,NULL,0,0),
('60',2,2,'401000',1,'Collectif fournisseur','2018-05-02 00:00:00','A001','Achat A001',0.00,40.00,1,0,0,0,NULL,0,0),
('50',3,3,'512000',0,'Banque','2018-06-01 00:00:00','CHQ1','Reglement F001',120.00,0.00,1,0,1,0,NULL,0,0),
('50',3,3,'411001',0,'A Divers','2018-06-01 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,0,0),
('50',3,3,'411000',1,'Collectif client','2018-06-01 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,0,0),
('70',4,4,'411001',0,'A Divers','2018-07-01 00:00:00','F002','Non validee',999.00,0.00,0,0,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2017-06-01 00:00:00','F000','Facture F000',80.00,0.00,1,0,0,0,NULL,0,1),
('70',1,1,'707000',0,'Ventes','2017-06-01 00:00:00','F000','Facture F000',0.00,80.00,1,0,0,0,NULL,0,1);
-- Déséquilibre : une ligne 512000 non soldée de 10,05 au débit.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('50',5,5,'512000',0,'Banque','2018-08-01 00:00:00','X','Non soldee',10.05,0.00,1,0,1,0,NULL,0,0);
