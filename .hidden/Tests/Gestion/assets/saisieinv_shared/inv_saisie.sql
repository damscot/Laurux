-- Jeu SAISIEINV : articles du jeu geninv_shared/inv_gen_articles (copie), inventaire généré au 15/06/2018 (tri casier, code)
-- avec la ligne 1 (002) comptée 5 et la ligne 3 (001) comptée 0 (inv_comptee = 1) ; code-barres 2000000000053 → 005,
-- référence centrale RC002 → 002, code équivalent EQ004 → 004. Articles 004 à 007 copiés de 001.
CREATE TEMPORARY TABLE tmp_art AS SELECT * FROM Fiches_Art WHERE art_code = '001';
UPDATE tmp_art SET art_code = '004', art_design = 'Ecrou', art_cbarre = '', art_cequ = 'EQ004', art_refcentrale = 'RC004';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '005', art_design = 'Boulon', art_cbarre = '2000000000053', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '006', art_design = 'Agrafe', art_cbarre = '', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
UPDATE tmp_art SET art_code = '007', art_design = 'Article non stocke', art_cbarre = '', art_cequ = '', art_refcentrale = '';
INSERT INTO Fiches_Art SELECT * FROM tmp_art;
DROP TEMPORARY TABLE tmp_art;
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '03', art_four = '401002', art_casier = 'B1', art_qte = 10, art_dec = '0' WHERE art_code = '001';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '01', art_four = '401003', art_casier = 'A1', art_qte = 4, art_dec = '2' WHERE art_code = '002';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '02', art_four = '401001', art_casier = 'C1', art_qte = 2.5, art_dec = '2' WHERE art_code = '003';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '01', art_four = '401002', art_casier = 'C1', art_qte = 7, art_dec = '3' WHERE art_code = '004';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '03', art_four = '401001', art_casier = 'A1', art_qte = 3, art_dec = '0' WHERE art_code = '005';
UPDATE Fiches_Art SET art_stocke = 1, art_fam = '02', art_four = '401003', art_casier = 'B1', art_qte = 6, art_dec = '0' WHERE art_code = '006';
UPDATE Fiches_Art SET art_stocke = 0, art_fam = '01', art_four = '401001', art_casier = 'A1', art_qte = 9 WHERE art_code = '007';
UPDATE Fiches_Art SET art_refcentrale = 'RC002' WHERE art_code = '002';
UPDATE Fiches_Art SET art_refcentrale = '' WHERE art_code = '004';
INSERT INTO Fiches_CdBarre (codep, codeb) VALUES ('005', '2000000000053');
-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
 ('1', '002', 4, 5, '2018-06-15', 1, 'Produit 7.00', 'A1'),
 ('2', '005', 3, 0, '2018-06-15', 0, 'Boulon', 'A1'),
 ('3', '001', 10, 0, '2018-06-15', 1, 'Produit 2.10', 'B1'),
 ('4', '006', 6, 0, '2018-06-15', 0, 'Agrafe', 'B1'),
 ('5', '003', 2.5, 0, '2018-06-15', 0, 'produit 20.00', 'C1'),
 ('6', '004', 7, 0, '2018-06-15', 0, 'Ecrou', 'C1');
