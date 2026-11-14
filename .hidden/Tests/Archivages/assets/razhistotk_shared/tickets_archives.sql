-- Jeu RAZHISTOTK : tickets archivés avant, le jour même et après 2018-06-15, avec lignes.
INSERT INTO Fiches_HisEntTickets (lInd, caisse, numero, client, mttc, date) VALUES
(1, '01', '0000001', 'TICKET ANCIEN', '10.00', '2018-05-02 09:00:00'),
(2, '01', '0000002', 'TICKET DU JOUR', '20.00', '2018-06-15 08:00:00'),
(3, '01', '0000003', 'TICKET FUTUR', '30.00', '2018-07-01 09:00:00');
INSERT INTO Fiches_HisLigTickets (lInd, numero, numlig, code, intitule, montant, date) VALUES
(1, '0000001', '1', 'ART1', 'Ligne 1 ticket ancien', '5.00', '2018-05-02 09:00:00'),
(2, '0000001', '2', 'ART2', 'Ligne 2 ticket ancien', '5.00', '2018-05-02 09:00:00'),
(3, '0000002', '1', 'ART1', 'Ligne ticket du jour', '20.00', '2018-06-15 08:00:00'),
(4, '0000003', '1', 'ART1', 'Ligne ticket futur', '30.00', '2018-07-01 09:00:00');
