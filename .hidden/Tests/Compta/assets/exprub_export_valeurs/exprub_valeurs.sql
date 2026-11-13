-- EXPRUB-T03 : valeurs particulières ajoutées à Laurux01
-- intitulé NULL, intitulé contenant « ; », rubrique L sans plage, plage avec compte2 et amortissement NULL
INSERT INTO Fiches_Rubriques (numrub, intitule, type, detail, num) VALUES
('Z0010', NULL, 'T', NULL, NULL),
('Z0020', 'Achats; marchandises', 'L', 'N', 'P'),
('Z0030', 'Rubrique L sans plage', 'L', NULL, NULL);
INSERT INTO Fiches_RubCompt (numrub, compte1, compte2, amortissement) VALUES
('Z0020', '607', NULL, NULL),
('Z0020', '2807', '28079999', 1);
