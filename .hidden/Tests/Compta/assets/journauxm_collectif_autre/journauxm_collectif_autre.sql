-- Jeu JournauxM T11 (agent 5, vague 3) : journal 70, pièce 1 collectif 411000, pièce 2 collectif 421000 (même journal).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411000',1,'Collectif client','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('70',2,2,'421000',1,'Remuneration employes','2018-03-12 00:00:00','F002','Facture F002',0.00,60.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-03-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0);
