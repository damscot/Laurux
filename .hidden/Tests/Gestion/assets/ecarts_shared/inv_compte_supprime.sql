-- Jeu ecarts_shared : Ligne 2 comptée portant l'article supprimé 999 (lignes 1 et 3 comptées).
-- Généré par ecarts_shared/gen_editions_inv.py.
-- Articles 001 à 003 de Laurux01 : stockés, stocks connus.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code IN ('001', '002', '003');
-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
DROP TABLE IF EXISTS Fiches_Inv;
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
('1', '001', 10, 12, '2018-06-10', 1, 'Produit 2.10', ''),
('2', '999', 4, 6, '2018-06-10', 1, 'Article supprime', ''),
('3', '003', 10, 9, '2018-06-10', 1, 'produit 20.00', '');
