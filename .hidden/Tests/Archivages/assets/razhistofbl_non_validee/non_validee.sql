-- Jeu RAZHISTOFBL-T04 : réception non validée (validee = 0) antérieure à 2018-06-15, réception validée postérieure.
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, validee) VALUES
('F1', 'R3001', '2018-05-02 09:00:00', 0),
('F1', 'R3002', '2018-07-01 09:00:00', 1);
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne) VALUES
('ART1', 'R3001', 'F1', '2018-05-02 09:00:00', '1'),
('ART1', 'R3002', 'F1', '2018-07-01 09:00:00', '1');
