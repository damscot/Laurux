-- Jeu EmailingCarte : trois cartes de fidélité sans courriel (aucun envoi SMTP), codes numériques (saisie filtrée
-- par ChkInput). Fiches_Carte est vide dans Laurux01.sql.
INSERT INTO Fiches_Carte (code, nom, pnm, cd_ptl, ville, email) VALUES
('1001', 'MARTIN', 'Paul', '44000', 'NANTES', NULL),
('1002', 'DURAND', 'Anne', '69001', 'LYON', NULL),
('1003', 'PETIT', 'Luc', '75001', 'PARIS', NULL);
