-- Jeu de données PRODCOMPOSES-T01 à T06 : produits composés PC1 et PC2 (art_prdcomp = 1), composants A1-A3
-- (PMP et prix de revient non nuls, art_dec différents), lignes Fiches_PrdComp (articles et MO 04 pour PC1 ;
-- PC2 avec un composant ZZ9 absent de Fiches_Art), un BL non facturé contenant A1.
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_four, art_tva, art_pvht, art_pvttc, art_pmp, art_prvt, art_pbht, art_pauaht, art_coef, art_dec, art_prdcomp) VALUES
('PC1', 'Produit compose 1', '10', '401001', '3', 100, 120, 0, 0, 0, 0, 1.5, '0', 1),
('PC2', 'Produit compose 2', '10', '401001', '3', 50, 60, 7, 8, 7, 7, 1.5, '0', 1),
('A1', 'Composant A1', '10', '401001', '3', 10, 12, 4.5, 5, 4.5, 4.5, 2, '2', 0),
('A2', 'Composant A2', '10', '401001', '3', 20, 24, 8.25, 9, 8.25, 8.25, 2, '0', 0),
('A3', 'Composant A3', '10', '401001', '3', 30, 36, 12, 13, 12, 12, 2, '1', 0);
INSERT INTO Fiches_PrdComp (codep, codec, libelle, qte, mo) VALUES
('PC1', 'A1', 'Composant A1', '2', 0),
('PC1', 'A2', 'Composant A2', '1', 0),
('PC1', '04', 'Forfait changement poulie', '1', 1),
('PC2', 'A1', 'Composant A1', '1', 0),
('PC2', 'ZZ9', 'Article supprime', '1', 0);
INSERT INTO Fiches_Ligbl (num_ligbl, numlig_ligbl, code_ligbl, typel_ligbl) VALUES ('000902', '1', 'A1', 'A');
