-- Jeu JournauxM T09 (agent 5, vague 3) : journal 70, pièce 1 datée 2018-02-10 00:00, pièce 2 datée du dernier jour
-- de la période (2018-06-15) à 10:00:00.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',0,'B Divers','2018-06-15 10:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'706100',0,'Ventes MO','2018-06-15 10:00:00','F002','Facture F002',0.00,60.00,1,0,0,0,NULL,0,0);
