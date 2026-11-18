-- Jeu VALIDINVT-T10 : invt_compte + vente (BL B000901 du 10/06/2018, 2 x 001) après la génération du
-- 01/06/2018 et avant la validation : art_qte de 001 = 8 (10 - 2), inv_qtestock reste 10.
UPDATE Fiches_Art SET art_qte = 10 WHERE art_code IN ('001', '002');
UPDATE Fiches_Art SET art_qte = 0 WHERE art_code = '003';
UPDATE Fiches_Art SET art_stocke = 1 WHERE art_code IN ('001', '002', '003');
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES
('1', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', ''),
('2', '002', 10.00, 7.00, '2018-06-01', 1, NULL, 'Produit 7.00', ''),
('3', '003', 0.00, 0.00, '2018-06-01', 1, NULL, 'produit 20.00', '');
UPDATE Fiches_Art SET art_qte = 8 WHERE art_code = '001';
INSERT INTO Fiches_Bl (numbl, type, datebl, cdclibl, nmclibl) VALUES ('B000901', 'B', '2018-06-10 09:00:00', '411000', 'VENTE APRES GENERATION');
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, libel_ligbl, qte_ligbl, dte_ligbl, typel_ligbl) VALUES ('B000901', '1', '001', 'Produit 2.10', '2', '2018-06-10', 'A');
