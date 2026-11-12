-- Jeu de données Lettrage (agent 6, vague 3) : écritures du compte client 411001 (exercice 2018, Fiches_Mvt).
-- lind 101 (n°11) facture F101 100,00 D et lind 102 (n°12) règlement R101 100,00 C : non lettrées, équilibrées ;
-- lind 103 (n°13) facture F102 50,00 D non lettrée ; lind 104/105 (n°14/15) F103/R103 30,00 lettrées lot L0001 ;
-- lind 106 (n°16) facture F104 20,00 D sur 411002 (navigation). Clé Colcli = lind & numero (ex. 10111).
INSERT INTO Fiches_Mvt (lind,jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
(101,'70',11,11,'411001',0,'A Divers','2018-02-10 00:00:00','F101',NULL,'Facture F101',100.00,0.00,1,0,0,0,NULL,0,0),
(102,'50',12,12,'411001',0,'A Divers','2018-03-05 00:00:00','R101',NULL,'Reglement F101',0.00,100.00,1,0,1,0,NULL,0,0),
(103,'70',13,13,'411001',0,'A Divers','2018-04-12 00:00:00','F102',NULL,'Facture F102',50.00,0.00,1,0,0,0,NULL,0,0),
(104,'70',14,14,'411001',0,'A Divers','2018-04-20 00:00:00','F103','L0001','Facture F103',30.00,0.00,1,0,0,0,NULL,1,0),
(105,'50',15,15,'411001',0,'A Divers','2018-05-02 00:00:00','R103','L0001','Reglement F103',0.00,30.00,1,0,1,0,NULL,1,0),
(106,'70',16,16,'411002',0,'B Divers','2018-05-10 00:00:00','F104',NULL,'Facture F104',20.00,0.00,1,0,0,0,NULL,0,0);
