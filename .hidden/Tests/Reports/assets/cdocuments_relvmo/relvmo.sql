-- Jeu CDOCUMENTS-T06 : client 411003 avec 10 codes de main d'oeuvre RV01 à RV10 facturés en 2018 (Fiches_HistoFac, lignes M),
-- pour le relevé des prestations RelvMo (Cdocuments Level1R/Level2R/Level3R/Level4R) sur une seule page.
INSERT INTO Fiches_Mo (mo_code, mo_design) VALUES ('RV01', 'Prestation 01'), ('RV02', 'Prestation 02'), ('RV03', 'Prestation 03'), ('RV04', 'Prestation 04'), ('RV05', 'Prestation 05'), ('RV06', 'Prestation 06'), ('RV07', 'Prestation 07'), ('RV08', 'Prestation 08'), ('RV09', 'Prestation 09'), ('RV10', 'Prestation 10');
INSERT INTO Fiches_HistoFac (numfac, cdclifac, nmclifac, datefac) VALUES ('FR0001', '411003', 'Divers', '2018-03-05 00:00:00'), ('FR0002', '411003', 'Divers', '2018-05-05 00:00:00');
INSERT INTO Fiches_HistoLigfac (num_ligfac, numlig_ligfac, code_ligfac, libel_ligfac, qte_ligfac, netht_ligfac, typel_ligfac) VALUES
('FR0002', '1', 'RV01', 'Prestation 01', '1', '10,00', 'M'),
('FR0001', '2', 'RV02', 'Prestation 02', '2', '20,00', 'M'),
('FR0002', '3', 'RV03', 'Prestation 03', '3', '30,00', 'M'),
('FR0001', '4', 'RV04', 'Prestation 04', '4', '40,00', 'M'),
('FR0002', '5', 'RV05', 'Prestation 05', '5', '50,00', 'M'),
('FR0001', '6', 'RV06', 'Prestation 06', '6', '60,00', 'M'),
('FR0002', '7', 'RV07', 'Prestation 07', '7', '70,00', 'M'),
('FR0001', '8', 'RV08', 'Prestation 08', '8', '80,00', 'M'),
('FR0002', '9', 'RV09', 'Prestation 09', '9', '90,00', 'M'),
('FR0001', '10', 'RV10', 'Prestation 10', '10', '100,00', 'M');
