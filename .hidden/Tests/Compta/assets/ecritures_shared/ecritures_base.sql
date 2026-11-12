-- Jeu de données Ecritures (agent 8, phase 2, vague 3) : écritures validées de l'exercice 2018 (Fiches_Mvt),
-- collectif NULL (requête de l'écran 3 : « collectif is null »).
-- n°1 facture 411001 (clé control altérée sur la ligne 411001), n°2 règlement de trésorerie 411001/512000,
-- n°3 facture 411002 clôturée.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,control) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,1,0,'ALTERE'),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0,NULL),
('70',1,1,'445730',NULL,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0,NULL),
('50',2,2,'411001',NULL,'A Divers','2018-03-05 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,1,0,NULL),
('50',2,2,'512000',NULL,'Banque','2018-03-05 00:00:00','CHQ1','Reglement F001',120.00,0.00,1,0,1,0,NULL,0,0,NULL),
('70',3,3,'411002',NULL,'B Divers','2018-04-20 00:00:00','F003','Facture F003',30.00,0.00,1,0,0,0,NULL,0,1,NULL),
('70',3,3,'707000',NULL,'Ventes','2018-04-20 00:00:00','F003','Facture F003',0.00,25.00,1,0,0,0,NULL,0,1,NULL),
('70',3,3,'445730',NULL,'Tva','2018-04-20 00:00:00','F003','Facture F003',0.00,5.00,1,0,0,0,NULL,0,1,NULL);
