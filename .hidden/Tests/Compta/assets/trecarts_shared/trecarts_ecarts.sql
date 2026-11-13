-- Jeu Trecarts : lots non lettrés avec écarts (seuil 0,05, comptes de régularisation 758000/658000, journal OD 10).
UPDATE Fiches_Parametres SET ecart = 0.05, numecriture = 100;
UPDATE Fiches_Comptes SET solde = 0.03 WHERE compte_cc = 411001;
UPDATE Fiches_Comptes SET solde = -0.04 WHERE compte_cc = 411002;
UPDATE Fiches_Comptes SET solde = 0.50 WHERE compte_cc = 411003;
UPDATE Fiches_Comptes SET solde = 0.02 WHERE compte_cc = 411004;
UPDATE Fiches_Comptes SET solde = 0.51 WHERE compte_cc = 411000;
UPDATE Fiches_Comptes SET solde = -0.02 WHERE compte_cc = 401001;
UPDATE Fiches_Comptes SET solde = 0.01 WHERE compte_cc = 401002;
UPDATE Fiches_Comptes SET solde = -0.01 WHERE compte_cc = 401000;
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, lettree, cloturee) VALUES
-- 411001 : écart +0,03 (débit > crédit)
('01',1,'411001',0,'A Divers','2018-03-01','F1','L000000001','Facture F1',100.00,0.00,1,0,0,0,0,0),
('03',2,'411001',0,'A Divers','2018-03-20','R1','L000000001','Reglement F1',0.00,99.97,1,0,0,0,0,0),
-- 411002 : écart -0,04 (crédit > débit)
('01',3,'411002',0,'B Divers','2018-03-02','F2','L000000002','Facture F2',50.00,0.00,1,0,0,0,0,0),
('03',4,'411002',0,'B Divers','2018-03-21','R2','L000000002','Reglement F2',0.00,50.04,1,0,0,0,0,0),
-- 411003 : écart 0,50 au-delà du seuil (inchangé)
('01',5,'411003',0,'C Divers','2018-03-03','F3','L000000003','Facture F3',20.00,0.00,1,0,0,0,0,0),
('03',6,'411003',0,'C Divers','2018-03-22','R3','L000000003','Reglement F3',0.00,19.50,1,0,0,0,0,0),
-- 411004 : lot de 4 lignes, écart +0,02 (TRECARTS-T07)
('01',7,'411004',0,'D Divers','2018-03-04','F4','L000000004','Facture F4',30.00,0.00,1,0,0,0,0,0),
('03',8,'411004',0,'D Divers','2018-03-23','R4','L000000004','Acompte 1',0.00,10.00,1,0,0,0,0,0),
('03',9,'411004',0,'D Divers','2018-03-24','R5','L000000004','Acompte 2',0.00,10.00,1,0,0,0,0,0),
('03',10,'411004',0,'D Divers','2018-03-25','R6','L000000004','Solde F4',0.00,9.98,1,0,0,0,0,0),
-- 401001 : écart fournisseur -0,02 (crédit > débit)
('02',13,'401001',0,'A Divers','2018-04-01','A1','L000000011','Achat A1',0.00,80.00,1,0,0,0,0,0),
('03',14,'401001',0,'A Divers','2018-04-20','P1','L000000011','Paiement A1',79.98,0.00,1,0,0,0,0,0),
-- 401002 : écart fournisseur +0,01 (débit > crédit)
('02',15,'401002',0,'B Divers','2018-04-02','A2','L000000012','Achat A2',0.00,40.00,1,0,0,0,0,0),
('03',16,'401002',0,'B Divers','2018-04-21','P2','L000000012','Paiement A2',40.01,0.00,1,0,0,0,0,0);
