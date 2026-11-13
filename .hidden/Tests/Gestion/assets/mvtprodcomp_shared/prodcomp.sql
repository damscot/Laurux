-- MvtProdcomp : produit composé PC1 (composants CP1 qté 2, CP2 qté 0,5), article simple stocké SIM,
-- article non stocké NS1, second produit composé PC2 (CP1 qté 1), code-barre 3760000000017 de PC1, mouvement Fiches_Mvtexpdc préexistant (mind 41).
INSERT INTO Fiches_Art (art_code, art_design, art_fam, art_dec, art_stocke, art_qte, art_prdcomp, art_pvht, art_pvttc, art_tva) VALUES
('PC1', 'Produit compose', '01', '2', 1, 10, 1, 50, 60, '1'),
('CP1', 'Composant entier', '01', '0', 1, 100, 0, 5, 6, '1'),
('CP2', 'Composant decimal', '01', '2', 1, 50, 0, 3, 3.6, '1'),
('SIM', 'Article simple', '01', '2', 1, 20, 0, 4, 4.8, '1'),
('NS1', 'Article non stocke', '01', '2', 0, 0, 0, 4, 4.8, '1'),
('PC2', 'Second produit compose', '01', '2', 1, 5, 1, 20, 24, '1');
INSERT INTO Fiches_PrdComp (codep, codec, libelle, qte, mo) VALUES
('PC1', 'CP1', 'Composant entier', '2', 0),
('PC1', 'CP2', 'Composant decimal', '0,5', 0),
('PC2', 'CP1', 'Composant entier', '1', 0);
INSERT INTO Fiches_CdBarre (codep, codeb) VALUES ('PC1', '3760000000017');
INSERT INTO Fiches_Mvtexpdc (id, mind, code, daterecpt, qtep, qtem, com, type) VALUES
(1, 41, 'PC1', '2018-05-02 00:00:00', '1,00', '0', 'Entrée produit composé', 'P');
