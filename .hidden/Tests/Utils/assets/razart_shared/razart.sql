-- Jeu de données RAZART-T01 à T06 : zones article non nulles pour rendre visibles les remises à zéro
-- (stocké, commande, stock de départ, quantité, PMP différent du prix de revient) et codes-barres
-- contenant « 30 » au début (3012345678901) et au milieu (1230456789012), en fiche et en table annexe.
UPDATE Fiches_Art SET art_stocke = 1, art_com = 5, art_stkdep = 3, art_qte = 7, art_pmp = 9.5, art_prvt = 10.000, art_cbarre = '3012345678901' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 0, art_com = 2, art_stkdep = 1, art_qte = 4, art_pmp = 8, art_prvt = 11.250, art_cbarre = '1230456789012' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_com = 0, art_stkdep = 0, art_qte = 2, art_pmp = 1, art_prvt = 0.000, art_cbarre = '2148413200099' WHERE art_code = '003';
DELETE FROM Fiches_CdBarre;
INSERT INTO Fiches_CdBarre (codep, codeb) VALUES ('001', '3012345678901'), ('002', '1230456789012'), ('003', '2148413200099'), ('A30', '9999999999999');
