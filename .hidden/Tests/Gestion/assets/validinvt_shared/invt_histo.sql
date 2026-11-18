-- Jeu VALIDINVT-T04 : invt_compte + un premier inventaire tournant historisé (inv_num 1, 01/03/2018).
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
INSERT INTO Fiches_HisInvT (inv_num, inv_code, inv_qtestock, inv_qtecomptee, inv_date) VALUES
(1, '001', 8.00, 9.00, '2018-03-01'),
(1, '002', 4.00, 4.00, '2018-03-01');
