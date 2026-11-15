-- Jeu StatComArt / VisStatComArt : factures archivées et lignes article par commercial.
-- 411001, 411002 -> commercial 01 ; 411003 -> 02 ; 411004 sans commercial.
-- F18103 existe dans HistoFac (411003) et HistoFacM (411002) : lignes lues dans HistoLigfac (A02).
-- M18101 n'a de lignes que dans HistoLigfacM (ignorées, A02). F18105 hors période (juillet).
INSERT INTO Fiches_Commerciaux (code, nom, prenom, comm) VALUES
('01', 'DUPONT', 'Jean', 0),
('02', 'MARTIN', 'Paul', 5.5);
UPDATE Fiches_Cli SET cli_comm = '01' WHERE cli_code IN (411001, 411002);
UPDATE Fiches_Cli SET cli_comm = '02' WHERE cli_code = 411003;
UPDATE Fiches_Cli SET cli_comm = NULL WHERE cli_code = 411004;
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18101', '411001', 'A Divers', 'Alain', '2018-03-05 00:00:00', '0', '0', 180.50),
('F18102', '411002', 'B Divers', 'Bruno', '2018-04-02 00:00:00', '0', '0', 150.00),
('F18103', '411003', 'C Divers', 'Claire', '2018-05-10 00:00:00', '0', '0', 140.00),
('F18104', '411004', 'D Divers', 'Denis', '2018-05-11 00:00:00', '0', '0', 999.00),
('F18105', '411002', 'B Divers', 'Bruno', '2018-07-01 00:00:00', '0', '0', 777.00);
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('F18101', '1', 'ART1', 'Article un', '2', '100.00', 'A'),
('F18101', '2', 'MO1', 'Main d oeuvre', '1', '50.00', 'M'),
('F18101', '3', 'ART2', 'Article deux', '1', '30,50', 'A'),
('F18102', '1', 'ART1', 'Article un', '3', '150.00', 'A'),
('F18103', '1', 'ART1', 'Article un', '1', '60.00', 'A'),
('F18103', '2', 'ART3', 'Article trois', '4', '80.00', 'A'),
('F18104', '1', 'ART1', 'Article un', '9', '999.00', 'A'),
('F18105', '1', 'ART4', 'Article quatre', '1', '777.00', 'A');
INSERT INTO Fiches_HistoFacM (numfac, cdclifac, nmclifac, pnmclifac, datefac, remmofac, remartfac, totfac) VALUES
('F18103', '411002', 'B Divers', 'Bruno', '2018-02-15 00:00:00', '0', '0', 140.00),
('M18101', '411001', 'A Divers', 'Alain', '2018-03-01 00:00:00', '0', '0', 40.00);
INSERT INTO Fiches_HistoLigfacM (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('M18101', '1', 'ART5', 'Article cinq', '1', '40.00', 'A');
-- VISSTATCOMART-T05 : 55 articles supplémentaires sur F18101 (commercial 01) : plus de 50 lignes, 2 pages.
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('F18101', '11', 'P001', 'Produit 001', '1', '2.00', 'A'),
('F18101', '12', 'P002', 'Produit 002', '1', '3.00', 'A'),
('F18101', '13', 'P003', 'Produit 003', '1', '4.00', 'A'),
('F18101', '14', 'P004', 'Produit 004', '1', '5.00', 'A'),
('F18101', '15', 'P005', 'Produit 005', '1', '6.00', 'A'),
('F18101', '16', 'P006', 'Produit 006', '1', '7.00', 'A'),
('F18101', '17', 'P007', 'Produit 007', '1', '8.00', 'A'),
('F18101', '18', 'P008', 'Produit 008', '1', '9.00', 'A'),
('F18101', '19', 'P009', 'Produit 009', '1', '10.00', 'A'),
('F18101', '20', 'P010', 'Produit 010', '1', '11.00', 'A'),
('F18101', '21', 'P011', 'Produit 011', '1', '12.00', 'A'),
('F18101', '22', 'P012', 'Produit 012', '1', '13.00', 'A'),
('F18101', '23', 'P013', 'Produit 013', '1', '14.00', 'A'),
('F18101', '24', 'P014', 'Produit 014', '1', '15.00', 'A'),
('F18101', '25', 'P015', 'Produit 015', '1', '16.00', 'A'),
('F18101', '26', 'P016', 'Produit 016', '1', '17.00', 'A'),
('F18101', '27', 'P017', 'Produit 017', '1', '18.00', 'A'),
('F18101', '28', 'P018', 'Produit 018', '1', '19.00', 'A'),
('F18101', '29', 'P019', 'Produit 019', '1', '20.00', 'A'),
('F18101', '30', 'P020', 'Produit 020', '1', '21.00', 'A'),
('F18101', '31', 'P021', 'Produit 021', '1', '22.00', 'A'),
('F18101', '32', 'P022', 'Produit 022', '1', '23.00', 'A'),
('F18101', '33', 'P023', 'Produit 023', '1', '24.00', 'A'),
('F18101', '34', 'P024', 'Produit 024', '1', '25.00', 'A'),
('F18101', '35', 'P025', 'Produit 025', '1', '26.00', 'A'),
('F18101', '36', 'P026', 'Produit 026', '1', '27.00', 'A'),
('F18101', '37', 'P027', 'Produit 027', '1', '28.00', 'A'),
('F18101', '38', 'P028', 'Produit 028', '1', '29.00', 'A'),
('F18101', '39', 'P029', 'Produit 029', '1', '30.00', 'A'),
('F18101', '40', 'P030', 'Produit 030', '1', '31.00', 'A'),
('F18101', '41', 'P031', 'Produit 031', '1', '32.00', 'A'),
('F18101', '42', 'P032', 'Produit 032', '1', '33.00', 'A'),
('F18101', '43', 'P033', 'Produit 033', '1', '34.00', 'A'),
('F18101', '44', 'P034', 'Produit 034', '1', '35.00', 'A'),
('F18101', '45', 'P035', 'Produit 035', '1', '36.00', 'A'),
('F18101', '46', 'P036', 'Produit 036', '1', '37.00', 'A'),
('F18101', '47', 'P037', 'Produit 037', '1', '38.00', 'A'),
('F18101', '48', 'P038', 'Produit 038', '1', '39.00', 'A'),
('F18101', '49', 'P039', 'Produit 039', '1', '40.00', 'A'),
('F18101', '50', 'P040', 'Produit 040', '1', '41.00', 'A'),
('F18101', '51', 'P041', 'Produit 041', '1', '42.00', 'A'),
('F18101', '52', 'P042', 'Produit 042', '1', '43.00', 'A'),
('F18101', '53', 'P043', 'Produit 043', '1', '44.00', 'A'),
('F18101', '54', 'P044', 'Produit 044', '1', '45.00', 'A'),
('F18101', '55', 'P045', 'Produit 045', '1', '46.00', 'A'),
('F18101', '56', 'P046', 'Produit 046', '1', '47.00', 'A'),
('F18101', '57', 'P047', 'Produit 047', '1', '48.00', 'A'),
('F18101', '58', 'P048', 'Produit 048', '1', '49.00', 'A'),
('F18101', '59', 'P049', 'Produit 049', '1', '50.00', 'A'),
('F18101', '60', 'P050', 'Produit 050', '1', '51.00', 'A'),
('F18101', '61', 'P051', 'Produit 051', '1', '52.00', 'A'),
('F18101', '62', 'P052', 'Produit 052', '1', '53.00', 'A'),
('F18101', '63', 'P053', 'Produit 053', '1', '54.00', 'A'),
('F18101', '64', 'P054', 'Produit 054', '1', '55.00', 'A'),
('F18101', '65', 'P055', 'Produit 055', '1', '56.00', 'A');
