-- Jeu de données RECUPN-T03 : Fiches_Mvt1 renseignée (comme recupn_mvt1), Fiches_Mvt vide.
INSERT INTO Fiches_Mvt1 (jour, numero, numerodef, compte, collectif, intitule, dte, numcol, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, lettree, cloturee) VALUES
('70', 1, 1, '411001', 1, 'Client 1', '2017-03-01', '411', 'F1', 'L1', 'Facture 1', 120.00, 0.00, 1, 0, 0, 0, 1, 1),
('70', 1, 1, '707000', 0, 'Ventes', '2017-03-01', '', 'F1', 'L1', 'Facture 1', 0.00, 100.00, 1, 0, 0, 0, 0, 1),
('70', 1, 1, '445710', 0, 'TVA', '2017-03-01', '', 'F1', 'L1', 'Facture 1', 0.00, 20.00, 1, 0, 0, 0, 0, 1),
('80', 2, 2, '512000', 0, 'Banque', '2017-03-05', '', 'R1', 'L2', 'Reglement 1', 120.00, 0.00, 1, 0, 1, 1, 0, 1),
('80', 2, 2, '411001', 1, 'Client 1', '2017-03-05', '411', 'R1', 'L2', 'Reglement 1', 0.00, 120.00, 1, 0, 1, 0, 1, 1),
('70', 5, 5, '411002', 1, 'Client 2', '2017-04-01', '411', 'F2', 'L3', 'Facture 2', 60.00, 0.00, 0, 1, 0, 0, 0, 0),
('70', 5, 5, '707000', 0, 'Ventes', '2017-04-01', '', 'F2', 'L3', 'Facture 2', 0.00, 60.00, 0, 1, 0, 0, 0, 0),
('90', 500, 500, '512000', 0, 'Banque', '2017-12-31', '', 'X', 'L4', 'Hors plage', 10.00, 0.00, 1, 0, 0, 0, 0, 0);
