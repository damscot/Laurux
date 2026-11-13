-- ECHEANCIER-T07 : facture client 411006 avec, dans son lot, un règlement au débit négatif (-30) et un règlement
-- normal au crédit (20).
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, dateech, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, lettree, cloturee) VALUES
('01',1,'411006',NULL,'F Divers','2018-03-01','2018-03-31','F1','L000000021','Facture F1',150.00,0.00,1,0,0,0,0,0),
('03',2,'411006',NULL,'F Divers','2018-03-10',NULL,'R1','L000000021','Reglement negatif',-30.00,0.00,1,0,1,0,0,0),
('03',3,'411006',NULL,'F Divers','2018-03-12',NULL,'R2','L000000021','Reglement',0.00,20.00,1,0,1,0,0,0);
