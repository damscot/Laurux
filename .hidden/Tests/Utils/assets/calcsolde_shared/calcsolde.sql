-- Jeu de données CALCSOLDE-T01 à T06 : écritures Fiches_Mvt (table vide dans Laurux01.sql).
-- 607000 (général) : validées et non validée ; 512000 (trésorerie) : report à nouveau clôturé du journal
-- jdr (90), écritures pointées / non pointées, pointée non validée, report dans un autre journal ;
-- 411001 : montants négatifs et arrondis ; 512001 (trésorerie) sans écriture, soldes initiaux non nuls.
INSERT INTO Fiches_Mvt (jour, numero, compte, dte, libelle, montantd, montantc, validee, pointee, cloturee) VALUES
  ('60', 1, '607000', '2024-01-10 00:00:00', 'Achat', 100.00, 0.00, 1, 0, 0),
  ('60', 2, '607000', '2024-01-11 00:00:00', 'Achat', 50.25, 0.00, 1, 0, 0),
  ('60', 3, '607000', '2024-01-12 00:00:00', 'Avoir', 0.00, 20.50, 1, 0, 0),
  ('60', 4, '607000', '2024-01-13 00:00:00', 'Achat non valide', 80.00, 0.00, 0, 0, 0),
  ('90', 10, '512000', '2024-01-01 00:00:00', 'Report a nouveau', 1000.00, 0.00, 1, 0, 1),
  ('10', 15, '512000', '2024-01-01 00:00:00', 'Report a nouveau', 7.00, 0.00, 1, 0, 1),
  ('50', 11, '512000', '2024-01-05 00:00:00', 'Encaissement', 200.00, 0.00, 1, 1, 0),
  ('50', 12, '512000', '2024-01-06 00:00:00', 'Paiement', 0.00, 150.00, 1, 0, 0),
  ('50', 13, '512000', '2024-01-07 00:00:00', 'Paiement', 0.00, 30.00, 1, 1, 0),
  ('50', 14, '512000', '2024-01-08 00:00:00', 'Pointee non validee', 500.00, 0.00, 0, 1, 0),
  ('70', 20, '411001', '2024-02-01 00:00:00', 'Facture', 120.40, 0.00, 1, 0, 0),
  ('70', 21, '411001', '2024-02-02 00:00:00', 'Avoir negatif', -15.10, 0.00, 1, 0, 0),
  ('70', 22, '411001', '2024-02-03 00:00:00', 'Reglement', 0.00, 100.333, 1, 1, 0),
  ('70', 23, '411001', '2024-02-04 00:00:00', 'Ecart', 0.00, -0.004, 1, 0, 0);
UPDATE Fiches_Comptes SET solde = 3, soldep = 7 WHERE compte_cc = 607000;
UPDATE Fiches_Comptes SET solde = 1, soldep = 5.55 WHERE compte_cc = 512000;
UPDATE Fiches_Comptes SET solde = 12, soldep = 99.99 WHERE compte_cc = 512001;
