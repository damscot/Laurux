-- DateTar (phase 2, vague 5) : tarifs temporaires. Articles 001-003 de Laurux01 (fournisseur 401001) et A4 ajouté
-- (fournisseur 401002). temp_type : 1 général, 2 client, 3 type de client.
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_pbht, art_tr, art_paht, art_coef, art_pvht, art_tva, art_pvttc, art_cdarr) VALUES
('A4', 'Article quatre', '01', '401002', 10, 0, 10, 2.0000, 20, '2', 21.1, '0,01');
INSERT INTO Fiches_TarTemp (art, dtmaj, date, pbht, rm, paht, frais, pxrev, txconv, temp_type, code, temp_coef, temp_sup) VALUES
('001', 0, NULL, 12.000, 0.00, 12.000, 0.000, 12.000, 1.0000, 1, '', 2.5000, 0),
('001', 0, NULL, 12.000, 0.00, 12.000, 0.000, 12.000, 1.0000, 2, '411001', 1.8000, 0),
('002', 1, '2026-12-01 00:00:00', 11.000, 0.00, 11.000, 0.000, 11.000, 1.0000, 1, '', 2.2000, 0),
('003', 1, '2026-12-01 00:00:00', 5.000, 0.00, 5.000, 0.000, 5.000, 1.0000, 1, '', 3.0000, 0),
('003', 0, NULL, 5.000, 0.00, 5.000, 0.000, 5.000, 1.0000, 3, '1', 1.5000, 1),
('A4', 0, NULL, 9.000, 0.00, 9.000, 0.000, 9.000, 1.0000, 1, '', 2.0000, 0);
