-- Jeu VALIDINV-T09 : inventaire compté (inv_fin_compte) + historique des inventaires tournants non vide.
-- Articles 004 et 005 copiés de 001 ; stocks connus ; dteinv de départ au 01/01/2018.
CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '001';
UPDATE tmp_art SET art_code = '004', art_design = 'Produit inventaire 4', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '005', art_design = 'Produit inventaire 5', art_cbarre = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 5, art_stkdep = 5 WHERE art_code = '003';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 7, art_stkdep = 7 WHERE art_code = '004';
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 8, art_stkdep = 6 WHERE art_code = '005';
UPDATE Fiches_Parametres SET dteinv = '2018-01-01';
-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
 ('1', '001', 10, 15, '2018-06-10', 1, 'Produit 2.10', ''),
 ('2', '002', 10, 4, '2018-06-10', 1, 'Produit 7.00', ''),
 ('3', '003', 5, 5, '2018-06-10', 1, 'produit 20.00', ''),
 ('4', '004', 7, 2.5, '2018-06-10', 1, 'Produit inventaire 4', ''),
 ('5', '005', 6, 9, '2018-06-10', 1, 'Produit inventaire 5', '');
INSERT INTO Fiches_HisInvT (inv_num, inv_code, inv_qtestock, inv_qtecomptee, inv_date) VALUES
 (1, '001', 9, 10, '2018-03-01'), (1, '002', 11, 10, '2018-03-01'), (2, '003', 5, 5, '2018-05-02');
