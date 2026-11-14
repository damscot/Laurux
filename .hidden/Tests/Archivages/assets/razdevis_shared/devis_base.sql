-- Jeu RAZDEVIS : devis (type D) avant, le jour même et après 2018-06-15 ; BL (B) et facturé (F) antérieurs ;
-- devis matériel (Fiches_BlM) avant/après ; adresse de livraison du devis purgé.
INSERT INTO Fiches_Bl (numbl, type, datebl, cdclibl, nmclibl) VALUES
('900001', 'D', '2018-05-02 09:00:00', '411000', 'DEVIS ANCIEN'),
('900002', 'D', '2018-06-15 08:00:00', '411000', 'DEVIS DU JOUR'),
('900003', 'D', '2018-07-01 09:00:00', '411000', 'DEVIS FUTUR'),
('900004', 'B', '2018-05-02 09:00:00', '411000', 'BL ANCIEN'),
('900005', 'F', '2018-05-02 09:00:00', '411000', 'FACTURE ANCIENNE');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl) VALUES
('900001', '1', 'ART1', 'Ligne 1 devis ancien'),
('900001', '2', 'ART2', 'Ligne 2 devis ancien'),
('900002', '1', 'ART1', 'Ligne devis du jour'),
('900003', '1', 'ART1', 'Ligne devis futur'),
('900004', '1', 'ART1', 'Ligne BL ancien'),
('900005', '1', 'ART1', 'Ligne facture ancienne');
INSERT INTO Fiches_AdrlivBL (numbl, nom, adr1, cp, ville) VALUES
('900001', 'LIVRAISON DEVIS ANCIEN', '1 rue du Test', '75001', 'PARIS');
INSERT INTO Fiches_BlM (numbl, type, datebl) VALUES
('800001', 'D', '2018-05-02 09:00:00'),
('800002', 'D', '2018-07-01 09:00:00'),
('800003', 'B', '2018-05-02 09:00:00');
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl) VALUES
('800001', '1'), ('800002', '1'), ('800003', '1');
