-- Jeu de données Tresor (agent 5, phase 2) : factures ouvertes lettrables (401001 ×2, 411001, 411002 dans
-- Fiches_Mvt1 = exercice précédent), règlement CHQ9 au journal 50 sur 411002 (doublon de n° de document),
-- compteur numecriture à 10 (pas de collision de numéros).
UPDATE Fiches_Parametres SET numecriture = 10;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('60',1,1,'401001',NULL,'A Divers','2018-03-01 00:00:00','FA1','FA1','Facture FA1',0.00,50.00,1,0,0,0,0,0),
('60',1,1,'606100',NULL,'Fournitures','2018-03-01 00:00:00','FA1','FA1','Facture FA1',50.00,0.00,1,0,0,0,0,0),
('60',2,2,'401001',NULL,'A Divers','2018-04-01 00:00:00','FA2','FA2','Facture FA2',0.00,30.00,1,0,0,0,0,0),
('60',2,2,'606100',NULL,'Fournitures','2018-04-01 00:00:00','FA2','FA2','Facture FA2',30.00,0.00,1,0,0,0,0,0),
('70',3,3,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','F001','Facture F001',120.00,0.00,1,0,0,0,0,0),
('70',3,3,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','F001','Facture F001',0.00,120.00,1,0,0,0,0,0),
('50',4,4,'411002',NULL,'B Divers','2018-05-02 00:00:00','CHQ9','CHQ9','Reglement CHQ9',0.00,10.00,1,0,1,0,0,0),
('50',4,4,'512000',NULL,'Banque','2018-05-02 00:00:00','CHQ9','CHQ9','Reglement CHQ9',10.00,0.00,1,0,1,0,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,numlot,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('70',1,1,'411003',NULL,'C Divers','2017-11-15 00:00:00','F000','F000','Facture F000',75.00,0.00,1,0,0,0,0,0),
('70',1,1,'707000',NULL,'Ventes','2017-11-15 00:00:00','F000','F000','Facture F000',0.00,75.00,1,0,0,0,0,0);
