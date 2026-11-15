-- Bordereaux (phase 2, vague 7) : gestion des caisses activée par le blob conf ; règlements par carte (U) et par chèque (V)
-- sur 2 caisses et 2 jours dans Fiches_LigTicketz (numlig 1 à 10 pour vérifier le tri numérique, 10 après 9).
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\n';
INSERT INTO Fiches_LigTicketz (numero, numlig, code, intitule, montant, qte, type, fam, mht, mrem, mtva, block, tva, date) VALUES
('0000101', '1', '', 'Chèque DURAND Paul', '25.00', '1', 'V', '', '', '', '', '1', '', '2018-06-14 09:10:00'),
('0000102', '2', '', 'Carte  CB 4970', '12.50', '1', 'U', '', '', '', '', '1', '', '2018-06-14 09:20:00'),
('0000103', '3', '', 'Chèque DUPUIS Anne', '40.10', '1', 'V', '', '', '', '', '2', '', '2018-06-14 10:00:00'),
('0000104', '9', '', 'Carte  CB 5131', '7.90', '1', 'U', '', '', '', '', '2', '', '2018-06-15 08:30:00'),
('0000105', '10', '', 'Chèque MARTIN Luc', '100.00', '1', 'V', '', '', '', '', '1', '', '2018-06-15 09:00:00'),
('0000106', '11', '', 'Carte  CB 4012', '30.00', '1', 'U', '', '', '', '', '1', '', '2018-06-15 09:30:00'),
('0000107', '12', '', 'Espèces', '5.00', '1', 'E', '', '', '', '', '1', '', '2018-06-15 09:40:00');
