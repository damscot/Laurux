-- Jeu de données HISTOCOM-T01/T02 (HistoCom.class) : lignes de factures historisées de type « C » (commentaire)
-- avec libellé, libellé NULL, libellé vide, com_ligfac déjà rempli, et lignes d'autres types (A, M).
-- Appliqué après Laurux01.sql (Fiches_HistoLigfac vide).
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, typel_ligfac, com_ligfac) VALUES
('F00001', '1', NULL, 'Commentaire libre', 'C', NULL),
('F00001', '2', NULL, NULL, 'C', NULL),
('F00001', '3', NULL, '', 'C', NULL),
('F00001', '4', NULL, 'Nouveau libellé', 'C', 'Ancien commentaire'),
('F00001', '5', 'ART1', 'Article vendu', 'A', NULL),
('F00002', '1', 'MO', 'Main d''oeuvre', 'M', 'Commentaire MO'),
('F00002', '2', NULL, 'Commentaire accentué é à ç', 'C', '');
