-- Jeu de données VISPMP-T01 : deux articles à PMP négatif.
UPDATE Fiches_Art SET art_pmp = -1.5, art_prvt = 2.000 WHERE art_code = '001';
UPDATE Fiches_Art SET art_pmp = -0.25, art_prvt = 1.250 WHERE art_code = '002';
