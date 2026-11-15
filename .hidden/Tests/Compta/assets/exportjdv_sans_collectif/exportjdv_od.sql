-- Jeu exportjdv_od (EXPORTJDV-T11, vague 7) : journal OD 10 sans ligne collectif (606100 / 512000), exercice 2018,
-- écriture validée non exportée ; journal proposé par défaut (Fiches_Parametres.jrnal) porté à 10.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('10',1,1,'606100',NULL,'Fournitures','2018-03-01 00:00:00','OD001','Charge OD001',50.00,0.00,1,0,0,0,NULL,0,0),
('10',1,1,'512000',NULL,'Banque','2018-03-01 00:00:00','OD001','Charge OD001',0.00,50.00,1,0,0,0,NULL,0,0);
UPDATE Fiches_Parametres SET jrnal = '10';
