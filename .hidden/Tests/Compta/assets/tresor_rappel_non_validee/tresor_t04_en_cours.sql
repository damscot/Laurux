-- TRESOR-T05 : état laissé par TRESOR-T04 (écriture n° 1 du journal 50 laissée en cours, Quitter « Oui ») :
-- lignes provisoires 606100 et 707000 et ligne banque 512000 aux montants de la dernière ligne (TRESOR-A07),
-- recopiées du dump attendu de tresor_abandon_saisie (colonne control comprise).
INSERT INTO Fiches_Mvt (jour, numero, numerodef, compte, collectif, intitule, dte, datee, dateech, numcol, numdoc, numlot, libelle, montantd, montantc, validee, provisoire, tresorerie, pointee, nrlv, lettree, cloturee, relance, lind, dteval, export, control) VALUES
 ('50', '1', NULL, '606100', NULL, 'Fournitures non stockables', '2018-06-15 00:00:00', '2018-06-15 00:00:00', NULL, NULL, '1', '1', 'A', 100.00, 0.00, 0, 1, 1, NULL, NULL, 0, 0, NULL, 1, NULL, NULL, 'wyt95EirzbxPt063nnaGG++c9VA='),
 ('50', '1', NULL, '512000', NULL, 'Banque', '2018-06-15 00:00:00', '2018-06-15 00:00:00', NULL, NULL, '1', '1', 'A', 40.00, 0.00, 0, 1, 1, 0, NULL, 0, 0, NULL, 2, NULL, NULL, 'YUqYw4DAw14AzaMFlZf+sUOd1lw='),
 ('50', '1', NULL, '707000', NULL, 'Ventes marchandises 2.10', '2018-06-15 00:00:00', '2018-06-15 00:00:00', NULL, NULL, '1', '1', 'A', 40.00, 0.00, 0, 1, 1, NULL, NULL, 0, 0, NULL, 3, NULL, NULL, 'Sw9oQcEg+sI8xhFDRl3FvBSoGug=');
