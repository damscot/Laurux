-- Bordereaux (phase 2, vague 7) : tickets réglés par chèque dont un supprimé et un en erreur (statut E),
-- gestion des caisses activée par le blob conf ; les lignes de règlement (V) sont toutes dans Fiches_LigTicketz.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\n';
INSERT INTO Fiches_EntTicketz (caisse, numero, date, client, scheque, mcheque, mttc, statut, type, suppr) VALUES
('1', '0000301', '2018-06-15 09:00:00', 'DURAND', '1', '10.00', '10.00', 'V', 'T', 0),
('1', '0000302', '2018-06-15 09:10:00', 'DUPUIS', '1', '20.00', '20.00', 'V', 'T', 1),
('1', '0000303', '2018-06-15 09:20:00', 'MARTIN', '1', '30.00', '30.00', 'E', 'T', 0);
INSERT INTO Fiches_LigTicketz (numero, numlig, code, intitule, montant, qte, type, fam, mht, mrem, mtva, block, tva, date) VALUES
('0000301', '1', '', 'Chèque DURAND valide', '10.00', '1', 'V', '', '', '', '', '1', '', '2018-06-15 09:00:00'),
('0000302', '2', '', 'Chèque DUPUIS supprime', '20.00', '1', 'V', '', '', '', '', '1', '', '2018-06-15 09:10:00'),
('0000303', '3', '', 'Chèque MARTIN erreur', '30.00', '1', 'V', '', '', '', '', '1', '', '2018-06-15 09:20:00');
