-- Jeu de données LCOUL-T04 (fragments SQL de couleur de LCoul), appliqué après Laurux01.sql.
-- Articles : 004 suspendu, 005 stocké épuisé, 006 non stocké, 007 état indéterminé (art_stocke NULL).
-- Documents Fiches_Bl de chaque type (D, C, B, F) et un acquitté ; écritures Fiches_Mvt dans chaque état.
INSERT INTO Fiches_Art (art_code, art_design, art_stocke, art_qte, art_suspendu) VALUES
  ('004', 'Suspendu', 1, 5, 1),
  ('005', 'Epuise', 1, 0, 0),
  ('006', 'Non stocke', 0, 0, 0),
  ('007', 'Indetermine', NULL, 3, 0);
INSERT INTO Fiches_Bl (numbl, type, cdclibl, acquitte) VALUES
  ('D00001', 'D', 'C001', 0), ('C00001', 'C', 'C001', 0), ('B00001', 'B', 'C001', 0),
  ('F00001', 'F', 'C001', 0), ('F00002', 'F', 'C001', 1);
INSERT INTO Fiches_Mvt (jour, numero, compte, dte, libelle, montantd, montantc, provisoire, pointee, lettree, cloturee) VALUES
  ('VT', 1, '411001', '2024-01-10', 'normale', 10, 0, 0, 0, 0, 0),
  ('VT', 2, '411001', '2024-01-10', 'lettree', 10, 0, 0, 0, 1, 0),
  ('VT', 3, '411001', '2024-01-10', 'pointee', 10, 0, 0, 1, 0, 0),
  ('VT', 4, '411001', '2024-01-10', 'cloturee', 10, 0, 0, 0, 0, 1),
  ('VT', 5, '411001', '2024-01-10', 'provisoire', 10, 0, 1, 0, 0, 0),
  ('VT', 6, '411001', '2024-01-10', 'lettree pointee', 10, 0, 0, 1, 1, 0);
