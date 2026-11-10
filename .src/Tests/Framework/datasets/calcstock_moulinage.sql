-- Jeu de données CALCSTOCK-T07 : calcstock_mvt + ticket Z non mouliné dans Fiches_EntTicketz.
UPDATE Fiches_Art SET art_stocke = 1, art_stkdep = 10, art_txconv = 1, art_casier = 'A05', art_qte = 99 WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_stkdep = 5, art_txconv = 2, art_casier = 'B10', art_qte = 0 WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 0, art_stkdep = 0, art_casier = 'C01', art_qte = 7 WHERE art_code = '003';
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne, qte, txconv) VALUES
('001', 'R0001', 'F1', '2025-01-10 00:00:00', '1', 4, 1),
('002', 'R0001', 'F1', '2025-01-10 00:00:00', '2', 3, 1),
('001', 'R0000', 'F1', '2017-06-01 00:00:00', '1', 100, 1);
INSERT INTO Fiches_Mvtexp (code, daterecpt, qtep, qtem, com) VALUES
('001', '2025-02-01 00:00:00', '0', '2', 'Casse'),
('002', '2025-02-02 00:00:00', '1,5', '0', 'Retour');
INSERT INTO Fiches_EntTicketz (caisse, numero, date) VALUES ('01', '0000001', '2025-03-01 10:00:00');
