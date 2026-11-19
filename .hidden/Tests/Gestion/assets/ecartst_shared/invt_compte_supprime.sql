-- Jeu ecartst_shared : Ligne 2 comptée portant l'article supprimé 999 (lignes 1 et 3 comptées).
-- Généré par ecarts_shared/gen_editions_inv.py.
-- Articles 001 à 003 de Laurux01 : stockés, stocks connus.
UPDATE Fiches_Art SET art_stocke = 1, art_qte = 10, art_stkdep = 10 WHERE art_code IN ('001', '002', '003');
-- Structure de Fiches_InvT : GeninvT.class.
DROP TABLE IF EXISTS Fiches_InvT;
CREATE TABLE Fiches_InvT (inv_nlig char(9) NOT NULL, inv_code char(15), inv_qtestock decimal(12,2),
 inv_qtecomptee decimal(12,2), inv_date date, inv_comptee tinyint, inv_valid int, inv_design varchar(50),
 inv_casier char(8), lind int NOT NULL AUTO_INCREMENT, PRIMARY KEY (lind)) ENGINE=InnoDB;
INSERT INTO Fiches_InvT (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
('1', '001', 10, 12, '2018-06-01', 1, 'Produit 2.10', ''),
('2', '999', 4, 6, '2018-06-01', 1, 'Article supprime', ''),
('3', '003', 10, 9, '2018-06-01', 1, 'produit 20.00', '');
