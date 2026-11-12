-- Jeu de données CSTOCK-T01 à T08, T10 (.hidden/reference/.src/Utils/Cstock.module/test.md) : articles stockés avec
-- une seule source de mouvement chacun (S01 à S10), inventaires tournants (Y/Z), valeurs limites (V),
-- article non stocké (N01). Date de départ : dteinv NULL dans Laurux01.sql → dteclec1 = 2017-12-31.
-- art_qte initialisé à 999 pour repérer les articles recalculés. Appliqué après Laurux01.sql.

INSERT INTO Fiches_Art (art_code, art_design, art_stocke, art_casier, art_qte, art_stkdep, art_txconv) VALUES
 ('S01', 'BL type B', 1, 'A01', 999, 100, 1),
 ('S02', 'BL type F', 1, 'A05', 999, 100, 1),
 ('S03', 'BL archive (BlM)', 1, 'B10', 999, 100, 1),
 ('S04', 'Facture', 1, 'B99', 999, 100, 1),
 ('S05', 'Facture archive (M)', 1, 'C01', 999, 100, 1),
 ('S06', 'Reception txconv 1', 1, 'C02', 999, 100, 1),
 ('S07', 'Reception txconv 6', 1, 'C03', 999, 100, 6),
 ('S08', 'Mouvement exceptionnel', 1, 'C04', 999, 100, 1),
 ('S09', 'Mouvement exceptionnel dc', 1, 'C05', 999, 100, 1),
 ('S10', 'Depots 01 et 02', 1, 'C06', 999, 100, 1),
 ('D01', 'Date de depart', 1, 'D01', 999, 100, 1),
 ('N01', 'Non stocke', 0, 'A02', 999, 100, 1),
 ('V01', 'Quantite NULL', 1, 'V01', 999, 100, 1),
 ('V02', 'Quantite texte 1,5', 1, 'V02', 999, 100, 1),
 ('V03', 'txconv NULL', 1, 'V03', 999, 100, NULL),
 ('V04', 'stkdep NULL', 1, 'V04', 999, NULL, 1),
 ('YI01', 'Deux inventaires tournants', 1, 'Y01', 999, 100, 1),
 ('ZF1', 'Inventaire tournant 01/06', 1, 'Z01', 999, 100, 1),
 ('ZF2', 'Inventaire tournant 01/03', 1, 'Z02', 999, 100, 1);

-- BL : B (compté), F (compté), D (ignoré) ; ligne texte T ignorée ; une ligne avant la date de départ
INSERT INTO Fiches_Bl (numbl, type, cdclibl, datebl) VALUES
 ('900001', 'B', 'C1', '2018-05-15 10:00:00'),
 ('900002', 'F', 'C1', '2018-05-16 10:00:00'),
 ('900003', 'D', 'C1', '2018-05-17 10:00:00'),
 ('900004', 'B', 'C1', '2017-06-01 10:00:00'),
 ('900005', 'B', 'C1', '2018-02-01 10:00:00'),
 ('900006', 'B', 'C1', '2018-05-01 10:00:00'),
 ('900007', 'B', 'C1', '2018-10-01 10:00:00');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, typel_ligbl, dte_ligbl) VALUES
 ('900001', '1', 'S01', '2', 'A', '2018-05-15 10:00:00'),
 ('900001', '2', 'S01', '50', 'T', '2018-05-15 10:00:00'),
 ('900002', '1', 'S02', '3', 'A', '2018-05-16 10:00:00'),
 ('900003', '1', 'S01', '100', 'A', '2018-05-17 10:00:00'),
 ('900003', '2', 'S02', '100', 'A', '2018-05-17 10:00:00'),
 ('900004', '1', 'D01', '7', 'A', '2017-06-01 10:00:00'),
 ('900001', '3', 'D01', '1', 'A', '2018-05-15 10:00:00'),
 ('900001', '4', 'V01', NULL, 'A', '2018-05-15 10:00:00'),
 ('900001', '5', 'V02', '1,5', 'A', '2018-05-15 10:00:00'),
 ('900001', '6', 'V04', '2', 'A', '2018-05-15 10:00:00'),
 ('900005', '1', 'YI01', '1', 'A', '2018-02-01 10:00:00'),
 ('900006', '1', 'YI01', '2', 'A', '2018-05-01 10:00:00'),
 ('900007', '1', 'YI01', '4', 'A', '2018-10-01 10:00:00'),
 ('900006', '2', 'ZF1', '1', 'A', '2018-05-01 10:00:00'),
 ('900007', '2', 'ZF1', '2', 'A', '2018-10-01 10:00:00'),
 ('900006', '3', 'ZF2', '3', 'A', '2018-05-01 10:00:00'),
 ('900007', '3', 'ZF2', '4', 'A', '2018-10-01 10:00:00'),
 ('900001', '7', 'N01', '5', 'A', '2018-05-15 10:00:00');

