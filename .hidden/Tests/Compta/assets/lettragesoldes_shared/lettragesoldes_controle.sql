-- Jeu Lettragesoldes (agent 6, vague 3) : soldes fixés directement (sans Csolde).
-- 411001 soldé : 301 D 50 lot A / 302 C 50 lot B (lots différents -> lettrage partiel, A01) ;
-- 411002 soldé : 303 D 30 / 304 C 30 lot NULL (compte compté sans lettrage) ;
-- 411003 non soldé (solde 100) : 305 D 100 lot X intact ; 401001 soldé : 306 C 40 / 307 D 40 lot P.
UPDATE Fiches_Comptes SET solde = 0 WHERE compte_cc IN (411001, 411002, 401001);
UPDATE Fiches_Comptes SET solde = 100 WHERE compte_cc = 411003;
INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
(301,'70',51,51,'411001',0,'A Divers','2018-02-10 00:00:00','F301','A','Facture F301',50.00,0.00,1,0,0,0,NULL,0,0),
(302,'50',52,52,'411001',0,'A Divers','2018-03-05 00:00:00','R301','B','Reglement F301',0.00,50.00,1,0,1,0,NULL,0,0),
(303,'70',53,53,'411002',0,'B Divers','2018-03-06 00:00:00','F302',NULL,'Facture F302',30.00,0.00,1,0,0,0,NULL,0,0),
(304,'50',54,54,'411002',0,'B Divers','2018-03-07 00:00:00','R302',NULL,'Reglement F302',0.00,30.00,1,0,1,0,NULL,0,0),
(305,'70',55,55,'411003',0,'C Divers','2018-04-01 00:00:00','F303','X','Facture F303',100.00,0.00,1,0,0,0,NULL,0,0),
(306,'60',56,56,'401001',0,'A Divers','2018-05-01 00:00:00','A301','P','Achat A301',0.00,40.00,1,0,0,0,NULL,0,0),
(307,'50',57,57,'401001',0,'A Divers','2018-05-02 00:00:00','P301','P','Paiement A301',40.00,0.00,1,0,1,0,NULL,0,0);
