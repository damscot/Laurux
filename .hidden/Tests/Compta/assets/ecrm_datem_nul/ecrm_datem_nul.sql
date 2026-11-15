-- Jeu EcrM T09 (agent 3, vague 7) : écritures modifiées (Fiches_MvtM) avec datem NULL sur une ligne 411 (collectif)
-- et une ligne 512 (trésorerie), datem renseigné sur les autres lignes.
INSERT INTO Fiches_MvtM (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,lind2,datem,supprimee) VALUES
('70',1,1,'411001',1,'A Divers','2018-02-10 00:00:00','F001','Fac F001',120.00,0.00,1,0,0,0,NULL,0,0,1,NULL,NULL),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Fac F001',0.00,120.00,1,0,0,0,NULL,0,0,2,'2018-02-12 09:00:00',NULL),
('50',2,2,'411001',1,'A Divers','2018-03-05 00:00:00','CHQ2','Reglement F001',0.00,120.00,1,0,1,0,NULL,0,0,1,'2018-03-06 08:00:00',NULL),
('50',2,2,'512000',0,'Banque','2018-03-05 00:00:00','CHQ2','Reglement F001',120.00,0.00,1,0,1,0,NULL,0,0,2,NULL,NULL);
