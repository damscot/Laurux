-- Jeu Lettragemontant (agent 6, vague 3), Fiches_Mvt exercice 2018, écritures validées :
-- 411001 : 201 D 120 / 202 C 120 (lot NULL) -> groupe équilibré ;
-- 411002 : 203 C 80 lot A1 (1re ligne crédit : montant de référence 0, A01) / 204 D 80 lot B1 ;
-- 411003 : trois groupes 10 / 25 / 7 (lots A..F) -> limite de deux groupes par compte (A04) ;
-- 401001 : 211 C 40 lot A / 212 D 40 lot B (fournisseurs) ; 213 C 15 non validée (validee = 0).
INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
(201,'70',21,21,'411001',0,'A Divers','2018-02-10 00:00:00','F201',NULL,'Facture F201',120.00,0.00,1,0,0,0,NULL,0,0),
(202,'50',22,22,'411001',0,'A Divers','2018-03-05 00:00:00','R201',NULL,'Reglement F201',0.00,120.00,1,0,1,0,NULL,0,0),
(203,'50',23,23,'411002',0,'B Divers','2018-03-06 00:00:00','R202','A1','Reglement F202',0.00,80.00,1,0,1,0,NULL,0,0),
(204,'70',24,24,'411002',0,'B Divers','2018-03-07 00:00:00','F202','B1','Facture F202',80.00,0.00,1,0,0,0,NULL,0,0),
(205,'70',25,25,'411003',0,'C Divers','2018-04-01 00:00:00','F203','A','Facture F203',10.00,0.00,1,0,0,0,NULL,0,0),
(206,'50',26,26,'411003',0,'C Divers','2018-04-02 00:00:00','R203','B','Reglement F203',0.00,10.00,1,0,1,0,NULL,0,0),
(207,'70',27,27,'411003',0,'C Divers','2018-04-03 00:00:00','F204','C','Facture F204',25.00,0.00,1,0,0,0,NULL,0,0),
(208,'50',28,28,'411003',0,'C Divers','2018-04-04 00:00:00','R204','D','Reglement F204',0.00,25.00,1,0,1,0,NULL,0,0),
(209,'70',29,29,'411003',0,'C Divers','2018-04-05 00:00:00','F205','E','Facture F205',7.00,0.00,1,0,0,0,NULL,0,0),
(210,'50',30,30,'411003',0,'C Divers','2018-04-06 00:00:00','R205','F','Reglement F205',0.00,7.00,1,0,1,0,NULL,0,0),
(211,'60',31,31,'401001',0,'A Divers','2018-05-01 00:00:00','A201','A','Achat A201',0.00,40.00,1,0,0,0,NULL,0,0),
(212,'50',32,32,'401001',0,'A Divers','2018-05-02 00:00:00','P201','B','Paiement A201',40.00,0.00,1,0,1,0,NULL,0,0),
(213,'60',33,33,'401001',0,'A Divers','2018-05-03 00:00:00','A202','C','Achat A202',0.00,15.00,0,0,0,0,NULL,0,0);
