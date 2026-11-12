-- Jeu de données ExportJdv (agent 8, phase 2, vague 3) : journal 70, exercice 2018, écritures validées non exportées.
-- n°1 facture 411001 (ligne collectif 411000), n°2 facture 411002 (ligne collectif 411000).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411000',1,'Clients','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',NULL,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('70',2,2,'411000',1,'Clients','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',NULL,'B Divers','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',NULL,'Ventes','2018-03-12 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',2,2,'445730',NULL,'Tva','2018-03-12 00:00:00','F002','Facture F002',0.00,10.00,1,0,0,0,NULL,0,0);
