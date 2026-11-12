-- Jeu de données Pointage (agent 5, phase 2) : compte 512000 avec 2 relevés (Fiches_Rappro), report à nouveau
-- au journal 90, écritures 2018 pointées (relevé 2) et non pointées (Fiches_Mvt), 2 écritures 2017 non pointées
-- (Fiches_Mvt1). Lignes de contrepartie omises (seul le compte de banque est lu).
UPDATE Fiches_Comptes SET solde = 1345, soldep = 1100 WHERE compte_cc = '512000';
INSERT INTO Fiches_Rappro (cpt,nreleve,date_releve,date_rappro,solde) VALUES
('512000',1,'2018-01-31 00:00:00','2018-02-05 00:00:00',1000),
('512000',2,'2018-02-28 00:00:00','2018-03-05 00:00:00',1100);
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('90',9,9,'512000',0,'Banque','2018-01-01 00:00:00','RAN','Report a nouveau',1000.00,0.00,1,0,1,0,NULL,0,1),
('50',10,10,'512000',0,'Banque','2018-02-10 00:00:00','R10','Remise 10',150.00,0.00,1,0,1,1,2,0,0),
('50',11,11,'512000',0,'Banque','2018-02-20 00:00:00','P11','Prelevement 11',0.00,50.00,1,0,1,1,2,0,0),
('50',12,12,'512000',0,'Banque','2018-03-05 00:00:00','R12','Remise 12',300.00,0.00,1,0,1,0,NULL,0,0),
('50',13,13,'512000',0,'Banque','2018-03-15 00:00:00','P13','Prelevement 13',0.00,80.00,1,0,1,0,NULL,0,0),
('50',14,14,'512000',0,'Banque','2018-04-02 00:00:00','R14','Remise 14',45.00,0.00,1,0,1,0,NULL,0,0),
('50',15,15,'512000',0,'Banque','2018-05-10 00:00:00','P15','Prelevement 15',0.00,20.00,1,0,1,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('50',20,20,'512000',0,'Banque','2017-11-10 00:00:00','R20','Remise 20',500.00,0.00,1,0,1,0,NULL,0,0),
('50',21,21,'512000',0,'Banque','2017-12-20 00:00:00','P21','Prelevement 21',0.00,100.00,1,0,1,0,NULL,0,0);
