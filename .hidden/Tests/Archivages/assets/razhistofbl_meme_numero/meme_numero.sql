-- Jeu RAZHISTOFBL-T03 : même numéro 1234 chez deux fournisseurs, l'un antérieur, l'autre postérieur à 2018-06-15.
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, validee) VALUES
('F1', '1234', '2018-05-02 09:00:00', 1),
('F2', '1234', '2018-07-01 09:00:00', 1);
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, nligne) VALUES
('ART1', '1234', 'F1', '2018-05-02 09:00:00', '1'),
('ART2', '1234', 'F2', '2018-07-01 09:00:00', '1');
