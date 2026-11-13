-- Jeu de données Relevés (agent 3, vague 4) : écriture sur un compte 411 sans fiche client (411999)
-- et sur un compte 401 sans fiche fournisseur (401999), en juin 2018 (collectif NULL).
INSERT INTO Fiches_Mvt (jour,numero,numerodef,compte,collectif,intitule,dte,numdoc,libelle,montantd,montantc,validee,provisoire,tresorerie,pointee,lettree,cloturee) VALUES
('70',1,1,'411999',NULL,'Sans fiche','2018-06-05 00:00:00','F901','Facture F901',80.00,0.00,1,0,0,0,0,0),
('70',1,1,'707000',NULL,'Ventes','2018-06-05 00:00:00','F901','Facture F901',0.00,80.00,1,0,0,0,0,0),
('60',2,2,'401999',NULL,'Sans fiche','2018-06-06 00:00:00','A901','Achat A901',0.00,45.00,1,0,0,0,0,0),
('60',2,2,'607000',NULL,'Achats','2018-06-06 00:00:00','A901','Achat A901',45.00,0.00,1,0,0,0,0,0);
