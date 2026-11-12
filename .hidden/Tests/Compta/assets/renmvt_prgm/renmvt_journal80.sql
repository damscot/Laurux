-- Jeu de données RenMvt (RENMVT-T01/T03), appliqué après Laurux01.sql.
-- Journal 80 dans Fiches_Mvt : écriture 51001 (2 lignes ; le numéro tronqué 1001 existe aussi dans Fiches_Mvt,
-- journal 10, compte 411000) et écriture 52002 (1 ligne, déjà présente dans Fiches_Mvt1 sous 2002/607000).
INSERT INTO Fiches_Mvt (jour, numero, compte, intitule, dte, numdoc, libelle, montantd, montantc, validee, pointee, cloturee, lind) VALUES
 ('80', 51001, '411000', 'Clients', '2018-01-10 00:00:00', 'R1001', 'Report 80 un', 120.50, 0, 0, 0, 0, 1),
 ('80', 51001, '512000', 'Banque', '2018-01-10 00:00:00', 'R1001', 'Report 80 un', 0, 120.50, 0, 0, 0, 2),
 ('80', 52002, '607000', 'Achats', '2018-01-11 00:00:00', 'R2002', 'Report 80 deux', 45.00, 0, 0, 0, 0, 3),
 ('10', 1001, '411000', 'Clients', '2018-01-12 00:00:00', 'V1001', 'Vente 1001', 99.00, 0, 1, 0, 0, 4),
 ('10', 1001, '706000', 'Ventes', '2018-01-12 00:00:00', 'V1001', 'Vente 1001', 0, 99.00, 1, 0, 0, 5);
INSERT INTO Fiches_Mvt1 (jour, numero, compte, intitule, dte, numdoc, libelle, montantd, montantc, validee, pointee, cloturee, lind) VALUES
 ('80', 2002, '607000', 'Achats', '2017-01-11 00:00:00', 'R2002', 'Deja reporte', 45.00, 0, 1, 0, 0, 1);
