-- Jeu Statcai : 2 caisses ; tickets archivés du 14/06/2018 (7 h 30, 8 h 15, 9 h 10, 9 h 40, 14 h, 21 h, ticket supprimé à 10 h)
-- et du 13/06/2018 ; tickets en cours du 14/06/2018 (statut 0 à 11 h, V à 12 h, V à 9 h 20 de même CA que les archivés de 9 h).
INSERT INTO Fiches_Caisses (code, intitule) VALUES ('01', 'Caisse un'), ('02', 'Caisse deux');
INSERT INTO Fiches_HisEntTickets (caisse, numero, date, mht, suppr) VALUES
('01', '0000201', '2018-06-14 07:30:00', '10,00', 0),
('01', '0000202', '2018-06-14 08:15:00', '4,00', 0),
('01', '0000203', '2018-06-14 09:10:00', '20,00', 0),
('01', '0000204', '2018-06-14 09:40:00', '5,50', 0),
('01', '0000205', '2018-06-14 10:00:00', '99,00', 1),
('02', '0000206', '2018-06-14 14:00:00', '30.00', 0),
('02', '0000207', '2018-06-14 21:00:00', '7,00', 0),
('01', '0000208', '2018-06-13 09:00:00', '500,00', 0);
INSERT INTO Fiches_EntTicketz (caisse, numero, date, mht, statut, suppr) VALUES
('01', '0000301', '2018-06-14 11:00:00', '40,00', '0', 0),
('02', '0000302', '2018-06-14 12:00:00', '50,00', 'V', 0),
('01', '0000303', '2018-06-14 09:20:00', '25,50', 'V', 0);
