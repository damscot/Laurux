-- Jeu ExportA47 T07 (agent 4, vague 3) : exporta47_base + écriture 2017 sur un compte absent du plan comptable (999999).
-- Jeu de données Extrait (agent 5, phase 2) : écritures de l'exercice 2018 (Fiches_Mvt) et 2017 (Fiches_Mvt1).
-- n°1 facture 411001 lettrée, n°2 règlement banque pointé (lettré), n°3 facture 411001 non lettrée,
-- n°4 facture 411002 clôturée, n°5 achat 606100/401001 ; 707000 centralisé (cent_cc = 1).
UPDATE Fiches_Comptes SET cent_cc = 1 WHERE compte_cc = '707000';
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,1,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('50',2,2,'411001',0,'A Divers','2018-03-05 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,1,0),
('50',2,2,'512000',0,'Banque','2018-03-05 00:00:00','CHQ1','Reglement F001',120.00,0.00,1,0,1,1,1,0,0),
('70',3,3,'411001',0,'A Divers','2018-04-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',3,3,'707000',0,'Ventes','2018-04-12 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',3,3,'445730',0,'Tva','2018-04-12 00:00:00','F002','Facture F002',0.00,10.00,1,0,0,0,NULL,0,0),
('70',4,4,'411002',0,'B Divers','2018-04-20 00:00:00','F003','Facture F003',30.00,0.00,1,0,0,0,NULL,0,1),
('70',4,4,'707000',0,'Ventes','2018-04-20 00:00:00','F003','Facture F003',0.00,25.00,1,0,0,0,NULL,0,1),
('70',4,4,'445730',0,'Tva','2018-04-20 00:00:00','F003','Facture F003',0.00,5.00,1,0,0,0,NULL,0,1),
('60',5,5,'606100',0,'Fournitures','2018-05-02 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0),
('60',5,5,'401001',0,'A Divers','2018-05-02 00:00:00','A001','Achat A001',0.00,40.00,1,0,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2017-06-01 00:00:00','F000','Facture F000',80.00,0.00,1,0,0,0,NULL,0,1),
('70',1,1,'707000',0,'Ventes','2017-06-01 00:00:00','F000','Facture F000',0.00,80.00,1,0,0,0,NULL,0,1);
UPDATE Fiches_Societes SET siret_sc = '123 456 789 00012' WHERE cd_sc = '01';
UPDATE Fiches_Mvt1 SET numerodef = numerodef + 100;
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',5,105,'999999',0,'Inconnu','2017-10-01 00:00:00','F012','Facture F012',10.00,0.00,1,0,0,0,NULL,0,1),
('70',5,105,'707000',0,'Ventes','2017-10-01 00:00:00','F012','Facture F012',0.00,10.00,1,0,0,0,NULL,0,1);
