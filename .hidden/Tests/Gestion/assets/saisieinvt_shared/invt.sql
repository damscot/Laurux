-- Jeu SAISIEINVT : inventaire tournant du 01/06/2018 en cours. Lignes : 1 = 003 (stock 0, non compté),
-- 2 = 001 (stock 10, compté 12), 3 = 002 (stock 7, non compté). 003 a le code équivalent EQ3, 001 la référence
-- centrale RC1 ; 004 stocké absent de l'inventaire.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10 WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7 WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 0, art_cequ = 'EQ3' WHERE art_code = '003';
UPDATE Fiches_Art SET art_refcentrale = 'RC1', art_centrale = '01' WHERE art_code = '001';
CREATE TEMPORARY TABLE tmp_saisieinvt AS SELECT * FROM Fiches_Art WHERE art_code = '002';
UPDATE tmp_saisieinvt SET art_code = '004', art_design = 'Produit hors inventaire', art_cbarre = '', art_cequ = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_saisieinvt;
DROP TEMPORARY TABLE tmp_saisieinvt;
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_valid, inv_design, inv_casier) VALUES
('1', '003', 0.00, 0.00, '2018-06-01', 0, NULL, 'produit 20.00', ''),
('2', '001', 10.00, 12.00, '2018-06-01', 1, NULL, 'Produit 2.10', ''),
('3', '002', 7.00, 0.00, '2018-06-01', 0, NULL, 'Produit 7.00', '');