-- BL archivés (BlM)
INSERT INTO Fiches_BlM (numbl, type, datebl) VALUES ('800001', 'B', '2018-06-01 10:00:00'), ('800002', 'X', '2018-06-02 10:00:00');
INSERT INTO Fiches_LigblM (num_ligbl, numlig_ligbl, code_ligbl, qte_ligbl, typel_ligbl, dte_ligbl) VALUES
 ('800001', '1', 'S03', '4', 'A', '2018-06-01 10:00:00'),
 ('800002', '1', 'S03', '40', 'A', '2018-06-02 10:00:00');

-- Factures et factures archivées (M)
INSERT INTO Fiches_HistoFac (numfac, cdclifac, datefac) VALUES ('F900001', 'C1', '2018-07-01 10:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, qte_ligfac, typel_ligfac, dtligbl_ligfac) VALUES
 ('F900001', '1', 'S04', '5', 'A', '2018-07-01 10:00:00'),
 ('F900001', '2', 'S04', '9', 'M', '2018-07-01 10:00:00'),
 ('F900001', '3', 'S04', '8', 'A', '2017-07-01 10:00:00');
INSERT INTO Fiches_HistoFacM (numfac, datefac) VALUES ('F800001', '2018-07-02 10:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, qte_ligfac, typel_ligfac, dtligbl_ligfac) VALUES
 ('F800001', '1', 'S05', '6', 'A', '2018-07-02 10:00:00');

-- Réceptions (multipliées par art_txconv de l'article)
INSERT INTO Fiches_Ligrecpt (code, numrecpt, four, daterecpt, qte, nligne, txconv) VALUES
 ('S06', 'R1', 'F001', '2018-08-01 10:00:00', 7, '1', 1),
 ('S07', 'R1', 'F001', '2018-08-01 10:00:00', 2, '2', 1),
 ('V03', 'R1', 'F001', '2018-08-01 10:00:00', 3, '3', 1),
 ('S06', 'R0', 'F001', '2017-08-01 10:00:00', 70, '1', 1);

-- Mouvements exceptionnels
INSERT INTO Fiches_Mvtexp (mind, code, daterecpt, qtep, qtem) VALUES
 (9001, 'S08', '2018-09-01 10:00:00', '10', '3'),
 (9002, 'S08', '2017-09-01 10:00:00', '100', '0');
INSERT INTO Fiches_Mvtexpdc (id, mind, code, daterecpt, qtep, qtem, type) VALUES
 (9001, 9001, 'S09', '2018-09-01 10:00:00', '5', '1', 'E');

-- Dépôts : seul le dépôt 01 compte (E ajoute, S retranche)
INSERT INTO Fiches_Sdepots (mind, code, cart, date, type, qte) VALUES
 (9001, '01', 'S10', '2018-09-01', 'E', '4'),
 (9002, '01', 'S10', '2018-09-02', 'S', '1'),
 (9003, '02', 'S10', '2018-09-03', 'E', '50');

-- Inventaires tournants : YI01 au 01/03 (50) et au 01/09 (30) ; ZF1 au 01/06 (20) ; ZF2 au 01/03 (60)
INSERT INTO Fiches_HisInvT (inv_num, inv_code, inv_qtestock, inv_qtecomptee, inv_date) VALUES
 (1, 'YI01', 50, 50, '2018-03-01'),
 (2, 'YI01', 30, 30, '2018-09-01'),
 (3, 'ZF1', 20, 20, '2018-06-01'),
 (4, 'ZF2', 60, 60, '2018-03-01');
