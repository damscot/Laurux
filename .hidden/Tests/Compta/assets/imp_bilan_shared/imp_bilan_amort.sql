-- Jeu Imp_Bilan (agent 2, phase 2 vague 4) : immobilisations, amortissements (plages amortissement = 1 : 2813, 2815),
-- capital, compte 129 et résultat en perte (charges 606100 > produits 707000).
-- Mêmes écritures en 2018 (Fiches_Mvt, IMP_BILAN-T05), 2017 (Fiches_Mvt1, N-1) et 2013 (Fiches_Mvt5, IMP_BILAN-T03),
-- montants différents par exercice ; une écriture non validée (validee = 0) en 2018.
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('80',1,1,'213000',0,'Construction','2018-01-15 00:00:00','I001','Achat batiment',10000.00,0.00,1,0,0,0,NULL,0,0),
('80',1,1,'211000',0,'Terrain','2018-01-15 00:00:00','I001','Achat terrain',3000.00,0.00,1,0,0,0,NULL,0,0),
('80',1,1,'101000',0,'Capital','2018-01-15 00:00:00','I001','Apport capital',0.00,13000.00,1,0,0,0,NULL,0,0),
('80',2,2,'681120',0,'Dotations','2018-12-31 00:00:00','D001','Dotation construction',1000.00,0.00,1,0,0,0,NULL,0,0),
('80',2,2,'281300',0,'Amortissement construction','2018-12-31 00:00:00','D001','Dotation construction',0.00,1000.00,1,0,0,0,NULL,0,0),
('80',3,3,'681120',0,'Dotations','2018-12-31 00:00:00','D002','Dotation materiel',150.00,0.00,1,0,0,0,NULL,0,0),
('80',3,3,'281500',0,'Amortissement materiel','2018-12-31 00:00:00','D002','Dotation materiel',0.00,150.00,1,0,0,0,NULL,0,0),
('60',4,4,'606100',0,'Fournitures','2018-03-01 00:00:00','A010','Achat fournitures',800.00,0.00,1,0,0,0,NULL,0,0),
('60',4,4,'512000',0,'Banque','2018-03-01 00:00:00','A010','Achat fournitures',0.00,800.00,1,0,0,0,NULL,0,0),
('70',5,5,'707000',0,'Ventes','2018-04-01 00:00:00','F010','Vente',0.00,500.00,1,0,0,0,NULL,0,0),
('70',5,5,'512000',0,'Banque','2018-04-01 00:00:00','F010','Vente',500.00,0.00,1,0,0,0,NULL,0,0),
('80',6,6,'129000',0,'Resultat. Perte','2018-01-02 00:00:00','R001','Affectation perte',250.00,0.00,1,0,0,0,NULL,0,0),
('80',6,6,'110000',0,'Report a nouveau','2018-01-02 00:00:00','R001','Affectation perte',0.00,250.00,1,0,0,0,NULL,0,0),
('80',7,0,'213000',0,'Construction','2018-05-01 00:00:00','I002','Non validee',999.00,0.00,0,0,0,0,NULL,0,0),
('80',7,0,'512000',0,'Banque','2018-05-01 00:00:00','I002','Non validee',0.00,999.00,0,0,0,0,NULL,0,0);
INSERT INTO Fiches_Mvt1 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('80',1,1,'213000',0,'Construction','2017-01-15 00:00:00','I001','Achat batiment',8000.00,0.00,1,0,0,0,NULL,0,1),
('80',1,1,'101000',0,'Capital','2017-01-15 00:00:00','I001','Apport capital',0.00,8000.00,1,0,0,0,NULL,0,1),
('80',2,2,'281300',0,'Amortissement construction','2017-12-31 00:00:00','D001','Dotation',0.00,400.00,1,0,0,0,NULL,0,1),
('80',2,2,'681120',0,'Dotations','2017-12-31 00:00:00','D001','Dotation',400.00,0.00,1,0,0,0,NULL,0,1),
('70',3,3,'707000',0,'Ventes','2017-04-01 00:00:00','F001','Vente',0.00,900.00,1,0,0,0,NULL,0,1),
('70',3,3,'512000',0,'Banque','2017-04-01 00:00:00','F001','Vente',900.00,0.00,1,0,0,0,NULL,0,1);
INSERT INTO Fiches_Mvt5 (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('80',1,1,'213000',0,'Construction','2013-01-15 00:00:00','I001','Achat batiment',5000.00,0.00,1,0,0,0,NULL,0,1),
('80',1,1,'101000',0,'Capital','2013-01-15 00:00:00','I001','Apport capital',0.00,5000.00,1,0,0,0,NULL,0,1),
('80',2,2,'281300',0,'Amortissement construction','2013-12-31 00:00:00','D001','Dotation',0.00,200.00,1,0,0,0,NULL,0,1),
('80',2,2,'681120',0,'Dotations','2013-12-31 00:00:00','D001','Dotation',200.00,0.00,1,0,0,0,NULL,0,1),
('80',3,3,'129000',0,'Resultat. Perte','2013-06-30 00:00:00','R001','Perte',300.00,0.00,1,0,0,0,NULL,0,1),
('80',3,3,'512000',0,'Banque','2013-06-30 00:00:00','R001','Perte',0.00,300.00,1,0,0,0,NULL,0,1),
('70',4,4,'707000',0,'Ventes','2013-04-01 00:00:00','F001','Vente',0.00,700.00,1,0,0,0,NULL,0,1),
('70',4,4,'512000',0,'Banque','2013-04-01 00:00:00','F001','Vente',700.00,0.00,1,0,0,0,NULL,0,1);
