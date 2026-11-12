-- Jeu de données RecupDech (RECUPDECH-T01/T03), appliqué après Laurux01.sql.
-- Lignes exportées : 401/411 avec collectif NULL et dateech non NULL (dont une échéance avec heure non nulle).
-- Lignes exclues : collectif = 1, dateech NULL, compte 512.
INSERT INTO Fiches_Mvt (jour, numero, compte, collectif, intitule, dte, dateech, numdoc, libelle, montantd, montantc, validee, lind) VALUES
 ('70', 3, '411002', NULL, 'Client Deux', '2018-02-05 00:00:00', '2018-03-05 00:00:00', 'F0003', 'Facture trois', 60.00, 0.00, 1, 1),
 ('70', 3, '706000', NULL, 'Ventes', '2018-02-05 00:00:00', '2018-03-05 00:00:00', 'F0003', 'Facture trois', 0.00, 60.00, 1, 2),
 ('60', 1, '401001', NULL, 'Fournisseur', '2018-02-01 00:00:00', '2018-04-30 14:30:00', 'A0001', 'Achat un', 0.00, 90.00, 1, 3),
 ('60', 1, '607000', NULL, 'Achats', '2018-02-01 00:00:00', NULL, 'A0001', 'Achat un', 90.00, 0.00, 1, 4),
 ('70', 2, '411001', 1, 'Client Un', '2018-02-02 00:00:00', '2018-03-02 00:00:00', 'F0002', 'Facture deux collectif', 30.00, 0.00, 1, 5),
 ('70', 2, '411003', NULL, 'Client Trois', '2018-02-02 00:00:00', NULL, 'F0002', 'Facture deux sans echeance', 30.00, 0.00, 1, 6),
 ('50', 4, '512000', NULL, 'Banque', '2018-02-03 00:00:00', '2018-02-28 00:00:00', 'B0004', 'Banque quatre', 15.00, 0.00, 1, 7),
 ('60', 5, '401002', NULL, 'Fournisseur Deux', '2018-02-04 00:00:00', '2018-05-31 00:00:00', 'A0005', 'Achat cinq', 0.00, 40.00, 1, 8);
