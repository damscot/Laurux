-- EXPART-T03 : article TNULL avec art_pbht NULL, autres prix renseignés (après TDEC0 en ordre de lecture).
INSERT INTO Fiches_Art (art_code, art_design, art_nbd, art_stocke, art_pbht, art_tr, art_pauaht, art_txconv, art_paht, art_frais, art_prvt, art_coef, art_pvht, art_tva, art_pvttc, art_pvcons, art_qte) VALUES
('TDEC0', 'Article zero decimale', 0, 1, 10.5, 0, 10.5, 1, 10.5, 0, 10.5, 1.2, 12.25, '1', 14.7, 0, 3),
('TNULL', 'Article prix null', 2, 1, NULL, 0, 1, 1, 1, 0, 1, 1.9, 2, '1', 2.4, 0, 1);
