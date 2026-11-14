-- Jeu de données RELVMO-T01..T07 (RelvMo.class) : lignes de main-d'oeuvre (typel 'M') appliquées après Laurux01.sql
-- (Fiches_Bl/Ligbl, Fiches_HistoFac/Ligfac et Fiches_HistoFacM/LigfacM vides dans Laurux01).
-- Période par défaut de l'écran au 15.06.2018 : du 01.01.2018 (lendemain de dteclec1) au 15.06.2018.
-- BL facturés (type F)
INSERT INTO Fiches_Bl (numbl, type, cdclibl, nmclibl, datebl, imp) VALUES
('000001', 'F', '411001', 'A Divers', '2018-03-10 00:00:00', 1),
('000002', 'F', '411001', 'A Divers', '2018-03-11 00:00:00', 0),
('000003', 'F', '411001', 'A Divers', '2017-11-10 00:00:00', 1),
('000004', 'B', '411003', 'C Divers', '2018-03-12 00:00:00', 1);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, typel_ligbl, qte_ligbl, nettc_ligbl) VALUES
('000001', '1', '01', 'M', '2', '33,60'),
('000001', '2', '01', 'M', '1', '16,80'),
('000001', '3', '02', 'M', '1', '18,60'),
('000001', '4', '01', 'A', '5', '10,00'),
('000002', '1', '03', 'M', '4', '84,00'),
('000003', '1', '01', 'M', '7', '117,60'),
('000004', '1', '02', 'M', '9', '167,40');
-- Factures historisées : bornes de période (01.01.2018 et 15.06.2018), quantité vide
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac) VALUES
('F00010', '411002', 'B Divers', '2018-01-01 00:00:00'),
('F00011', '411002', 'B Divers', '2018-06-15 00:00:00'),
('F00012', '411002', 'B Divers', '2018-06-16 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, qte_ligfac, nettc_ligfac) VALUES
('F00010', '1', '01', 'M', '', '16,80'),
('F00010', '2', '03', 'M', '3', '63,00'),
('F00011', '1', '02', 'M', '1', '18,60'),
('F00012', '1', '04', 'M', '1', '42,00');
-- Factures historisées (mois) : cumul du même couple (MO, client)
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, datefac) VALUES
('M00001', '411003', 'C Divers', '2018-04-01 00:00:00');
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, qte_ligfac, nettc_ligfac) VALUES
('M00001', '1', '03', 'M', '2', '42,00'),
('M00001', '2', '03', 'M', '1', '21,00'),
('M00001', '3', '05', 'M', '1', '20,16');
