-- Jeu JournauxM T07 (agent 5, vague 3) : journal 70, une pièce dont une ligne porte le compte 999999 absent du plan comptable.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0),
('70',1,1,'999999',0,'Inconnu','2018-02-10 00:00:00','F001','Facture F001',0.00,120.00,1,0,0,0,NULL,0,0);
