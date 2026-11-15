-- Jeu EcrM T10 (agent 3, vague 7) : dtepc au 31.03.2018 ; écritures modifiées (Fiches_MvtM) de février et de mai 2018
-- dont le numéro provisoire (numero 11, 12) diffère du numéro définitif (numerodef 1, 2).
UPDATE Fiches_Parametres SET dtepc = '2018-03-31';
INSERT INTO Fiches_MvtM (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,lind2,datem,supprimee) VALUES
('70',11,1,'411001',1,'A Divers','2018-02-10 00:00:00','F001','Fac F001',120.00,0.00,1,0,0,0,NULL,0,0,1,'2018-02-12 09:00:00',NULL),
('70',11,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Fac F001',0.00,120.00,1,0,0,0,NULL,0,0,2,'2018-02-12 09:00:00',NULL),
('70',12,2,'411002',1,'B Divers','2018-05-12 00:00:00','F002','Fac F002',60.00,0.00,1,0,0,0,NULL,0,0,1,'2018-05-13 09:00:00',1),
('70',12,2,'707000',0,'Ventes','2018-05-12 00:00:00','F002','Fac F002',0.00,60.00,1,0,0,0,NULL,0,0,2,'2018-05-13 09:00:00',1);
