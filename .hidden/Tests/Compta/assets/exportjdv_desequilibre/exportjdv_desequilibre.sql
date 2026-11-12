-- Jeu ExportJdv T10 (agent 8, vague 3) : journal 70, écriture n°1 déséquilibrée (débit 120, crédits 100 + 10).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411000',1,'Clients','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',NULL,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,10.00,1,0,0,0,NULL,0,0);
