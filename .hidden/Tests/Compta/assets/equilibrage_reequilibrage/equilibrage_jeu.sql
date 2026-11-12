-- Jeu de données Equilibrage (agent 8, phase 2, vague 3) : écritures du journal 70 (collectif NULL), exercice 2018.
-- n°1 équilibrée ; n°2 déséquilibrée au crédit (707000 à 90 au lieu de 100) ; n°3 sans crédit (411002 seul) ;
-- n°4 deux lignes 707000 (30 + 20 pour 60 au débit) ; n°5 déséquilibrée en dernière position (707000 à 70 pour 80).
-- n°6 journal 60 déséquilibrée (hors traitement).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee,control) VALUES
('70',1,1,'411001',NULL,'A Divers','2018-02-10 00:00:00','F001','Facture F001',120.00,0.00,1,0,0,0,NULL,0,0,'C1'),
('70',1,1,'445730',NULL,'Tva','2018-02-10 00:00:00','F001','Facture F001',0.00,20.00,1,0,0,0,NULL,0,0,'C2'),
('70',1,1,'707000',NULL,'Ventes','2018-02-10 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0,'C3'),
('70',2,2,'411001',NULL,'A Divers','2018-02-11 00:00:00','F002','Facture F002',120.00,0.00,1,0,0,0,NULL,0,0,'C4'),
('70',2,2,'445730',NULL,'Tva','2018-02-11 00:00:00','F002','Facture F002',0.00,20.00,1,0,0,0,NULL,0,0,'C5'),
('70',2,2,'707000',NULL,'Ventes','2018-02-11 00:00:00','F002','Facture F002',0.00,90.00,1,0,0,0,NULL,0,0,'C6'),
('70',3,3,'411002',NULL,'B Divers','2018-02-12 00:00:00','F003','Facture F003',50.00,0.00,1,0,0,0,NULL,0,0,'C7'),
('70',4,4,'411003',NULL,'C Divers','2018-02-13 00:00:00','F004','Facture F004',60.00,0.00,1,0,0,0,NULL,0,0,'C8'),
('70',4,4,'707000',NULL,'Ventes','2018-02-13 00:00:00','F004','Facture F004',0.00,30.00,1,0,0,0,NULL,0,0,'C9'),
('70',4,4,'707000',NULL,'Ventes','2018-02-13 00:00:00','F004','Facture F004',0.00,20.00,1,0,0,0,NULL,0,0,'C10'),
('60',6,6,'606100',NULL,'Fournitures','2018-02-14 00:00:00','A001','Achat A001',40.00,0.00,1,0,0,0,NULL,0,0,'C11'),
('60',6,6,'401001',NULL,'A Divers','2018-02-14 00:00:00','A001','Achat A001',0.00,30.00,1,0,0,0,NULL,0,0,'C12'),
('70',5,5,'411004',NULL,'D Divers','2018-02-15 00:00:00','F005','Facture F005',80.00,0.00,1,0,0,0,NULL,0,0,'C13'),
('70',5,5,'707000',NULL,'Ventes','2018-02-15 00:00:00','F005','Facture F005',0.00,70.00,1,0,0,0,NULL,0,0,'C14');
