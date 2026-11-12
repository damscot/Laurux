-- Jeu EdNlettrees (agent 3, vague 3) : comptes lettrables (411001-411003, 401001-401002, 512000),
-- 411003 centralisateur (cent_cc = 1), écritures non lettrées et lettrées sur l'exercice 2018 (Fiches_Mvt)
-- et 2017 (Fiches_Mvt1), une écriture du journal d'à-nouveaux (jour 90) au 01.01.2018.
UPDATE Fiches_Comptes SET lettrable = 1 WHERE compte_cc IN (411001,411002,411003,401001,401002,512000);
UPDATE Fiches_Comptes SET cent_cc = 1 WHERE compte_cc = 411003;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('90',1,1,'411001',0,'A Divers','2018-01-01 00:00:00','AN','A nouveau 411001',15.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',60.00,0.00,1,0,0,0,NULL,0,0),
('70',3,3,'411001',0,'A Divers','2018-02-20 00:00:00','F002','Facture F002',40.00,0.00,1,0,0,0,NULL,1,0),
('50',4,4,'411002',0,'B Divers','2018-03-05 00:00:00','CHQ4','Reglement',0.00,25.00,1,0,1,0,NULL,0,0),
('70',5,5,'411003',0,'C Divers','2018-03-10 00:00:00','F005','Facture F005',80.00,0.00,1,0,0,0,NULL,0,0),
('60',6,6,'401001',0,'A Divers','2018-03-01 00:00:00','A006','Achat A006',0.00,240.00,1,0,0,0,NULL,0,0),
('60',7,7,'401002',0,'B Divers','2018-03-02 00:00:00','A007','Achat A007',0.00,100.00,1,0,0,0,NULL,1,0),
('50',4,4,'512000',0,'Banque','2018-03-05 00:00:00','CHQ4','Reglement',25.00,0.00,1,0,1,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',11,11,'411001',0,'A Divers','2017-06-10 00:00:00','F011','Facture F011',15.00,0.00,1,0,0,0,NULL,0,0),
('70',12,12,'411002',0,'B Divers','2017-09-15 00:00:00','F012','Facture F012',45.00,0.00,1,0,0,0,NULL,0,0);
