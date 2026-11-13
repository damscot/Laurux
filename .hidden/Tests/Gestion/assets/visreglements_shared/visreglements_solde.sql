-- Jeu Visreglements : 411001 avec 3 écritures validées et 1 non validée ; solde 99 posé sur 411001 et 411002
-- (411002 sans écriture) pour vérifier le recalcul de Calc_solde (VISREGLEMENTS-T05).
INSERT INTO Fiches_Mvt (jour, numero, compte, dte, libelle, montantd, montantc, validee) VALUES
('VT', 1, '411001', '2018-06-01 00:00:00', 'Facture 1', 120.50, 0, 1),
('VT', 2, '411001', '2018-06-02 00:00:00', 'Facture 2', 80.00, 0, 1),
('BQ', 3, '411001', '2018-06-03 00:00:00', 'Reglement', 0, 50.25, 1),
('BQ', 4, '411001', '2018-06-04 00:00:00', 'Non validee', 0, 1000.00, 0);
UPDATE Fiches_Comptes SET solde = 99 WHERE compte_cc IN ('411001', '411002');
