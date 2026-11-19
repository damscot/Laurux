-- Jeu de données VALIDBR1 (ValidBR1.class) : réceptions de juin 2018 à valider.
-- 401001 : 3 BR non validées (R00001 : 001 + 002, deux familles et deux taux de TVA ; R00002 : 001 ; R00003 : 002).
-- 401002 (exonéré) : R00010 non validée. 401003 : R00020 validée sans compta (validee = 2).
-- 401004 : R00030 non validée sur l'article 003, famille 03 sans compte d'achat valide (compt3_fam = 999999).
-- Familles : 01 et 02 → compte d'achat 602100 ; TVA 01 → code 1 (2,10 %, 445660), 02 → code 2 (5,50 %, 445670).
UPDATE Fiches_Fam SET compt3_fam = '602100', cdtva_fam = '1' WHERE code_fam = '01';
UPDATE Fiches_Fam SET compt3_fam = '602100', cdtva_fam = '2' WHERE code_fam = '02';
UPDATE Fiches_Fam SET compt3_fam = '999999', cdtva_fam = '1' WHERE code_fam = '03';
UPDATE Fiches_Four SET fo_exo = 0, fo_copie = 0 WHERE fo_code IN ('401001', '401003', '401004');
UPDATE Fiches_Four SET fo_exo = 1, fo_copie = 0 WHERE fo_code = '401002';
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, montant, mttc, validee) VALUES
('401001', 'R00001', '2018-06-01 00:00:00', 50.00, 51.73, 0),
('401001', 'R00002', '2018-06-05 00:00:00', 30.00, 30.63, 0),
('401001', 'R00003', '2018-06-08 00:00:00', 20.00, 21.10, 0),
('401002', 'R00010', '2018-06-03 00:00:00', 40.00, 40.00, 0),
('401003', 'R00020', '2018-06-04 00:00:00', 10.00, 10.21, 2),
('401004', 'R00030', '2018-06-06 00:00:00', 15.00, 15.32, 0);
INSERT INTO Fiches_Ligrecpt (code, design, numrecpt, four, daterecpt, qte, paht, prvt, nligne, txconv) VALUES
('001', 'Produit 2.10', 'R00001', '401001', '2018-06-01 00:00:00', 5, 6, 6, '1', 1),
('002', 'Produit 7.00', 'R00001', '401001', '2018-06-01 00:00:00', 4, 5, 5, '2', 1),
('001', 'Produit 2.10', 'R00002', '401001', '2018-06-05 00:00:00', 3, 10, 10, '1', 1),
('002', 'Produit 7.00', 'R00003', '401001', '2018-06-08 00:00:00', 2, 10, 10, '1', 1),
('001', 'Produit 2.10', 'R00010', '401002', '2018-06-03 00:00:00', 4, 10, 10, '1', 1),
('001', 'Produit 2.10', 'R00020', '401003', '2018-06-04 00:00:00', 1, 10, 10, '1', 1),
('003', 'produit 20.00', 'R00030', '401004', '2018-06-06 00:00:00', 1, 15, 15, '1', 1);
