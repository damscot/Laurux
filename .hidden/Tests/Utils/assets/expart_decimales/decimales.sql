-- EXPART-T02 : articles TDEC0, TDEC2, TDEC3 (art_nbd 0, 2, 3), stocké / non stocké, tous les prix renseignés.
INSERT INTO Fiches_Art (art_code, art_design, art_nbd, art_stocke, art_pbht, art_tr, art_pauaht, art_txconv, art_paht, art_frais, art_prvt, art_coef, art_pvht, art_tva, art_pvttc, art_pvcons, art_qte) VALUES
('TDEC0', 'Article zero decimale', 0, 1, 10.5, 0, 10.5, 1, 10.5, 0, 10.5, 1.2, 12.25, '1', 14.7, 0, 3),
('TDEC2', 'Article deux decimales', 2, 0, 1.234, 0, 1.234, 1, 1.234, 0, 1.234, 1.9, 2.345, '1', 2.814, 0, 0),
('TDEC3', 'Article trois decimales', 3, 1, 0.1235, 0, 0.1235, 1, 0.1235, 0, 0.1235, 1.9, 0.2346, '1', 0.2815, 0, 5);
