-- Jeu RAZHISTOTK-T03 : même numéro 0000010 sur deux caisses, l'un antérieur, l'autre postérieur à 2018-06-15.
INSERT INTO Fiches_HisEntTickets (lInd, caisse, numero, client, mttc, date) VALUES
(1, '01', '0000010', 'CAISSE 01 ANCIEN', '10.00', '2018-05-02 09:00:00'),
(2, '02', '0000010', 'CAISSE 02 FUTUR', '30.00', '2018-07-01 09:00:00'),
(3, '01', '0000011', 'TICKET FUTUR', '40.00', '2018-07-01 10:00:00');
INSERT INTO Fiches_HisLigTickets (lInd, numero, numlig, code, intitule, montant, date) VALUES
(1, '0000010', '1', 'ART1', 'Ligne caisse 01', '10.00', '2018-05-02 09:00:00'),
(2, '0000010', '1', 'ART1', 'Ligne caisse 02', '30.00', '2018-07-01 09:00:00'),
(3, '0000011', '1', 'ART1', 'Ligne ticket futur', '40.00', '2018-07-01 10:00:00');
