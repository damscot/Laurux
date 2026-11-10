-- Jeu de données UTILS-T15/T16 (Utils.Find_cbarre, Utils.Commande), appliqué après Laurux01.sql.
-- Code-barres secondaire pour l'article 002 ; lignes de commandes fournisseurs : 1 ligne pour 001,
-- 3 lignes pour 002, aucune pour 003.
INSERT INTO Fiches_CdBarre (codep, codeb) VALUES ('002', '3000000000017');
INSERT INTO Fiches_Ligcom (code, design, numcom, four, qte, nligne) VALUES
  ('001', 'Produit 2.10', 'C00001', '401001', 2.5, '1'),
  ('002', 'Produit 7.00', 'C00001', '401001', 1, '2'),
  ('002', 'Produit 7.00', 'C00002', '401001', 2.25, '1'),
  ('002', 'Produit 7.00', 'C00003', '401001', 0.333, '1');
