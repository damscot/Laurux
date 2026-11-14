-- Jeu RELVMO-T06 (saut de page) : relvmo_mo.sql + 35 mains-d'oeuvre facturées au client 411002 (F00020, 10.05.2018).
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

INSERT INTO Fiches_Mo (mo_code, mo_design) VALUES
('S01', 'Mo saut 01'),
('S02', 'Mo saut 02'),
('S03', 'Mo saut 03'),
('S04', 'Mo saut 04'),
('S05', 'Mo saut 05'),
('S06', 'Mo saut 06'),
('S07', 'Mo saut 07'),
('S08', 'Mo saut 08'),
('S09', 'Mo saut 09'),
('S10', 'Mo saut 10'),
('S11', 'Mo saut 11'),
('S12', 'Mo saut 12'),
('S13', 'Mo saut 13'),
('S14', 'Mo saut 14'),
('S15', 'Mo saut 15'),
('S16', 'Mo saut 16'),
('S17', 'Mo saut 17'),
('S18', 'Mo saut 18'),
('S19', 'Mo saut 19'),
('S20', 'Mo saut 20'),
('S21', 'Mo saut 21'),
('S22', 'Mo saut 22'),
('S23', 'Mo saut 23'),
('S24', 'Mo saut 24'),
('S25', 'Mo saut 25'),
('S26', 'Mo saut 26'),
('S27', 'Mo saut 27'),
('S28', 'Mo saut 28'),
('S29', 'Mo saut 29'),
('S30', 'Mo saut 30'),
('S31', 'Mo saut 31'),
('S32', 'Mo saut 32'),
('S33', 'Mo saut 33'),
('S34', 'Mo saut 34'),
('S35', 'Mo saut 35');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac) VALUES ('F00020', '411002', 'B Divers', '2018-05-10 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, typel_ligfac, qte_ligfac, nettc_ligfac) VALUES
('F00020', '1', 'S01', 'M', '1', '10,00'),
('F00020', '2', 'S02', 'M', '1', '10,00'),
('F00020', '3', 'S03', 'M', '1', '10,00'),
('F00020', '4', 'S04', 'M', '1', '10,00'),
('F00020', '5', 'S05', 'M', '1', '10,00'),
('F00020', '6', 'S06', 'M', '1', '10,00'),
('F00020', '7', 'S07', 'M', '1', '10,00'),
('F00020', '8', 'S08', 'M', '1', '10,00'),
('F00020', '9', 'S09', 'M', '1', '10,00'),
('F00020', '10', 'S10', 'M', '1', '10,00'),
('F00020', '11', 'S11', 'M', '1', '10,00'),
('F00020', '12', 'S12', 'M', '1', '10,00'),
('F00020', '13', 'S13', 'M', '1', '10,00'),
('F00020', '14', 'S14', 'M', '1', '10,00'),
('F00020', '15', 'S15', 'M', '1', '10,00'),
('F00020', '16', 'S16', 'M', '1', '10,00'),
('F00020', '17', 'S17', 'M', '1', '10,00'),
('F00020', '18', 'S18', 'M', '1', '10,00'),
('F00020', '19', 'S19', 'M', '1', '10,00'),
('F00020', '20', 'S20', 'M', '1', '10,00'),
('F00020', '21', 'S21', 'M', '1', '10,00'),
('F00020', '22', 'S22', 'M', '1', '10,00'),
('F00020', '23', 'S23', 'M', '1', '10,00'),
('F00020', '24', 'S24', 'M', '1', '10,00'),
('F00020', '25', 'S25', 'M', '1', '10,00'),
('F00020', '26', 'S26', 'M', '1', '10,00'),
('F00020', '27', 'S27', 'M', '1', '10,00'),
('F00020', '28', 'S28', 'M', '1', '10,00'),
('F00020', '29', 'S29', 'M', '1', '10,00'),
('F00020', '30', 'S30', 'M', '1', '10,00'),
('F00020', '31', 'S31', 'M', '1', '10,00'),
('F00020', '32', 'S32', 'M', '1', '10,00'),
('F00020', '33', 'S33', 'M', '1', '10,00'),
('F00020', '34', 'S34', 'M', '1', '10,00'),
('F00020', '35', 'S35', 'M', '1', '10,00');
