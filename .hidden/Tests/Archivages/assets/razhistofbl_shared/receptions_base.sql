-- Jeu RAZHISTOFBL : réceptions validées avant, le jour même et après 2018-06-15 (numéros distincts), avec lignes.
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, validee) VALUES
('F1', 'R1001', '2018-05-02 09:00:00', 1),
('F1', 'R1002', '2018-06-15 08:00:00', 1),
('F2', 'R2001', '2018-07-01 09:00:00', 1);
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne) VALUES
('ART1', 'R1001', 'F1', '2018-05-02 09:00:00', '1'),
('ART2', 'R1001', 'F1', '2018-05-02 09:00:00', '2'),
('ART1', 'R1002', 'F1', '2018-06-15 08:00:00', '1'),
('ART1', 'R2001', 'F2', '2018-07-01 09:00:00', '1');
