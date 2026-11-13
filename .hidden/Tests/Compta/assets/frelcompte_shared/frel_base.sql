-- Jeu de données Relevés (agent 3, vague 4) : partagé par FRelCompte et FRelFacture.
-- Période de test : juin 2018 (date figée 2018-06-15). Écritures avec collectif NULL (filtre des relevés).
-- 411001 et 411002 : relevés de compte et de facture demandés ; 411003 : aucun relevé (exclu).
-- 411002 : 35 factures du 1er au 14 juin (saut de page du PDF) ; une facture lettrée (exclue de FRelFacture).
-- 411001 : facture, règlement en trésorerie (exclu de FRelFacture), facture hors période (mai).
-- 411001 : écriture n°9 avec deux lignes du même compte (doublon de clé de Fiches_RelFacture, ignoré par Try).
-- 401001 / 401002 : achats (journal 60, AC) et règlement (journal 50, trésorerie).
UPDATE Fiches_Cli SET cli_rlvc = 1, cli_rlvf = 1, cli_rs_soc = 'SARL', cli_adr1 = '1 rue des Lilas', cli_cd_ptl = '75001', cli_ville = 'Paris' WHERE cli_code = '411001';
UPDATE Fiches_Cli SET cli_rlvc = 1, cli_rlvf = 1, cli_rs_soc = 'SA', cli_adr1 = '2 place du Marche', cli_cd_ptl = '69002', cli_ville = 'Lyon', cli_pays = 'Belgique' WHERE cli_code = '411002';
UPDATE Fiches_Four SET fo_rs_soc = 'SAS', fo_adr1 = '3 quai Nord', fo_cd_ptl = '44000', fo_ville = 'Nantes' WHERE fo_code = '401001';
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-06-03 00:00:00','F101','Facture F101',120.00,0.00,1,0,0,0,0,0),
('70',1,1,'707000',NULL,'Ventes','2018-06-03 00:00:00','F101','Facture F101',0.00,100.00,1,0,0,0,0,0),
('70',1,1,'445710',NULL,'Tva','2018-06-03 00:00:00','F101','Facture F101',0.00,20.00,1,0,0,0,0,0),
('50',2,2,'411001',NULL,'A Divers','2018-06-08 00:00:00','CHQ1','Reglement F101',0.00,120.00,1,0,1,0,0,0),
('50',2,2,'512000',NULL,'Banque','2018-06-08 00:00:00','CHQ1','Reglement F101',120.00,0.00,1,0,1,0,0,0),
('70',3,3,'411003',NULL,'C Divers','2018-06-10 00:00:00','F103','Facture F103',60.00,0.00,1,0,0,0,0,0),
('70',3,3,'707000',NULL,'Ventes','2018-06-10 00:00:00','F103','Facture F103',0.00,60.00,1,0,0,0,0,0),
('70',4,4,'411001',NULL,'A Divers','2018-05-20 00:00:00','F099','Facture F099',50.00,0.00,1,0,0,0,0,0),
('70',4,4,'707000',NULL,'Ventes','2018-05-20 00:00:00','F099','Facture F099',0.00,50.00,1,0,0,0,0,0),
('70',5,5,'411002',NULL,'B Divers','2018-06-11 00:00:00','F104','Facture F104 lettree',30.00,0.00,1,0,0,0,1,0),
('70',5,5,'707000',NULL,'Ventes','2018-06-11 00:00:00','F104','Facture F104 lettree',0.00,30.00,1,0,0,0,0,0),
('60',6,6,'401001',NULL,'A Divers','2018-06-04 00:00:00','A101','Achat A101',0.00,360.00,1,0,0,0,0,0),
('60',6,6,'607000',NULL,'Achats','2018-06-04 00:00:00','A101','Achat A101',360.00,0.00,1,0,0,0,0,0),
('50',7,7,'401001',NULL,'A Divers','2018-06-12 00:00:00','VIR1','Reglement A101',360.00,0.00,1,0,1,0,0,0),
('50',7,7,'512000',NULL,'Banque','2018-06-12 00:00:00','VIR1','Reglement A101',0.00,360.00,1,0,1,0,0,0),
('60',8,8,'401002',NULL,'B Divers','2018-06-14 00:00:00','A102','Achat A102',0.00,90.00,1,0,0,0,0,0),
('60',8,8,'607000',NULL,'Achats','2018-06-14 00:00:00','A102','Achat A102',90.00,0.00,1,0,0,0,0,0),
('70',9,9,'411001',NULL,'A Divers','2018-06-13 00:00:00','F105','Facture F105 ligne 1',40.00,0.00,1,0,0,0,0,0),
('70',9,9,'411001',NULL,'A Divers','2018-06-13 00:00:00','F105','Facture F105 ligne 2',5.00,0.00,1,0,0,0,0,0),
('70',9,9,'707000',NULL,'Ventes','2018-06-13 00:00:00','F105','Facture F105',0.00,45.00,1,0,0,0,0,0);
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee)
WITH RECURSIVE s(n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM s WHERE n < 35)
SELECT '70', 100 + n, 100 + n, '411002', NULL, 'B Divers', DATE_ADD('2018-06-01', INTERVAL (n MOD 14) DAY), CONCAT('G', 200 + n), CONCAT('Facture G', 200 + n), 10.00 + n, 0.00, 1, 0, 0, 0, 0, 0 FROM s;
