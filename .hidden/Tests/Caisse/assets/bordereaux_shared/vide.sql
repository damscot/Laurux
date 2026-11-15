-- Bordereaux (phase 2, vague 7) : aucune ligne U/V dans Fiches_LigTicketz, gestion des caisses activée par le blob conf.
UPDATE Fiches_Parametres SET conf = '[Soc01]\nCaisse=-1\n';
INSERT INTO Fiches_LigTicketz (numero, numlig, code, intitule, montant, qte, type, fam, mht, mrem, mtva, block, tva, date) VALUES
('0000107', '1', '', 'Espèces', '5.00', '1', 'E', '', '', '', '', '1', '', '2018-06-15 09:40:00');
