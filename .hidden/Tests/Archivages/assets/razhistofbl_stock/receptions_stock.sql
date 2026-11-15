-- Jeu RAZHISTOFBL-T05 : article 001 stocké (stock de départ 10, art_qte faussé à 99), réception R1001 antérieure à la
-- date de purge (2018-05-02, 4 unités) et R1002 du jour (2018-06-15, 3 unités), après le début d'exercice.
UPDATE Fiches_Art SET art_stocke = 1, art_stkdep = 10, art_txconv = 1, art_qte = 99 WHERE art_code = '001';
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, validee) VALUES
('F1', 'R1001', '2018-05-02 09:00:00', 1),
('F1', 'R1002', '2018-06-15 08:00:00', 1);
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne, qte, txconv) VALUES
('001', 'R1001', 'F1', '2018-05-02 09:00:00', '1', 4, 1),
('001', 'R1002', 'F1', '2018-06-15 08:00:00', '1', 3, 1);
