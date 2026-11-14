-- Jeu VisHitCartes : deux cartes dont tous les tickets ont 0 point.
INSERT INTO Fiches_Carte (code, nom, pnm) VALUES
('2000000000011', 'DUPONT', 'Jean'),
('2000000000028', 'MARTIN', 'Anne');
INSERT INTO Fiches_HisEntTickets (caisse, numero, client, mht, suppr, type, carte, points, date) VALUES
('01', '0000101', '411001', '10,00', 0, 'T', '2000000000011', 0.000, '2018-03-01 10:00:00'),
('01', '0000102', '411001', '25,00', 0, 'T', '2000000000028', 0.000, '2018-04-01 10:00:00');
