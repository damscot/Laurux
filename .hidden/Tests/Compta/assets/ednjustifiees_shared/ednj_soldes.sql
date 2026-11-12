-- Jeu EdNjustifiees (agent 3, vague 3) : écritures non lettrées (Fiches_Mvt 2018) et soldes mémorisés.
-- 411001 justifié (solde = écritures non lettrées = 60), 411002 solde faux (50 au lieu de 30),
-- 411003 sans écriture non lettrée mais solde 25, 411004 solde 100.005 contre 100.00 d'écritures,
-- 401001 justifié (-240), 401002 solde faux (-10 au lieu de -90).
UPDATE Fiches_Comptes SET solde = 60 WHERE compte_cc = 411001;
UPDATE Fiches_Comptes SET solde = 50 WHERE compte_cc = 411002;
UPDATE Fiches_Comptes SET solde = 25 WHERE compte_cc = 411003;
UPDATE Fiches_Comptes SET solde = 100.005 WHERE compte_cc = 411004;
UPDATE Fiches_Comptes SET solde = -240 WHERE compte_cc = 401001;
UPDATE Fiches_Comptes SET solde = -10 WHERE compte_cc = 401002;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',0,'B Divers','2018-02-11 00:00:00','F002','Facture F002',30.00,0.00,1,0,0,0,NULL,0,0),
('70',3,3,'411003',0,'C Divers','2018-02-12 00:00:00','F003','Facture F003',25.00,0.00,1,0,0,0,NULL,1,0),
('70',4,4,'411004',0,'D Divers','2018-02-13 00:00:00','F004','Facture F004',100.00,0.00,1,0,0,0,NULL,0,0),
('60',5,5,'401001',0,'A Divers','2018-03-01 00:00:00','A005','Achat A005',0.00,240.00,1,0,0,0,NULL,0,0),
('60',6,6,'401002',0,'B Divers','2018-03-02 00:00:00','A006','Achat A006',0.00,100.00,1,0,0,0,NULL,0,0),
('50',7,7,'401002',0,'B Divers','2018-03-20 00:00:00','CHQ7','Reglement partiel',10.00,0.00,1,0,1,0,NULL,0,0);
