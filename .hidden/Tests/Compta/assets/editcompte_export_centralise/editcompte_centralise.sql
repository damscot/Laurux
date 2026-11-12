-- Jeu Editcompte T06 (agent 3, vague 3) : 707000 centralisé (cent_cc = 1) mouvementé sur 3 mois
-- (janvier, février, avril 2018) et 2 journaux (70, 71), fins de mois 31/28/30.
UPDATE Fiches_Comptes SET cent_cc = 1 WHERE compte_cc = 707000;
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'707000',0,'Ventes','2018-01-15 00:00:00','F001','Facture F001',0.00,100.00,1,0,0,0,NULL,0,0),
('70',2,2,'707000',0,'Ventes','2018-01-31 00:00:00','F002','Facture F002',0.00,50.00,1,0,0,0,NULL,0,0),
('70',3,3,'707000',0,'Ventes','2018-02-28 00:00:00','F003','Facture F003',0.00,70.00,1,0,0,0,NULL,0,0),
('71',4,4,'707000',0,'Ventes','2018-02-10 00:00:00','F004','Avoir F004',20.00,0.00,1,0,0,0,NULL,0,0),
('70',5,5,'707000',0,'Ventes','2018-04-30 00:00:00','F005','Facture F005',0.00,30.00,1,0,0,0,NULL,0,0),
('70',6,6,'607000',0,'Achats','2018-03-12 00:00:00','A006','Achat A006',45.00,0.00,1,0,0,0,NULL,0,0);
