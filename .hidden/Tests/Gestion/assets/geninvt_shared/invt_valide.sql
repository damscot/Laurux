-- Jeu GENINVT : inventaire tournant marqué validé (inv_valid = 1, validation interrompue).
-- Articles stockés : 001 (fam 01, four 401001, casier 20, stock 10), 002 (fam 02, four 401002, casier 10, stock 7),
-- 003 (fam 03, four 401001, casier 30, stock 0) ; 004 copie de 003 non stockée (fam 03, casier 15, exclue).
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_casier = '20', art_four = '401001' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7, art_casier = '10', art_four = '401002' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_casier = '30', art_four = '401001' WHERE art_code = '003';
CREATE TEMPORARY TABLE tmp_geninvt AS SELECT * FROM Fiches_Art WHERE art_code = '003';
UPDATE tmp_geninvt SET art_code = '004', art_design = 'Produit non stocke', art_stocke = 0, art_casier = '15', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_geninvt;
DROP TEMPORARY TABLE tmp_geninvt;
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES
('1', '003', 0.00, 4.00, '2018-06-01', 1, 1, 'produit 20.00', '30'),
('2', '001', 10.00, 12.00, '2018-06-01', 1, 1, 'Produit 2.10', '20'),
('3', '002', 7.00, 0.00, '2018-06-01', 0, 1, 'Produit 7.00', '10');
