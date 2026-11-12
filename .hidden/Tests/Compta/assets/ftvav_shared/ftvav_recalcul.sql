-- FTvav (FTVAV-T03 à T05) : articles au code TVA 3 avec arrondis 0,05 et 0,50, BL et bon d'entretien non
-- facturés avec lignes article (A) et main-d'oeuvre (M) au code 3 (et une ligne au code 2, non recalculée),
-- code TVA 5 inutilisé (suppression acceptée).
INSERT INTO Fiches_Art (art_code, art_design, art_stocke, art_tva, art_pvht, art_pvttc, art_cdarr, art_nbd) VALUES
 ('TV05', 'Arrondi 0,05', '0', '3', 10.37, 12.44, '0,05', '2'),
 ('TV50', 'Arrondi 0,50', '0', '3', 8.30, 9.96, '0,50', '2');
INSERT INTO Fiches_Bl (numbl, type, imp, datebl) VALUES ('900001', 'B', 0, '2026-01-10 10:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES
 ('900001', '1', 'TV05', '10.37', '3', '12.44', 'A'),
 ('900001', '2', '04', '35', '3', '42', 'M'),
 ('900001', '3', 'TV50', '8.30', '2', '8.88', 'A');
INSERT INTO Fiches_BlM (numbl, type, imp) VALUES ('900002', 'B', 0);
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, netht_ligbl, tx_ligbl, nettc_ligbl, typel_ligbl) VALUES
 ('900002', '1', 'TV50', '8.30', '3', '9.96', 'A'),
 ('900002', '2', '04', '35', '3', '42', 'M');
INSERT INTO Fiches_Tvaav (code_tva, taux_tva, cc_tva) VALUES ('5', '5.50', '445510');
