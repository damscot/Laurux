-- Jeu MAJEQU : articles A, B, C, D (codes équivalents), table Fiches_Cequ vide.
DELETE FROM Fiches_Cequ;
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_tva, art_nbd) VALUES ('A', 'Article A', '01', '401001', '3', '2'), ('B', 'Article B', '01', '401001', '3', '2'), ('C', 'Article C', '01', '401001', '3', '2'), ('D', 'Article D', '01', '401001', '3', '2');
