-- Mvtex : articles stockés A1 (0 décimale) et A2 (2 décimales), article non stocké NS1, code-barre 3760000000024 de A2.
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_dec, art_stocke, art_qte, art_prdcomp, art_pvht, art_pvttc, art_tva) VALUES
('A1', 'Article un', '01', '0', 1, 10, 0, 5, 6, '1'),
('A2', 'Article deux', '01', '2', 1, 20, 0, 3, 3.6, '1'),
('NS1', 'Article non stocke', '01', '2', 0, 0, 0, 4, 4.8, '1');
INSERT INTO Fiches_CdBarre (codep, codeb) VALUES ('A2', '3760000000024');
