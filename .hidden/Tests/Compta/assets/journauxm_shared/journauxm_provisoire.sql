-- Jeu JournauxM T04 (agent 3, vague 7) : dtepc au 31.03.2018 ; journal 70 (VE), pièces de février et de mai 2018
-- dont le numéro provisoire (numero 11, 12) diffère du numéro définitif (numerodef 1, 2).
UPDATE Fiches_Parametres SET dtepc = '2018-03-31';
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',11,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',11,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',11,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('70',12,2,'411002',0,'B Divers','2018-05-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',12,2,'707000',0,'Ventes','2018-05-12 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',12,2,'445730',0,'Tva','2018-05-12 00:00:00','F002','Facture F002',0.00,10.00,1,0,0,0,NULL,0,0);
