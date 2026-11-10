-- Jeu de données CRUPT-T01 à T07 (ruptures de stock, Crupt.Rupture) : commandes fournisseurs et clients
-- (tables vides dans Laurux01.sql). Articles : A10 stocké (seuils 5/20) commandé chez 401001 et 401002,
-- A11 stocké (seuils 3/12, txconv 2) chez 401002, A12 non stocké, .DEP (divers) avec intitulés différents
-- et désignations préfixées « ~ ».
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_stocke, art_qte, art_stkmin, art_stkmax, art_txconv, art_nbd, art_tva) VALUES
  ('A10', 'Article stocke A10', '01', '401001', 1, 2, 5, 20, 1, 2, 1),
  ('A11', '~ Article stocke A11', '01', '401002', 1, 10, 3, 12, 2, 2, 1),
  ('A12', 'Article non stocke A12', '01', '401001', 0, 0, 0, 0, 1, 2, 1),
  ('.DEP', 'Divers', '01', '401001', 0, 0, 0, 0, 1, 2, 1);
INSERT INTO Fiches_Entcom (four, numcom, ddate, montant) VALUES
  ('401001', 'C1', '2024-03-01 00:00:00', 100), ('401002', 'C2', '2024-03-02 00:00:00', 80);
INSERT INTO Fiches_Ligcom (lind, code, design, numcom, four, qte, datecom, nligne) VALUES
  (1, 'A10', 'Article stocke A10', 'C1', '401001', 4, '2024-03-01 00:00:00', '1'),
  (2, 'A12', 'Article non stocke A12', 'C1', '401001', 2, '2024-03-01 00:00:00', '2'),
  (3, '.DEP', 'Divers transport', 'C1', '401001', 1, '2024-03-01 00:00:00', '3'),
  (4, 'A11', '~ Article stocke A11', 'C2', '401002', 6, '2024-03-02 00:00:00', '1'),
  (5, 'A10', 'Article stocke A10', 'C2', '401002', 3, '2024-03-02 00:00:00', '2');
INSERT INTO Fiches_Bl (numbl, type, cdclibl, cvclibl, nmclibl, pnmclibl, datebl) VALUES
  ('B00001', 'C', '411001', 'M.', 'Dupont', 'Jean', '2024-03-05 00:00:00'),
  ('B00002', 'C', '411002', 'Mme', 'Martin', 'Anne', '2024-03-06 00:00:00'),
  ('B00003', 'C', '411001', 'M.', 'Dupont', 'Jean', '2024-03-07 00:00:00'),
  ('B00004', 'B', '411003', 'M.', 'Durand', 'Luc', '2024-03-07 00:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, typel_ligbl, four_ligbl) VALUES
  ('B00001', '1', 'A10', 'Article stocke A10', '5', 'A', '401001'),
  ('B00001', '2', 'A12', 'Article non stocke A12', '3', 'A', NULL),
  ('B00001', '3', '.DEP', '~ Divers transport', '2', 'A', '401001'),
  ('B00002', '1', 'A10', 'Article stocke A10', '2', 'A', '401002'),
  ('B00002', '2', 'A11', '~ Article stocke A11', '4', 'A', NULL),
  ('B00002', '3', '.DEP', 'Divers emballage', '1', 'A', '401001'),
  ('B00002', '4', 'TXT', 'Ligne de texte', '0', 'T', NULL),
  ('B00003', '1', 'A10', 'Article stocke A10', '1', 'A', '401001'),
  ('B00004', '1', 'A10', 'Article stocke A10', '9', 'A', '401001');
