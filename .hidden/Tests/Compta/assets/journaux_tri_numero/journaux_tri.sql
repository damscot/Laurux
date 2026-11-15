-- Jeu Journaux T05 (agent 3, vague 7) : journal 70, numéro 1 daté de mai 2018 et numéro 2 daté de février 2018
-- (ordre par date différent de l'ordre par numéro).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-05-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'707000',0,'Ventes','2018-05-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0),
('70',2,2,'411002',0,'B Divers','2018-02-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-02-12 00:00:00','F002','Facture F002',0.00,60.00,1,0,0,0,NULL,0,0);
