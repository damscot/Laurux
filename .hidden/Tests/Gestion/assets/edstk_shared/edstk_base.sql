-- Jeu EdStk (agent 6, vague 5) : articles stockés et non stockés (plus les 3 articles de Laurux01).
-- S01..S05 stockés (familles 01/02/03, fournisseurs 401001/401002), quantités positive, nulle et négative,
-- paht/pmp différents, nbd/dec 0/2/3, codes fournisseur/barre/équivalent présents ou absents ; N01 non stocké.
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_stocke, art_qte, art_paht, art_pmp, art_pbht, art_tr, art_nbd, art_dec, art_cfour, art_cbarre, art_cequ, art_tva) VALUES
('S01', 'Stocke un', '01', '401001', 1, 10, 2.5, 2.4, 3, 0, '2', '0', 'CF-S01', '3000000000101', 'EQ-S01', 1),
('S02', 'Stocke deux', '02', '401002', 1, 0, 7.125, 7, 9, 0, '3', '3', NULL, '3000000000202', NULL, 2),
('S03', 'Stocke trois', '03', '401001', 1, -4, 12, 11.5, 15, 5, '0', '2', 'CF-S03', NULL, 'EQ-S03', 3),
('S04', 'Stocke quatre', '02', '401002', 1, 2.5, 1.333, 1.2, 2, 0, '2', '2', NULL, NULL, NULL, 2),
('S05', 'Stocke cinq', '01', '401002', 1, 100, 0.5, 0.45, 1, 0, '2', '0', 'CF-S05', '3000000000505', NULL, 1),
('N01', 'Non stocke', '01', '401001', 0, 50, 4, 4, 5, 0, '2', '0', 'CF-N01', NULL, NULL, 1);
