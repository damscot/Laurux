-- Jeu FEditrel (agent 6, vague 3) : écritures clients non lettrées (Fiches_Mvt 2018, collectif NULL) pour les relances.
-- 411001 : 401 F401 100 D échue 2018-05-01 (relance NULL -> niveau 1) ; 402 F402 50 D non échue (dateech 2018-07-30) ;
-- 411002 : 403 F403 80 D échue, relance 2 (-> 3) ; 404 sans numdoc 20 D, relance 3 (-> 3) ;
-- 411999 : 405 F405 10 D échue, compte sans fiche Fiches_Cli (exclu).
INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,dateech,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,relance) VALUES
(401,'70',61,61,'411001',NULL,'A Divers','2018-04-01 00:00:00','2018-05-01 00:00:00','F401',NULL,'Facture F401',100.00,0.00,1,0,0,0,NULL,0,0,NULL),
(402,'70',62,62,'411001',NULL,'A Divers','2018-06-01 00:00:00','2018-07-30 00:00:00','F402',NULL,'Facture F402',50.00,0.00,1,0,0,0,NULL,0,0,NULL),
(403,'70',63,63,'411002',NULL,'B Divers','2018-03-01 00:00:00','2018-04-01 00:00:00','F403',NULL,'Facture F403',80.00,0.00,1,0,0,0,NULL,0,0,2),
(404,'70',64,64,'411002',NULL,'B Divers','2018-02-01 00:00:00','2018-03-01 00:00:00',NULL,NULL,'Facture sans numero',20.00,0.00,1,0,0,0,NULL,0,0,3),
(405,'70',65,65,'411999',NULL,'Inconnu','2018-01-10 00:00:00','2018-02-01 00:00:00','F405',NULL,'Facture F405',10.00,0.00,1,0,0,0,NULL,0,0,NULL);
