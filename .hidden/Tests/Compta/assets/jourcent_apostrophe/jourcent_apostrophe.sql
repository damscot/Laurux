-- Jeu Jourcent T08 (agent 5, vague 3) : collectif 411000 intitulé « Clients d'Anjou », deux lignes au journal 70.
UPDATE Fiches_Comptes SET intitule_cc = 'Clients d''Anjou' WHERE compte_cc = 411000;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411000',1,'Collectif client','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('70',2,2,'411000',1,'Collectif client','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-03-12 00:00:00','F002','Facture F002',0.00,60.00,1,0,0,0,NULL,0,0);
