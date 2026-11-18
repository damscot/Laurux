-- ClotureF : période à clôturer mai 2018 (dtepp 04.2018, dtepec 05.2018), aucune facture imprimée à archiver
-- (Fiches_Bl/Fiches_BlM vides) ; soldes initiaux faux sur 4 comptes ; écritures validées et non validées.
-- Attendu après clôture : 411001 = 100+50-30 = 120 ; 401001 = 20-200 = -180 ; 512000 = 300-75.50 = 224.50 ;
-- 706100 (seulement non validées) = 0 ; tous les autres comptes à 0.
UPDATE Fiches_Parametres SET dtepp = '04.2018', dtepec = '05.2018';
UPDATE Fiches_Comptes SET solde = 999.99 WHERE compte_cc = 411001;
UPDATE Fiches_Comptes SET solde = -55.00 WHERE compte_cc = 401001;
UPDATE Fiches_Comptes SET solde = 12.34 WHERE compte_cc = 512000;
UPDATE Fiches_Comptes SET solde = 77.00 WHERE compte_cc = 706100;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-05-03 00:00:00','F001','Vente 1',100.00,0.00,1,0,0,0,0,0),
('70',2,2,'411001',NULL,'A Divers','2018-05-10 00:00:00','F002','Vente 2',50.00,0.00,1,0,0,0,0,0),
('53',3,3,'411001',NULL,'A Divers','2018-05-20 00:00:00','R001','Reglement 1',0.00,30.00,1,0,0,0,0,0),
('70',4,4,'411001',NULL,'A Divers','2018-05-25 00:00:00','F003','Vente non validee',500.00,0.00,0,0,0,0,0,0),
('60',5,5,'401001',NULL,'A Divers','2018-05-04 00:00:00','A001','Achat 1',0.00,200.00,1,0,0,0,0,0),
('53',6,6,'401001',NULL,'A Divers','2018-05-15 00:00:00','P001','Paiement 1',20.00,0.00,1,0,0,0,0,0),
('60',7,7,'401001',NULL,'A Divers','2018-05-28 00:00:00','A002','Achat non valide',0.00,40.00,0,0,0,0,0,0),
('53',8,8,'512000',NULL,'Banque','2018-05-05 00:00:00','B001','Remise',300.00,0.00,1,0,1,0,0,0),
('53',9,9,'512000',NULL,'Banque','2018-05-12 00:00:00','B002','Frais',0.00,75.50,1,0,1,0,0,0),
('53',10,10,'512000',NULL,'Banque','2018-05-30 00:00:00','B003','Non valide',0.00,1000.00,0,0,1,0,0,0),
('70',11,11,'706100',NULL,'Ventes MO','2018-05-03 00:00:00','F004','Non valide',0.00,60.00,0,0,0,0,0,0);
