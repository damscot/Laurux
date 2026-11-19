-- Jeu GENINV-T14 : inventaire généré (lignes 1 à 3) dont l'article 002 n'existe plus dans Fiches_Art.
-- Structure de Fiches_Inv : Geninv.class (CREATE TABLE, l. 94-104).
CREATE TABLE Fiches_Inv (inv_nlig char(9) NOT NULL, inv_code Char(15), inv_qtestock Decimal(12,2),
  inv_qtecomptee Decimal(12,2), inv_date date, inv_comptee TINYINT, inv_valid Integer,
  inv_design VARCHAR(50), inv_casier Char(8), PRIMARY KEY (inv_nlig)) ENGINE = InnoDB;
INSERT INTO Fiches_Inv (inv_nlig, inv_code, inv_qtestock, inv_qtecomptee, inv_date, inv_comptee, inv_design, inv_casier) VALUES
 ('1', '001', 10, 0, '2018-06-15', 0, 'Produit 2.10', ''),
 ('2', '002', 10, 0, '2018-06-15', 0, 'Produit 7.00', ''),
 ('3', '003', 0, 0, '2018-06-15', 0, 'produit 20.00', '');
DELETE FROM Fiches_Art WHERE art_code = '002';
