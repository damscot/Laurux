-- Jeu Edbl/Edbr (agent 6, vague 5) : réceptions fournisseurs (Fiches_Entrecpt / Fiches_Ligrecpt).
-- R002 (401002) : 1 ligne ; R001 partagé par 401001 (2 lignes, 01/06) et 401002 (1 ligne, 04/06).
INSERT INTO Fiches_Entrecpt (four, numrecpt, ddate, montant, validee, mttc) VALUES
('401001', 'R001', '2018-06-01 00:00:00', 70, 1, 84),
('401002', 'R002', '2018-06-03 00:00:00', 25, 1, 30),
('401002', 'R001', '2018-06-04 00:00:00', 36, 1, 43.2);
INSERT INTO Fiches_Ligrecpt (code, design, numrecpt, four, daterecpt, qte, pbht, rm, paht, frais, prvt, nligne, pattc) VALUES
('001', 'Produit 2.10', 'R001', '401001', '2018-06-01 00:00:00', 5, 10, 0, 10, 0, 10, '1', 12),
('002', 'Produit 7.00', 'R001', '401001', '2018-06-01 00:00:00', 2, 12, 16.67, 10, 0, 10, '2', 12),
('003', 'produit 20.00', 'R002', '401002', '2018-06-03 00:00:00', 1, 25, 0, 25, 0, 25, '1', 30),
('001', 'Produit 2.10', 'R001', '401002', '2018-06-04 00:00:00', 3, 12, 0, 12, 0, 12, '1', 14.4);
