-- Jeu Tleg : une seule ligne lind = 2 (texte XYZ), pas de lind = 1 (TLEG-T03).
DELETE FROM Fiches_Tleg;
INSERT INTO Fiches_Tleg (lind, intitule) VALUES (2, 'XYZ');
