-- Jeu soldes_nuls (BALANCEM-T10) : copie de Compta/extrait_shared/extrait_base complétée ; écritures d origine :
-- n°1 facture 411001 lettrée, n°2 règlement banque pointé (lettré), n°3 facture 411001 non lettrée,
-- n°4 facture 411002 clôturée, n°5 achat 606100/401001 ; 707000 centralisé (cent_cc = 1).
UPDATE Fiches_Comptes SET cent_cc = 1 WHERE compte_cc = '707000';
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,1,0),
('70',1,1,'707000',0,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',1,1,'445730',0,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0),
('50',2,2,'411001',0,'A Divers','2018-03-05 00:00:00','CHQ1','Reglement F001',0.00,120.00,1,0,1,0,NULL,1,0),
('50',2,2,'512000',0,'Banque','2018-03-05 00:00:00','CHQ1','Reglement F001',120.00,0.00,1,0,1,1,1,0,0),
('70',3,3,'411001',0,'A Divers','2018-04-12 00:00:00','F002','Facture F002',60.00,0.00,1,0,0,0,NULL,0,0),
('70',3,3,'707000',0,'Ventes','2018-04-12 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',3,3,'445730',0,'Tva','2018-04-12 00:00:00','F002','Facture F002',0.00,10.00,1,0,0,0,NULL,0,0),
('70',4,4,'411002',0,'B Divers','2018-04-20 00:00:00','F003','Facture F003',30.00,0.00,1,0,0,0,NULL,0,1),
('70',4,4,'707000',0,'Ventes','2018-04-20 00:00:00','F003','Facture F003',0.00,25.00,1,0,0,0,NULL,0,1),
('70',4,4,'445730',0,'Tva','2018-04-20 00:00:00','F003','Facture F003',0.00,5.00,1,0,0,0,NULL,0,1),
('60',5,5,'606100',0,'Fournitures','2018-05-02 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0),
('60',5,5,'401001',0,'A Divers','2018-05-02 00:00:00','A001','Achat A001',0.00,40.00,1,0,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'411001',0,'A Divers','2017-06-01 00:00:00','F000','Facture F000',80.00,0.00,1,0,0,0,NULL,0,1),
('70',1,1,'707000',0,'Ventes','2017-06-01 00:00:00','F000','Facture F000',0.00,80.00,1,0,0,0,NULL,0,1);
-- Ajout BALANCEM-T10 : 411003 équilibré en base, cumul Float non nul (0,10 + 0,20 au débit, 0,30 au crédit : résidu +5,5e-17) ;
-- 411004 résidu négatif (0,30 au débit, 0,10 + 0,20 au crédit) ; 411005 soldé par des montants ronds (50,00 / 50,00).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',6,6,'411003',0,'C Divers','2018-05-03 00:00:00','F004','Facture F004',0.10,0.00,1,0,0,0,NULL,0,0),
('70',6,6,'707000',0,'Ventes','2018-05-03 00:00:00','F004','Facture F004',0.00,0.10,1,0,0,0,NULL,0,0),
('70',7,7,'411003',0,'C Divers','2018-05-04 00:00:00','F005','Facture F005',0.20,0.00,1,0,0,0,NULL,0,0),
('70',7,7,'707000',0,'Ventes','2018-05-04 00:00:00','F005','Facture F005',0.00,0.20,1,0,0,0,NULL,0,0),
('50',8,8,'411003',0,'C Divers','2018-05-10 00:00:00','CHQ2','Reglement F004 F005',0.00,0.30,1,0,1,0,NULL,0,0),
('50',8,8,'512000',0,'Banque','2018-05-10 00:00:00','CHQ2','Reglement F004 F005',0.30,0.00,1,0,1,0,NULL,0,0),
('70',9,9,'411004',0,'D Divers','2018-05-03 00:00:00','F006','Facture F006',0.30,0.00,1,0,0,0,NULL,0,0),
('70',9,9,'707000',0,'Ventes','2018-05-03 00:00:00','F006','Facture F006',0.00,0.30,1,0,0,0,NULL,0,0),
('50',10,10,'411004',0,'D Divers','2018-05-11 00:00:00','CHQ3','Acompte F006',0.00,0.10,1,0,1,0,NULL,0,0),
('50',10,10,'512000',0,'Banque','2018-05-11 00:00:00','CHQ3','Acompte F006',0.10,0.00,1,0,1,0,NULL,0,0),
('50',11,11,'411004',0,'D Divers','2018-05-12 00:00:00','CHQ4','Solde F006',0.00,0.20,1,0,1,0,NULL,0,0),
('50',11,11,'512000',0,'Banque','2018-05-12 00:00:00','CHQ4','Solde F006',0.20,0.00,1,0,1,0,NULL,0,0),
('70',12,12,'411005',0,'E Divers','2018-05-05 00:00:00','F007','Facture F007',50.00,0.00,1,0,0,0,NULL,0,0),
('70',12,12,'707000',0,'Ventes','2018-05-05 00:00:00','F007','Facture F007',0.00,50.00,1,0,0,0,NULL,0,0),
('50',13,13,'411005',0,'E Divers','2018-05-15 00:00:00','CHQ5','Reglement F007',0.00,50.00,1,0,1,0,NULL,0,0),
('50',13,13,'512000',0,'Banque','2018-05-15 00:00:00','CHQ5','Reglement F007',50.00,0.00,1,0,1,0,NULL,0,0);
