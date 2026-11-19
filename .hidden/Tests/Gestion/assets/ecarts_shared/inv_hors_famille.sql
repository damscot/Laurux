-- Jeu ecarts_shared : Article 002 compté dont la famille 99 n'existe pas dans Fiches_Fam (001, 002, 003 comptés).
-- Généré par ecarts_shared/gen_editions_inv.py.
-- Articles 001 à 003 de Laurux01 : stockés, stocks connus.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code IN ('001', '002', '003');
UPDATE Fiches_Art SET art_fam = '99' WHERE art_code = '002';
-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
DROP TABLE IF EXISTS Fiches_Inv;
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
('1', '001', 10, 12, '2018-06-10', 1, 'Produit 2.10', ''),
('2', '002', 10, 7, '2018-06-10', 1, 'Produit 7.00', ''),
('3', '003', 10, 10, '2018-06-10', 1, 'produit 20.00', '');
