-- Jeu Imp_Sig T03 (agent 3, vague 7) : exercice 2018 (Fiches_Mvt). Production vendue (S0070) : 706100 crédit 500 puis
-- 709000 débit 30 (dernier compte de la rubrique, cumul positif 470) ; coût d'achat (S0050) : 607000 débit 200 et
-- 609700 crédit 20 ; charges exceptionnelles (S0340) 671000 débit 200 sans produit exceptionnel (résultat négatif).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,nrlv,lettree,cloturee) VALUES
('70',1,1,'706100',0,'Ventes MO','2018-02-10 00:00:00','F001','Facture F001',0.00,500.00,1,0,0,0,NULL,0,0),
('70',2,2,'709000',0,'RRR accordes','2018-03-10 00:00:00','AV02','Avoir AV02',30.00,0.00,1,0,0,0,NULL,0,0),
('60',3,3,'607000',0,'Achats','2018-03-15 00:00:00','A003','Achat A003',200.00,0.00,1,0,0,0,NULL,0,0),
('60',4,4,'609700','0','RRR obtenus','2018-04-15 00:00:00','A004','Avoir A004',0.00,20.00,1,0,0,0,NULL,0,0),
('10',5,5,'671000',0,'Charges exceptionnelles','2018-05-15 00:00:00','OD5','Penalite',200.00,0.00,1,0,0,0,NULL,0,0);
