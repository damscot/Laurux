-- Jeu ecartst_shared : Quantités décimales, art_dec/art_nbd 0/2/3, PA et PMP à 3 décimales : lignes 1-3 comptées, 4-6 non comptées.
-- Généré par ecarts_shared/gen_editions_inv.py.
-- Articles 001 à 003 de Laurux01 : stockés, stocks connus.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code IN ('001', '002', '003');
-- Décimales : 001 art_dec 0 / art_nbd 0, 002 art_dec 2 / art_nbd 2, 003 art_dec 3 / art_nbd 3 ; PA à 3 décimales.
UPDATE Fiches_Art SET art_dec = '0', art_nbd = '0', art_paht = 1.235, art_pmp = 1.115 WHERE art_code = '001';
UPDATE Fiches_Art SET art_dec = '2', art_nbd = '2', art_paht = 2.505, art_pmp = 2.345 WHERE art_code = '002';
UPDATE Fiches_Art SET art_dec = '3', art_nbd = '3', art_paht = 0.333, art_pmp = 0.667 WHERE art_code = '003';
-- Structure de Fiches_InvT : GeninvT.class.
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
('1', '001', 10, 12, '2018-06-01', 1, 'Produit 2.10', ''),
('2', '002', 7.25, 5.5, '2018-06-01', 1, 'Produit 7.00', ''),
('3', '003', 3.12, 4.57, '2018-06-01', 1, 'produit 20.00', ''),
('4', '001', 4, 0, '2018-06-01', 0, 'Produit 2.10', ''),
('5', '002', 2.75, 0, '2018-06-01', 0, 'Produit 7.00', ''),
('6', '003', 1.33, 0, '2018-06-01', 0, 'produit 20.00', '');
