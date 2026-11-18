-- Jeu VALIDINVT-T12 : invt_compte + stock par dépôt de 001 et 002 (dépôts 01 et 02).
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
INSERT INTO Fiches_StkDepots (coded, codea, qte) VALUES
('01', '001', 6.000),
('02', '001', 4.000),
('01', '002', 10.000);
